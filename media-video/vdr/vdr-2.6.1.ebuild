# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic strip-linguas toolchain-funcs user-info

DESCRIPTION="Video Disk Recorder - turns a pc into a powerful set top box for DVB"
HOMEPAGE="http://www.tvdr.de/"
SRC_URI="http://git.tvdr.de/?p=vdr.git;a=snapshot;h=refs/tags/${PV};sf=tbz2 -> ${P}.tbz2
	menuorg? ( https://github.com/vdr-projects/vdr-plugin-menuorg/raw/master/vdr-patch/vdr-menuorg-2.3.x.diff )
	ttxtsubs? ( https://md11.it.cx/download/${PN}/${PN}-2.6.1_ttxtsubs_v2.patch )"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~x86"
IUSE="bidi debug demoplugins html keyboard mainmenuhooks menuorg naludump permashift pinplugin systemd ttxtsubs verbose"

COMMON_DEPEND="
	acct-group/vdr
	acct-user/vdr
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libjpeg-turbo
	sys-libs/libcap"
DEPEND="${COMMON_DEPEND}
	>=virtual/linuxtv-dvb-headers-5.3"
RDEPEND="${COMMON_DEPEND}
	dev-lang/perl
	media-tv/gentoo-vdr-scripts
	media-fonts/corefonts
	bidi? ( dev-libs/fribidi )
	systemd? ( sys-apps/systemd )"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig"

REQUIRED_USE="permashift? ( !naludump !pinplugin )"

CONF_DIR="/etc/vdr"
CAP_FILE="${S}/capabilities.sh"
CAPS="# Capabilities of the vdr-executable for use by startscript etc."

pkg_setup() {
	use debug && append-flags -g

	PLUGIN_LIBDIR="/usr/$(get_libdir)/vdr/plugins"
	VIDEO_DIR="$(egethome vdr)/video"

	tc-export CC CXX AR
}

add_cap() {
	local arg
	for arg; do
		CAPS="${CAPS}\n${arg}=1"
	done
}

lang_po() {
	LING_PO=$( ls ${S}/po | sed -e "s:.po::g" | cut -d_ -f1 | tr \\\012 ' ' )
}

src_prepare() {
	# apply maintenance-patches
	ebegin "Changing paths for gentoo"

	local DVBDIR=/usr/include
	local i
	for i in ${DVB_HEADER_PATH} /usr/include/v4l-dvb-hg /usr/include; do
		[[ -d ${i} ]] || continue
		if [[ -f ${i}/linux/dvb/dmx.h ]]; then
			einfo "Found DVB header files in ${i}"
			DVBDIR=${i}
			break
		fi
	done

	# checking for s2api headers
	local api_version
	api_version=$(awk -F' ' '/define DVB_API_VERSION / {print $3}' "${DVBDIR}"/linux/dvb/version.h)
	api_version=${api_version}*$(awk -F' ' '/define DVB_API_VERSION_MINOR / {print $3}' "${DVBDIR}"/linux/dvb/version.h)

	if [[ ${api_version:-0} -lt 5*3 ]]; then
		eerror "DVB header files do not contain s2api support or too old for ${P}"
		eerror "You cannot compile VDR against old dvb-header"
		die "DVB headers too old"
	fi

	cat > Make.config <<-EOT || die "cannot write to Make.config"
		#
		# Generated by ebuild ${PF}
		#
		PREFIX			= /usr
		DVBDIR			= ${DVBDIR}
		PLUGINLIBDIR	= ${PLUGIN_LIBDIR}
		CONFDIR			= ${CONF_DIR}
		ARGSDIR			= \$(CONFDIR)/conf.d
		VIDEODIR		= ${VIDEO_DIR}
		LOCDIR			= \$(PREFIX)/share/locale
		INCDIR			= \$(PREFIX)/include

		DEFINES			+= -DCONFDIR=\"\$(CONFDIR)\"
		INCLUDES		+= -I\$(DVBDIR)

		# >=vdr-1.7.36-r1; parameter only used for compiletime on vdr
		# PLUGINLIBDIR (plugin Makefile old) = LIBDIR (plugin Makefile new)
		LIBDIR			= ${PLUGIN_LIBDIR}
		PCDIR			= /usr/$(get_libdir)/pkgconfig

	EOT
	eend 0

	eapply "${FILESDIR}/${PN}-2.4.6_gentoo.patch"
	use demoplugins || eapply "${FILESDIR}/vdr-2.4_remove_plugins.patch"
	eapply "${FILESDIR}/${PN}-2.4.6_makefile-variables.patch"

	# fix clang/LLVM compile
	eapply "${FILESDIR}/${PN}-2.4.6_clang.patch"

	use naludump && eapply "${FILESDIR}/${P}_naludump.patch"
	use permashift && eapply "${FILESDIR}/${P}-patch-for-permashift.patch"
	use pinplugin && eapply "${FILESDIR}/${P}_pinplugin.patch"
	use ttxtsubs && eapply "${DISTDIR}/${P}_ttxtsubs_v2.patch"
	use menuorg && eapply "${DISTDIR}/vdr-menuorg-2.3.x.diff"
	use mainmenuhooks && eapply "${FILESDIR}/${PN}-2.4.1_mainmenuhook-1.0.1.patch"

	add_cap CAP_UTF8 \
		CAP_IRCTRL_RUNTIME_PARAM \
		CAP_VFAT_RUNTIME_PARAM \
		CAP_CHUID \
		CAP_SHUTDOWN_AUTO_RETRY

	echo -e ${CAPS} > "${CAP_FILE}" || die "cannot write to CAP_FILE"

	# LINGUAS support
	einfo "\n \t VDR supports the LINGUAS values"

	lang_po

	einfo "\t Please set one of this values in your sytem make.conf"
	einfo "\t LINGUAS=\"${LING_PO}\"\n"

	if [[ -z ${LINGUAS} ]]; then
		einfo "\n \t No values in LINGUAS="
		einfo "\t You will get only english text on OSD \n"
	fi

	strip-linguas ${LING_PO} en

	default
}

src_configure() {
	# support languages, written from right to left
	export "BIDI=$(usex bidi 1 0)"
	# systemd notification support
	export "SDNOTIFY=$(usex systemd 1 0)"
	# with/without keyboard
	export "USE_KBD=$(usex keyboard 1 0)"
	# detailed compile output for debug
	export "VERBOSE=$(usex verbose 1 0)"
}

src_install() {
	# trick the makefile to not create a VIDEODIR by supplying it with an
	# existing directory
	emake VIDEODIR="/" DESTDIR="${ED}" install

	keepdir "${PLUGIN_LIBDIR}"

	# backup for plugins they don't be able to create this dir
	keepdir "${CONF_DIR}/plugins"

	if use html; then
		local HTML_DOCS=( *.html )
	fi
	local DOCS=( MANUAL INSTALL README* HISTORY CONTRIBUTORS UPDATE-2* )
	einstalldocs

	insinto /usr/share/vdr
	doins "${CAP_FILE}"

	fowners vdr:vdr "${CONF_DIR}" -R
}

pkg_postinst() {
	elog "Please read the /usr/share/doc/${PF}/UPDATE-2.4"
	elog "for major changes in this version\n"

	elog "It is a good idea to run vdrplugin-rebuild now.\n"

	elog "To get nice symbols in OSD we recommend to install"
	elog "\t1. emerge media-fonts/vdrsymbols-ttf"
	elog "\t2. select font VDRSymbolsSans in Setup\n"

	elog "To get an idea how to proceed now, have a look at our vdr-guide:"
	elog "\thttps://wiki.gentoo.org/wiki/VDR"
}
