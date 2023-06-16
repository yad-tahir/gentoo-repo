# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit flag-o-matic toolchain-funcs versionator

MY_P=${PN}_$(replace_all_version_separators '_')

DESCRIPTION="DUMA (Detect Unintended Memory Access) is a memory debugging library"
HOMEPAGE="http://duma.sourceforge.net"
SRC_URI="mirror://sourceforge/duma/${MY_P}.tar.gz
	mirror://gentoo/${P}-GNUmakefile.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="examples"

S=${WORKDIR}/${MY_P}

PATCHES=(
	"${WORKDIR}"/${P}-GNUmakefile.patch
	"${FILESDIR}"/${P}-gcc6.patch
)

src_configure() {
	# other flags will break duma
	export CFLAGS="-O0 -Wall -Wextra -U_FORTIFY_SOURCE"
	tc-export AR CC CXX LD RANLIB

	# bug #789708
	append-cxxflags -std=c++14

	case "${CHOST}" in
		*-linux-gnu)
			OS=linux;;
		*-solaris*)
			OS=solaris;;
		*-darwin*)
			OS=osx;;
	esac
	export OS="${OS}"
	elog "Detected OS is: ${OS}"

	if use amd64 && ! [ -n "${DUMA_ALIGNMENT}" ]; then
		export DUMA_ALIGNMENT=16
		elog "Exported DUMA_ALIGNMENT=${DUMA_ALIGNMENT} for x86_64,"
	fi

}

src_compile() {
	# The below must be run first if distcc is enabled, otherwise
	# the real build breaks on parallel makes.
	emake reconfig
	emake
}

src_test() {
	emake test

	elog "Please, see the output above to verify all tests have passed."
	elog "Both static and dynamic confidence tests should say PASSED."
}

src_install() {
	emake prefix="${D}/usr" libdir="${D}/usr/$(get_libdir)" \
		docdir="${D}/usr/share/doc/${PF}" install

	sed -i "s|LD_PRELOAD=./libduma|LD_PRELOAD=libduma|" "${D}"/usr/bin/duma \
		|| die "sed failed"

	dodoc CHANGELOG TODO GNUmakefile

	if use examples; then
		docinto examples
		dodoc example[1-6].cpp example_makes/ex6/Makefile
	fi
}

pkg_postinst() {
	elog "See the GNUmakefile which will be also installed at"
	elog "/usr/share/doc/${PF} for more options. You can now export"
	elog "varibles to the build system easily, e.g.:"
	elog "# export CPPFLAGS=\"-DFLAG\" (or by using append-cppflags)"
	elog "# export DUMA_ALIGNMENT=${DUMA_ALIGNMENT} (Default is 16 for x86_64)"
	elog "See more information about DUMA_ALIGNMENT from Readme.txt"
}
