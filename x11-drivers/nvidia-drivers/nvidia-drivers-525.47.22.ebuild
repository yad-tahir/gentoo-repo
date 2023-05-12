# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MODULES_OPTIONAL_USE="driver"
inherit desktop flag-o-matic linux-mod multilib readme.gentoo-r1 \
	systemd toolchain-funcs unpacker user-info

NV_KERNEL_MAX="6.3"
NV_PIN="525.116.03"

DESCRIPTION="NVIDIA Accelerated Graphics Driver"
HOMEPAGE="https://developer.nvidia.com/vulkan-driver"
SRC_URI="
	https://developer.nvidia.com/downloads/vulkan-beta-${PV//.}-linux
		-> NVIDIA-Linux-x86_64-${PV}.run
	$(printf "https://download.nvidia.com/XFree86/%s/%s-${NV_PIN}.tar.bz2 " \
		nvidia-{installer,modprobe,persistenced,settings,xconfig}{,})
	https://github.com/NVIDIA/open-gpu-kernel-modules/archive/refs/tags/${PV}.tar.gz
		-> open-gpu-kernel-modules-${PV}.tar.gz"
# nvidia-installer is unused but here for GPL-2's "distribute sources"
S="${WORKDIR}"

LICENSE="NVIDIA-r2 BSD BSD-2 GPL-2 MIT ZLIB curl openssl"
SLOT="0/vulkan"
KEYWORDS="-* ~amd64"
IUSE="+X abi_x86_32 abi_x86_64 +driver kernel-open persistenced +static-libs +tools wayland"
REQUIRED_USE="kernel-open? ( driver )"

COMMON_DEPEND="
	acct-group/video
	sys-libs/glibc
	X? ( x11-libs/libpciaccess )
	persistenced? (
		acct-user/nvpd
		net-libs/libtirpc:=
	)
	tools? (
		>=app-accessibility/at-spi2-core-2.46:2
		dev-libs/glib:2
		dev-libs/jansson:=
		media-libs/harfbuzz:=
		x11-libs/cairo
		x11-libs/gdk-pixbuf:2
		x11-libs/gtk+:3[X]
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXxf86vm
		x11-libs/pango
	)"
RDEPEND="
	${COMMON_DEPEND}
	X? (
		media-libs/libglvnd[X,abi_x86_32(-)?]
		x11-libs/libX11[abi_x86_32(-)?]
		x11-libs/libXext[abi_x86_32(-)?]
	)
	wayland? (
		gui-libs/egl-gbm
		>=gui-libs/egl-wayland-1.1.10
		media-libs/libglvnd
	)"
DEPEND="
	${COMMON_DEPEND}
	static-libs? (
		x11-libs/libX11
		x11-libs/libXext
	)
	tools? (
		media-libs/libglvnd
		sys-apps/dbus
		x11-base/xorg-proto
		x11-libs/libXrandr
		x11-libs/libXv
		x11-libs/libvdpau
	)"
BDEPEND="
	sys-devel/m4
	virtual/pkgconfig"

QA_PREBUILT="lib/firmware/* opt/bin/* usr/lib*"

PATCHES=(
	"${FILESDIR}"/nvidia-kernel-module-source-515.86.01-raw-ldflags.patch
	"${FILESDIR}"/nvidia-modprobe-390.141-uvm-perms.patch
	"${FILESDIR}"/nvidia-settings-390.144-desktop.patch
	"${FILESDIR}"/nvidia-settings-390.144-raw-ldflags.patch
)

