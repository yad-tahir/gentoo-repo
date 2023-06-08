# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P=fortune-mod-thomas.ogrisegg-${PV}
DESCRIPTION="Quotes from Thomas Ogrisegg"
HOMEPAGE="http://fortune-mod-fvl.sourceforge.net/"
SRC_URI="mirror://sourceforge/fortune-mod-fvl/${MY_P}.tar.gz"
S="${WORKDIR}"/${MY_P}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc64 ~riscv ~x86 ~amd64-linux ~x86-linux ~ppc-macos"

RDEPEND="games-misc/fortune-mod"

src_install() {
	insinto /usr/share/fortune
	doins thomas.ogrisegg thomas.ogrisegg.dat
}
