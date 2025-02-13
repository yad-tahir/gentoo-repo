# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop qmake-utils

DESCRIPTION="Qt5 client for the music player daemon (MPD)"
HOMEPAGE="https://sourceforge.net/projects/quimup/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN^}_${PV}_source.tar.gz"
S="${WORKDIR}/${PN^}_${PV}_source"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	media-libs/libmpdclient
	media-libs/taglib:=
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/${P}-fix-build-taglib2.patch )

DOCS=( changelog FAQ.txt README )

src_configure() {
	eqmake5
}

src_install() {
	default
	dobin ${PN}

	newicon src/resources/mn_icon.png ${PN}.png
	make_desktop_entry ${PN} Quimup
}
