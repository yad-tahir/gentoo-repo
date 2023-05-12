# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Tool to query and modify process behavior"
HOMEPAGE="https://sourceforge.net/projects/prctl/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm64 ~hppa ~ia64 ~x86"

PATCHES=(
	"${FILESDIR}"/${P}-no-implicits.patch
)

src_prepare() {
	default

	cp "${FILESDIR}"/{Makefile.am,configure.ac} ./ || die
	eautoreconf
}
