# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="True Audio Compressor Software"
HOMEPAGE="http://tta.sourceforge.net"
SRC_URI="mirror://sourceforge/tta/${P}-src.tgz"
S="${WORKDIR}/${P}-src"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

PATCHES=(
	"${FILESDIR}"/${P}-fix-build-system.patch
	"${FILESDIR}"/${P}-fix-hybrid-filter.patch
	"${FILESDIR}"/${P}-fix-musl.patch
)

src_configure() {
	tc-export CC
}

src_install() {
	dobin ttaenc
	dodoc ChangeLog-${PV} README
}
