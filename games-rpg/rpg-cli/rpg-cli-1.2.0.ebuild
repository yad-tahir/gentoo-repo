# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.3

EAPI=8

CRATES="
	anstream@0.6.15
	anstyle-parse@0.2.5
	anstyle-query@1.1.1
	anstyle-wincon@3.0.4
	anstyle@1.0.8
	anyhow@1.0.89
	autocfg@1.3.0
	bincode@1.3.3
	bitflags@2.6.0
	byteorder@1.5.0
	cfg-if@1.0.0
	clap@4.5.18
	clap_builder@4.5.18
	clap_derive@4.5.18
	clap_lex@0.7.2
	colorchoice@1.0.2
	colored@2.1.0
	ctor@0.1.26
	dirs-sys@0.3.7
	dirs@4.0.0
	dunce@1.0.5
	erased-serde@0.3.31
	getrandom@0.2.15
	ghost@0.1.17
	hashbrown@0.12.3
	heck@0.4.1
	heck@0.5.0
	indexmap@1.9.3
	inventory@0.2.3
	is_terminal_polyfill@1.70.1
	itoa@1.0.11
	lazy_static@1.5.0
	libc@0.2.158
	libredox@0.1.3
	linked-hash-map@0.5.6
	memchr@2.7.4
	once_cell@1.19.0
	ppv-lite86@0.2.20
	proc-macro2@1.0.86
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_users@0.4.6
	rustversion@1.0.17
	ryu@1.0.18
	serde@1.0.210
	serde_derive@1.0.210
	serde_json@1.0.128
	serde_yaml@0.8.26
	strsim@0.11.1
	strum@0.24.1
	strum_macros@0.24.3
	syn@1.0.109
	syn@2.0.77
	thiserror-impl@1.0.64
	thiserror@1.0.64
	typetag-impl@0.1.8
	typetag@0.1.8
	unicode-ident@1.0.13
	utf8parse@0.2.2
	wasi@0.11.0+wasi-snapshot-preview1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	yaml-rust@0.4.5
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
"

inherit cargo

DESCRIPTION="Terminal game, your filesystem as a dungeon"
HOMEPAGE="https://github.com/facundoolano/rpg-cli"
SRC_URI="https://github.com/facundoolano/rpg-cli/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE=""
# Dependent crate licenses
LICENSE+="
	MIT MPL-2.0 Unicode-DFS-2016
	|| ( Apache-2.0 Boost-1.0 )
	|| ( Apache-2.0 CC0-1.0 MIT-0 )
"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

QA_FLAGS_IGNORED="usr/bin/rpg-cli"

src_install() {
	cargo_src_install
	dodoc README.md
	newdoc shell/README.md README-shell.md
}
