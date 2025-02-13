# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A collection of powerful, useful, and just plain fun Swing components"
HOMEPAGE="https://java.net/projects/swingx/"
SRC_URI="https://maven.java.net/service/local/repositories/releases/content/org/swinglabs/swingx/swingx-all/${PV}/swingx-all-${PV}-sources.jar
	https://java.net/projects/${PN}/downloads/download/releases/${PN}-mavensupport-${PV}-sources.jar"

LICENSE="LGPL-2.1"
SLOT="1.6"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/metainf-services:0"

DEPEND="
	${CP_DEPEND}
	virtual/jdk:1.8
"

RDEPEND="
	${CP_DEPEND}
	virtual/jre:1.8
"
