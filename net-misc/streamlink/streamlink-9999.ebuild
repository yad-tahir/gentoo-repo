# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="https://github.com/streamlink/${PN}.git"
	inherit git-r3
fi

DISTUTILS_SINGLE_IMPL=1
# >= 6.2.1 uses a bunch of setuptools hooks instead of vanilla setuptools
# https://github.com/streamlink/streamlink/commit/194d9bc193f5285bc1ba33af5fd89209a96ad3a7
DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE='xml(+),threads(+)'
inherit distutils-r1

DESCRIPTION="CLI for extracting streams from websites to a video player of your choice"
HOMEPAGE="https://streamlink.github.io/"

if [[ ${PV} != 9999* ]]; then
	SRC_URI="https://github.com/streamlink/${PN}/releases/download/${PV}/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="BSD-2 Apache-2.0"
SLOT="0"

DEPEND="
	$(python_gen_cond_dep '
		dev-python/certifi[${PYTHON_USEDEP}]
		>=dev-python/requests-2.26.0[${PYTHON_USEDEP}]
		dev-python/isodate[${PYTHON_USEDEP}]
		>=dev-python/lxml-4.6.4[${PYTHON_USEDEP}]
		>=dev-python/websocket-client-1.2.1[${PYTHON_USEDEP}]
		dev-python/pycountry[${PYTHON_USEDEP}]
		>=dev-python/pycryptodome-3.4.3[${PYTHON_USEDEP}]
		>dev-python/PySocks-1.5.7[${PYTHON_USEDEP}]
		>=dev-python/trio-0.22.0[${PYTHON_USEDEP}]
		>=dev-python/trio-websocket-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/urllib3-1.26.0[${PYTHON_USEDEP}]
		>=dev-python/versioningit-2.0.0[${PYTHON_USEDEP}]
	')
"
RDEPEND="
	${DEPEND}
	media-video/ffmpeg
"
BDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/setuptools-64[${PYTHON_USEDEP}]
		>=dev-python/versioningit-2.0.0[${PYTHON_USEDEP}]
		test? (
			dev-python/mock[${PYTHON_USEDEP}]
			>=dev-python/freezegun-1.0.0[${PYTHON_USEDEP}]
			dev-python/pytest-asyncio[${PYTHON_USEDEP}]
			dev-python/pytest-trio[${PYTHON_USEDEP}]
			dev-python/requests-mock[${PYTHON_USEDEP}]
		)
	')
"

distutils_enable_tests pytest
