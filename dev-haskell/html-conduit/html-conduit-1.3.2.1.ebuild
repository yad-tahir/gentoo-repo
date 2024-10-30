# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.6.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Parse HTML documents using xml-conduit datatypes"
HOMEPAGE="https://github.com/snoyberg/xml"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
IUSE=""

RDEPEND="dev-haskell/attoparsec:=[profile?]
	>=dev-haskell/conduit-1.3:=[profile?]
	dev-haskell/conduit-extra:=[profile?]
	>=dev-haskell/resourcet-1.2:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-haskell/xml-conduit-1.3:=[profile?]
	>=dev-haskell/xml-types-0.3:=[profile?] <dev-haskell/xml-types-0.4:=[profile?]
	>=dev-lang/ghc-7.8.2:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.18.1.3
	test? ( >=dev-haskell/hspec-1.3
		dev-haskell/hunit )
"
