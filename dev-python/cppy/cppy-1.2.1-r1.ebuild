# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="C++ header library which makes it easier to write Python extension modules"
HOMEPAGE="
	https://github.com/nucleic/cppy/
	https://pypi.org/project/cppy/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~loong ~m68k ppc ppc64 ~riscv ~s390 sparc x86"

# bug #836765 for setuptools >= dep
BDEPEND=">=dev-python/setuptools-61.2[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
