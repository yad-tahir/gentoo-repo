# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )

DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1 optfeature

DESCRIPTION="Python Language Server for the Language Server Protocol"
HOMEPAGE="https://github.com/python-lsp/python-lsp-server"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"

IUSE="all-plugins"

BDEPEND="
	test? (
		dev-python/autopep8[${PYTHON_USEDEP}]
		dev-python/flaky[${PYTHON_USEDEP}]
		>=dev-python/flake8-3.8.0[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		>=dev-python/mccabe-0.6.0[${PYTHON_USEDEP}]
		<dev-python/mccabe-0.7.0[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		>=dev-python/pycodestyle-2.7.0[${PYTHON_USEDEP}]
		>=dev-python/pydocstyle-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/pyflakes-2.3.0[${PYTHON_USEDEP}]
		<dev-python/pyflakes-2.4.0[${PYTHON_USEDEP}]
		>=dev-python/pylint-2.5.0[${PYTHON_USEDEP}]
		dev-python/QtPy[gui,testlib,${PYTHON_USEDEP}]
		>=dev-python/rope-0.10.5[${PYTHON_USEDEP}]
		dev-python/yapf[${PYTHON_USEDEP}]
	)"

RDEPEND="
	>=dev-python/jedi-0.17.2[${PYTHON_USEDEP}]
	<dev-python/jedi-0.19.0[${PYTHON_USEDEP}]
	>=dev-python/python-lsp-jsonrpc-1.0.0[${PYTHON_USEDEP}]
	dev-python/pluggy[${PYTHON_USEDEP}]
	all-plugins? (
		dev-python/autopep8[${PYTHON_USEDEP}]
		>=dev-python/flake8-3.8.0[${PYTHON_USEDEP}]
		>=dev-python/mccabe-0.6.0[${PYTHON_USEDEP}]
		<dev-python/mccabe-0.7.0[${PYTHON_USEDEP}]
		>=dev-python/pycodestyle-2.7.0[${PYTHON_USEDEP}]
		>=dev-python/pydocstyle-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/pyflakes-2.3.0[${PYTHON_USEDEP}]
		<dev-python/pyflakes-2.4.0[${PYTHON_USEDEP}]
		>=dev-python/pylint-2.5.0[${PYTHON_USEDEP}]
		>=dev-python/rope-0.10.5[${PYTHON_USEDEP}]
		dev-python/yapf[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	# remove pytest-cov dep
	sed -i -e '0,/addopts/I!d' setup.cfg || die

	# This test is continuously breaking
	sed -i -e 's/test_folding/_&/' test/plugins/test_folding.py || die

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "Automatically formats Python code to conform to the PEP 8 style guide" dev-python/autopep8
	optfeature "A wrapper around PyFlakes, pep8 & mccabe" dev-python/flake8
	optfeature "flake8 plugin: McCabe complexity checker" dev-python/mccabe
	optfeature "Python style guide checker (fka pep8)" dev-python/pycodestyle
	optfeature "Python docstring style checker" dev-python/pydocstyle
	optfeature "Passive checker for Python programs" dev-python/pyflakes
	optfeature "Python code static checker" dev-python/pylint
	optfeature "Python refactoring library" dev-python/rope
	optfeature "A formatter for Python files" dev-python/yapf
}
