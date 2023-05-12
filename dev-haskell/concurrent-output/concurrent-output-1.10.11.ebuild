# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# ebuild generated by hackport 0.6.1

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Ungarble output from several threads or commands"
HOMEPAGE="https://hackage.haskell.org/package/concurrent-output"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE=""

RDEPEND=">=dev-haskell/ansi-terminal-0.9.1:=[profile?] <dev-haskell/ansi-terminal-0.11.0:=[profile?]
	>=dev-haskell/async-2.0:=[profile?] <dev-haskell/async-2.3:=[profile?]
	>=dev-haskell/exceptions-0.6.0:=[profile?] <dev-haskell/exceptions-0.11.0:=[profile?]
	>=dev-haskell/stm-2.0:=[profile?] <dev-haskell/stm-2.6:=[profile?]
	>=dev-haskell/terminal-size-0.3.0:=[profile?] <dev-haskell/terminal-size-0.4.0:=[profile?]
	>=dev-haskell/text-0.11.0:=[profile?] <dev-haskell/text-1.3.0:=[profile?]
	>=dev-lang/ghc-8.2.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.0.0.2
"