pkg_setup() {
	use driver || return

	local CONFIG_CHECK="
		PROC_FS
		~DRM_KMS_HELPER
		~SYSVIPC
		~!LOCKDEP
		~!SLUB_DEBUG_ON
		~!X86_KERNEL_IBT
		!DEBUG_MUTEXES"
	local ERROR_DRM_KMS_HELPER="CONFIG_DRM_KMS_HELPER: is not set but needed for Xorg auto-detection
	of drivers (no custom config), and for wayland / nvidia-drm.modeset=1.
	Cannot be directly selected in the kernel's menuconfig, and may need
	selection of a DRM device even if unused, e.g. CONFIG_DRM_AMDGPU=m or
	DRM_I915=y, DRM_NOUVEAU=m also acceptable if a module and not built-in."
	local ERROR_X86_KERNEL_IBT="CONFIG_X86_KERNEL_IBT: is set, be warned the modules may not load.
	If run into problems, either unset or try to pass ibt=off to the kernel."

	use amd64 && kernel_is -ge 5 8 && CONFIG_CHECK+=" X86_PAT" #817764

	use kernel-open && CONFIG_CHECK+=" MMU_NOTIFIER" #843827
	local ERROR_MMU_NOTIFIER="CONFIG_MMU_NOTIFIER: is not set but needed to build with USE=kernel-open.
	Cannot be directly selected in the kernel's menuconfig, and may need
	selection of another option that requires it such as CONFIG_KVM."

	MODULE_NAMES="
		nvidia(video:kernel)
		nvidia-drm(video:kernel)
		nvidia-modeset(video:kernel)
		nvidia-peermem(video:kernel)
		nvidia-uvm(video:kernel)"
	use kernel-open &&
		MODULE_NAMES=${MODULE_NAMES//:kernel/:kernel-module-source:kernel-module-source/kernel-open}

	linux-mod_pkg_setup

	[[ ${MERGE_TYPE} == binary ]] && return

	# do some extra checks manually as it gets messy to handle builtin-only
	# and some other conditional checks through CONFIG_CHECK
	# TODO?: maybe move other custom checks here for uniformity
	local warn=()

	if linux_chkconfig_builtin DRM_NOUVEAU; then
		# suggest =m given keeps KMS_HELPER enabled and can serve as fallback
		warn+=(
			"  CONFIG_DRM_NOUVEAU: is builtin (=y), and will prevent loading NVIDIA"
			"    modules (can be safely kept as a module (=m) instead)."
		)
	fi

	if linux_chkconfig_builtin DRM_SIMPLEDRM; then
		# wrt prebuilts, Fedora is pushing =y and gentoo-kernel-bin uses its
		# configs (bug #840439), but without Fedora's kernel patch to
		# workaround this issue (which is unlikely to work for us anyway)
		# https://github.com/NVIDIA/open-gpu-kernel-modules/issues/228
		warn+=(
			"  CONFIG_DRM_SIMPLEDRM: is builtin (=y), and may conflict with NVIDIA"
			"    (i.e. blanks when X/wayland starts, and tty loses display)."
			"    For prebuilt kernels, unfortunately no known good workarounds."
		)
	fi

	if ! linux_chkconfig_present FB_EFI &&
		! linux_chkconfig_present FB_SIMPLE &&
		! linux_chkconfig_present FB_VESA
	then
		# nvidia-drivers does not handle the tty (beside mode restoration) but,
		# given few options are viable, try to warn if all missing
		warn+=(
			"  CONFIG_FB_(EFI|SIMPLE|VESA): none set, but note at least one is normally"
			"    needed to get a display for the tty console. In most cases, it is"
			"    recommended to enable FB_EFI=y and disable FB_SIMPLE (can be quirky)."
			"    Non-EFI systems are likely to want FB_VESA=y. Users with multiple GPUs"
			"    or not using the tty may be able to safely ignore this warning."
		)
	fi

	if kernel_is -ge 5 18 13; then
		if linux_chkconfig_present FB_SIMPLE; then
			warn+=(
				"  CONFIG_FB_SIMPLE: is set, recommended to disable and switch to FB_EFI or"
				"    FB_VESA as it currently may be broken with >=kernel-5.18.13 + NVIDIA:"
				"    https://github.com/NVIDIA/open-gpu-kernel-modules/issues/341"
				"    (feel free to ignore this if it works for you)"
			)
		fi

		if linux_chkconfig_present SYSFB_SIMPLEFB &&
			{ linux_chkconfig_present FB_EFI || linux_chkconfig_present FB_VESA; }
		then
			warn+=(
				"  CONFIG_SYSFB_SIMPLEFB: is set, this may prevent FB_EFI or FB_VESA"
				"    from providing a working tty console display (ignore if unused)."
			)
		fi
	fi

	(( ${#warn[@]} )) &&
		ewarn "Detected potential configuration issues with used kernel:${warn[*]/#/$'\n'}"

	BUILD_PARAMS='NV_VERBOSE=1 IGNORE_CC_MISMATCH=yes SYSSRC="${KV_DIR}" SYSOUT="${KV_OUT_DIR}"'
	BUILD_TARGETS="modules"

	# Try to match toolchain with kernel only for modules
	# (experimental, ideally this should be handled in linux-mod.eclass)
	nvidia-tc-set() {
		local -n var=KERNEL_${1}
		if [[ ! -v var ]]; then
			read -r var < <(type -P "${@:2}") ||
				die "failed to find in PATH at least one of: ${*:2}"
			einfo "Forcing '${var}' for modules (set ${!var} to override)"
		fi
	}

	local tool switch
	if linux_chkconfig_present CC_IS_GCC; then
		if ! tc-is-gcc; then
			switch=
			nvidia-tc-set CC {${CHOST}-,}gcc
			nvidia-tc-set CXX {${CHOST}-,}g++ # needed by kernel-open
		fi
	elif linux_chkconfig_present CC_IS_CLANG; then
		ewarn "Warning: using ${PN} with a clang-built kernel is largely untested"
		if ! tc-is-clang; then
			switch=llvm-
			nvidia-tc-set CC {${CHOST}-,}clang
			nvidia-tc-set CXX {${CHOST}-,}clang++
		fi
	fi

	if linux_chkconfig_present LD_IS_BFD; then
		# tc-ld-is-bfd needs https://github.com/gentoo/gentoo/pull/28355
		[[ $(LC_ALL=C $(tc-getLD) --version 2>/dev/null) == "GNU ld"* ]] ||
			nvidia-tc-set LD {${CHOST}-,}{ld.bfd,ld}
	elif linux_chkconfig_present LD_IS_LLD; then
		tc-ld-is-lld || nvidia-tc-set LD {${CHOST}-,}{ld.lld,lld}
	fi

	if [[ -v switch ]]; then
		# only need llvm-nm for lto, but use complete set to be safe
		for tool in AR NM OBJCOPY OBJDUMP READELF STRIP; do
			case $(LC_ALL=C $(tc-get${tool}) --version 2>/dev/null) in
				LLVM*|llvm*) [[ ! ${switch} ]];;
				*) [[ ${switch} ]];;
			esac && nvidia-tc-set ${tool} {${CHOST}-,}${switch}${tool,,}
		done
	fi

	# pass unconditionally given exports are semi-ignored except CC/LD
	for tool in CC CXX LD AR NM OBJCOPY OBJDUMP READELF STRIP; do
		BUILD_PARAMS+=" ${tool}=\"\${KERNEL_${tool}:-\$(tc-get${tool})}\""
	done

	if linux_chkconfig_present LTO_CLANG_THIN; then
		# kernel enables cache by default leading to sandbox violations
		BUILD_PARAMS+=' ldflags-y=--thinlto-cache-dir= LDFLAGS_MODULE=--thinlto-cache-dir='
	fi

	if kernel_is -gt ${NV_KERNEL_MAX/./ }; then
		ewarn "Kernel ${KV_MAJOR}.${KV_MINOR} is either known to break this version of ${PN}"
		ewarn "or was not tested with it. It is recommended to use one of:"
		ewarn "  <=sys-kernel/gentoo-kernel-${NV_KERNEL_MAX}.x"
		ewarn "  <=sys-kernel/gentoo-sources-${NV_KERNEL_MAX}.x"
		ewarn "You are free to try or use /etc/portage/patches, but support will"
		ewarn "not be given and issues wait until NVIDIA releases a fixed version"
		ewarn "(Gentoo will not accept patches for this)."
		ewarn
		ewarn "Do _not_ file a bug report if run into issues."
		ewarn
	fi
}

src_prepare() {
	# make patches usable across versions
	rm nvidia-modprobe && mv nvidia-modprobe{-${NV_PIN},} || die
	rm nvidia-persistenced && mv nvidia-persistenced{-${NV_PIN},} || die
	rm nvidia-settings && mv nvidia-settings{-${NV_PIN},} || die
	rm nvidia-xconfig && mv nvidia-xconfig{-${NV_PIN},} || die
	mv open-gpu-kernel-modules-${PV} kernel-module-source || die

	default

	# prevent detection of incomplete kernel DRM support (bug #603818)
	sed 's/defined(CONFIG_DRM/defined(CONFIG_DRM_KMS_HELPER/g' \
		-i kernel{,-module-source/kernel-open}/conftest.sh || die

	# adjust service files
	sed 's/__USER__/nvpd/' \
		nvidia-persistenced/init/systemd/nvidia-persistenced.service.template \
		> "${T}"/nvidia-persistenced.service || die
	use !amd64 || sed -i "s|/usr|${EPREFIX}/opt|" systemd/system/nvidia-powerd.service || die

	# enable nvidia-drm.modeset=1 by default with USE=wayland
	cp "${FILESDIR}"/nvidia-470.conf "${T}"/nvidia.conf || die
	use !wayland || sed -i '/^#.*modeset=1$/s/^#//' "${T}"/nvidia.conf || die

	# makefile attempts to install wayland library even if not built
	use wayland || sed -i 's/ WAYLAND_LIB_install$//' \
		nvidia-settings/src/Makefile || die

	# temporary option, nvidia will remove in the future
	use !kernel-open ||
		sed -i '/blacklist/a\
\
# Enable using kernel-open with workstation GPUs (experimental)\
options nvidia NVreg_OpenRmEnableUnsupportedGpus=1' "${T}"/nvidia.conf || die
}

src_compile() {
	tc-export AR CC CXX LD OBJCOPY OBJDUMP
	local -x RAW_LDFLAGS="$(get_abi_LDFLAGS) $(raw-ldflags)" # raw-ldflags.patch

	local xnvflags=-fPIC #840389
	# lto static libraries tend to cause problems without fat objects
	is-flagq '-flto@(|=*)' && xnvflags+=" $(test-flags-CC -ffat-lto-objects)"

	NV_ARGS=(
		PREFIX="${EPREFIX}"/usr
		HOST_CC="$(tc-getBUILD_CC)"
		HOST_LD="$(tc-getBUILD_LD)"
		BUILD_GTK2LIB=
		NV_USE_BUNDLED_LIBJANSSON=0
		NV_VERBOSE=1 DO_STRIP= MANPAGE_GZIP= OUTPUTDIR=out
		WAYLAND_AVAILABLE=$(usex wayland 1 0)
		XNVCTRL_CFLAGS="${xnvflags}"
	)

	if use driver; then
		if linux_chkconfig_present GCC_PLUGINS; then
			mkdir "${T}"/plugin-test || die
			echo "obj-m += test.o" > "${T}"/plugin-test/Kbuild || die
			:> "${T}"/plugin-test/test.c || die
			if [[ $(LC_ALL=C make -C "${KV_OUT_DIR}" ARCH="$(tc-arch-kernel)" \
				HOSTCC="$(tc-getBUILD_CC)" CC="${CC}" M="${T}"/plugin-test 2>&1) \
				=~ "error: incompatible gcc/plugin version" ]]
			then
				eerror "Detected kernel was built with a different gcc/plugin version,"
				eerror "Please 'make clean' and rebuild your kernel with the current"
				eerror "gcc (or re-emerge for distribution kernels, including kernel-bin)."
				die "kernel ${KV_FULL} needs to be rebuilt"
			fi
		fi

		local o_cflags=${CFLAGS} o_cxxflags=${CXXFLAGS} o_ldflags=${LDFLAGS}
		if use kernel-open; then
			# building the nvidia "blob" fails with lto, and also need
			# to strip in case of a different toolchain for the kernel
			filter-lto
			strip-unsupported-flags
		fi
		linux-mod_src_compile
		CFLAGS=${o_cflags} CXXFLAGS=${o_cxxflags} LDFLAGS=${o_ldflags}
	fi

	emake "${NV_ARGS[@]}" -C nvidia-modprobe
	use persistenced && emake "${NV_ARGS[@]}" -C nvidia-persistenced
	use X && emake "${NV_ARGS[@]}" -C nvidia-xconfig

	if use tools; then
		# cflags: avoid noisy logs, only use here and set first to let override
		CFLAGS="-Wno-deprecated-declarations ${CFLAGS}" \
			emake "${NV_ARGS[@]}" -C nvidia-settings
	elif use static-libs; then
		# pretend GTK+3 is available, not actually used (bug #880879)
		emake "${NV_ARGS[@]}" BUILD_GTK3LIB=1 \
			-C nvidia-settings/src out/libXNVCtrl.a
	fi
}

src_install() {
	local libdir=$(get_libdir) libdir32=$(ABI=x86 get_libdir)

	NV_ARGS+=( DESTDIR="${D}" LIBDIR="${ED}"/usr/${libdir} )

	local -A paths=(
		[APPLICATION_PROFILE]=/usr/share/nvidia
		[CUDA_ICD]=/etc/OpenCL/vendors
		[EGL_EXTERNAL_PLATFORM_JSON]=/usr/share/egl/egl_external_platform.d
		[FIRMWARE]=/lib/firmware/nvidia/${PV}
		[GBM_BACKEND_LIB_SYMLINK]=/usr/${libdir}/gbm
		[GLVND_EGL_ICD_JSON]=/usr/share/glvnd/egl_vendor.d
		[VULKAN_ICD_JSON]=/usr/share/vulkan
		[WINE_LIB]=/usr/${libdir}/nvidia/wine
		[XORG_OUTPUTCLASS_CONFIG]=/usr/share/X11/xorg.conf.d

		[GLX_MODULE_SHARED_LIB]=/usr/${libdir}/xorg/modules/extensions
		[GLX_MODULE_SYMLINK]=/usr/${libdir}/xorg/modules
		[XMODULE_SHARED_LIB]=/usr/${libdir}/xorg/modules
	)

	local skip_files=(
		# nvidia_icd/layers(vulkan): skip with -X too as it uses libGLX_nvidia
		$(usev !X "
			libGLX_nvidia libglxserver_nvidia
			nvidia_icd.json nvidia_layers.json")
		$(usev !wayland libnvidia-vulkan-producer)
		libGLX_indirect # non-glvnd unused fallback
		libnvidia-{gtk,wayland-client} nvidia-{settings,xconfig} # from source
		libnvidia-egl-gbm 15_nvidia_gbm # gui-libs/egl-gbm
		libnvidia-egl-wayland 10_nvidia_wayland # gui-libs/egl-wayland
	)
	local skip_modules=(
		$(usev !X "nvfbc vdpau xdriver")
		$(usev !driver gsp)
		installer nvpd # handled separately / built from source
	)
	local skip_types=(
		GLVND_LIB GLVND_SYMLINK EGL_CLIENT.\* GLX_CLIENT.\* # media-libs/libglvnd
		OPENCL_WRAPPER.\* # virtual/opencl
		DOCUMENTATION DOT_DESKTOP .\*_SRC DKMS_CONF SYSTEMD_UNIT # handled separately / unused
	)

	local DOCS=(
		README.txt NVIDIA_Changelog supported-gpus/supported-gpus.json
		nvidia-settings/doc/{FRAMELOCK,NV-CONTROL-API}.txt
	)
	local HTML_DOCS=( html/. )
	einstalldocs

	local DISABLE_AUTOFORMATTING=yes
	local DOC_CONTENTS="\
Trusted users should be in the 'video' group to use NVIDIA devices.
You can add yourself by using: gpasswd -a my-user video\
$(usev driver "

Like all out-of-tree kernel modules, it is necessary to rebuild
${PN} after upgrading or rebuilding the Linux kernel
by for example running \`emerge @module-rebuild\`. Alternatively,
if using a distribution kernel (sys-kernel/gentoo-kernel{,-bin}),
this can be automated by setting USE=dist-kernel globally.

Loaded kernel modules also must not mismatch with the installed
${PN} version (excluding -r revision), meaning should
ensure \`eselect kernel list\` points to the kernel that will be
booted before building and preferably reboot after upgrading
${PN} (the ebuild will emit a warning if mismatching).

See '${EPREFIX}/etc/modprobe.d/nvidia.conf' for modules options.")\
$(use amd64 && usev !abi_x86_32 "

Note that without USE=abi_x86_32 on ${PN}, 32bit applications
(typically using wine / steam) will not be able to use GPU acceleration.")

For general information on using ${PN}, please see:
https://wiki.gentoo.org/wiki/NVIDIA/nvidia-drivers"
	readme.gentoo_create_doc

	if use driver; then
		linux-mod_src_install

		insinto /etc/modprobe.d
		doins "${T}"/nvidia.conf

		# used for gpu verification with binpkgs (not kept, see pkg_preinst)
		insinto /usr/share/nvidia
		doins supported-gpus/supported-gpus.json
	fi

	emake "${NV_ARGS[@]}" -C nvidia-modprobe install
	fowners :video /usr/bin/nvidia-modprobe #505092
	fperms 4710 /usr/bin/nvidia-modprobe

	if use persistenced; then
		emake "${NV_ARGS[@]}" -C nvidia-persistenced install
		newconfd "${FILESDIR}"/nvidia-persistenced.confd nvidia-persistenced
		newinitd "${FILESDIR}"/nvidia-persistenced.initd nvidia-persistenced
		systemd_dounit "${T}"/nvidia-persistenced.service
	fi

	if use tools; then
		emake "${NV_ARGS[@]}" -C nvidia-settings install

		doicon nvidia-settings/doc/nvidia-settings.png
		domenu nvidia-settings/doc/nvidia-settings.desktop

		exeinto /etc/X11/xinit/xinitrc.d
		newexe "${FILESDIR}"/95-nvidia-settings-r1 95-nvidia-settings
	fi

	if use static-libs; then
		dolib.a nvidia-settings/src/out/libXNVCtrl.a

		insinto /usr/include/NVCtrl
		doins nvidia-settings/src/libXNVCtrl/NVCtrl{Lib,}.h
	fi

	use X && emake "${NV_ARGS[@]}" -C nvidia-xconfig install

	# mimic nvidia-installer by reading .manifest to install files
	# 0:file 1:perms 2:type 3+:subtype/arguments -:module
	local m into
	while IFS=' ' read -ra m; do
		! [[ ${#m[@]} -ge 2 && ${m[-1]} =~ MODULE: ]] ||
			[[ " ${m[0]##*/}" =~ ^(\ ${skip_files[*]/%/.*|\\} )$ ]] ||
			[[ " ${m[2]}" =~ ^(\ ${skip_types[*]/%/|\\} )$ ]] ||
			has ${m[-1]#MODULE:} "${skip_modules[@]}" && continue

		case ${m[2]} in
			MANPAGE)
				gzip -dc ${m[0]} | newman - ${m[0]%.gz}; assert
				continue
			;;
			GBM_BACKEND_LIB_SYMLINK) m[4]=../${m[4]};; # missing ../
			VDPAU_SYMLINK) m[4]=vdpau/; m[5]=${m[5]#vdpau/};; # .so to vdpau/
		esac

		if [[ -v paths[${m[2]}] ]]; then
			into=${paths[${m[2]}]}
		elif [[ ${m[2]} =~ _BINARY$ ]]; then
			into=/opt/bin
		elif [[ ${m[3]} == COMPAT32 ]]; then
			use abi_x86_32 || continue
			into=/usr/${libdir32}
		elif [[ ${m[2]} =~ _LIB$|_SYMLINK$ ]]; then
			into=/usr/${libdir}
		else
			die "No known installation path for ${m[0]}"
		fi
		[[ ${m[3]: -2} == ?/ ]] && into+=/${m[3]%/}
		[[ ${m[4]: -2} == ?/ ]] && into+=/${m[4]%/}

		if [[ ${m[2]} =~ _SYMLINK$ ]]; then
			[[ ${m[4]: -1} == / ]] && m[4]=${m[5]}
			dosym ${m[4]} ${into}/${m[0]}
			continue
		fi
		[[ ${m[0]} =~ ^libnvidia-ngx.so|^libnvidia-egl-gbm.so ]] &&
			dosym ${m[0]} ${into}/${m[0]%.so*}.so.1 # soname not in .manifest

		printf -v m[1] %o $((m[1] | 0200)) # 444->644
		insopts -m${m[1]}
		insinto ${into}
		doins ${m[0]}
	done < .manifest || die

	# MODULE:installer non-skipped extras
	: "$(systemd_get_sleepdir)"
	exeinto "${_#"${EPREFIX}"}"
	doexe systemd/system-sleep/nvidia
	dobin systemd/nvidia-sleep.sh
	systemd_dounit systemd/system/nvidia-{hibernate,resume,suspend}.service

	dobin nvidia-bug-report.sh

	# MODULE:powerd extras
	if use amd64; then
		systemd_dounit systemd/system/nvidia-powerd.service

		insinto /usr/share/dbus-1/system.d
		doins nvidia-dbus.conf
	fi

	# symlink non-versioned so nvidia-settings can use it even if misdetected
	dosym nvidia-application-profiles-${PV}-key-documentation \
		${paths[APPLICATION_PROFILE]}/nvidia-application-profiles-key-documentation

	# don't attempt to strip firmware files (silences errors)
	dostrip -x ${paths[FIRMWARE]}
}

pkg_preinst() {
	has_version "${CATEGORY}/${PN}[wayland]" && NV_HAD_WAYLAND=

	use driver || return
	linux-mod_pkg_preinst

	# set video group id based on live system (bug #491414)
	local g=$(egetent group video | cut -d: -f3)
	[[ ${g} =~ ^[0-9]+$ ]] || die "Failed to determine video group id (got '${g}')"
	sed -i "s/@VIDEOGID@/${g}/" "${ED}"/etc/modprobe.d/nvidia.conf || die

	# try to find driver mismatches using temporary supported-gpus.json
	for g in $(grep -l 0x10de /sys/bus/pci/devices/*/vendor 2>/dev/null); do
		g=$(grep -io "\"devid\":\"$(<${g%vendor}device)\"[^}]*branch\":\"[0-9]*" \
			"${ED}"/usr/share/nvidia/supported-gpus.json 2>/dev/null)
		if [[ ${g} ]]; then
			g=$((${g##*\"}+1))
			if ver_test -ge ${g}; then
				NV_LEGACY_MASK=">=${CATEGORY}/${PN}-${g}"
				break
			fi
		fi
	done
	rm "${ED}"/usr/share/nvidia/supported-gpus.json || die
}

pkg_postinst() {
	linux-mod_pkg_postinst

	readme.gentoo_print_elog

	if [[ -r /proc/driver/nvidia/version &&
		$(</proc/driver/nvidia/version) != *"  ${PV}  "* ]]; then
		ewarn "Currently loaded NVIDIA modules do not match the newly installed"
		ewarn "libraries and may prevent launching GPU-accelerated applications."
		use driver && ewarn "The easiest way to fix this is usually to reboot."
	fi

	if [[ $(</proc/cmdline) == *slub_debug=[!-]* ]]; then
		ewarn "Detected that the current kernel command line is using 'slub_debug=',"
		ewarn "this may lead to system instability/freezes with this version of"
		ewarn "${PN}. Bug: https://bugs.gentoo.org/796329"
	fi

	if [[ -v NV_LEGACY_MASK ]]; then
		ewarn
		ewarn "***WARNING***"
		ewarn
		ewarn "You are installing a version of ${PN} known not to work"
		ewarn "with a GPU of the current system. If unwanted, add the mask:"
		if [[ -d ${EROOT}/etc/portage/package.mask ]]; then
			ewarn "  echo '${NV_LEGACY_MASK}' > ${EROOT}/etc/portage/package.mask/${PN}"
		else
			ewarn "  echo '${NV_LEGACY_MASK}' >> ${EROOT}/etc/portage/package.mask"
		fi
		ewarn "...then downgrade to a legacy[1] branch if possible (not all old versions"
		ewarn "are available or fully functional, may need to consider nouveau[2])."
		ewarn "[1] https://www.nvidia.com/object/IO_32667.html"
		ewarn "[2] https://wiki.gentoo.org/wiki/Nouveau"
	fi

	if use kernel-open; then
		ewarn
		ewarn "Open source variant of ${PN} was selected, be warned it is experimental"
		ewarn "and only usable with Turing / Ampere and later GPUs, aka GTX 1650+."
		ewarn "Please also see: ${EROOT}/usr/share/doc/${PF}/html/kernel_open.html"
		ewarn
		ewarn "Many features are not yet implemented in the drivers and limitations are"
		ewarn "to be expected. Please do not report non-build/packaging bugs to Gentoo."
		ewarn "Switch back to USE=-kernel-open to restore functionality if needed for now."
	fi

	if use wayland && use driver && [[ ! -v NV_HAD_WAYLAND ]]; then
		elog
		elog "With USE=wayland, this version of ${PN} sets nvidia-drm.modeset=1"
		elog "in '${EROOT}/etc/modprobe.d/nvidia.conf'. This feature is considered"
		elog "experimental but is required for wayland."
		elog
		elog "If you experience issues, either disable wayland or edit nvidia.conf."
		elog "Of note, may possibly cause issues with SLI and Reverse PRIME."
	fi
}
