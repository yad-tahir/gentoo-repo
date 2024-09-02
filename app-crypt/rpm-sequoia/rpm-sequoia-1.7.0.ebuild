# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.3

EAPI=8

CRATES="
	aead@0.5.2
	aes-gcm@0.10.3
	aes@0.8.4
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstyle@1.0.7
	anyhow@1.0.86
	ascii-canvas@3.0.0
	assert_cmd@2.0.14
	autocfg@1.3.0
	base16ct@0.2.0
	base64@0.22.1
	base64ct@1.6.0
	bindgen@0.68.1
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@2.6.0
	block-buffer@0.10.4
	block-padding@0.3.3
	blowfish@0.9.1
	botan-sys@0.10.5
	botan@0.10.7
	bstr@1.9.1
	buffered-reader@1.3.1
	bumpalo@3.16.0
	byteorder@1.5.0
	camellia@0.1.0
	cast5@0.11.1
	cc@1.0.106
	cdylib-link-lines@0.1.5
	cexpr@0.6.0
	cfb-mode@0.8.2
	cfg-if@1.0.0
	chrono@0.4.38
	cipher@0.4.4
	clang-sys@1.8.1
	cmac@0.7.2
	const-oid@0.9.6
	core-foundation-sys@0.8.6
	cpufeatures@0.2.12
	crunchy@0.2.2
	crypto-bigint@0.5.5
	crypto-common@0.1.6
	ctr@0.9.2
	curve25519-dalek-derive@0.1.1
	curve25519-dalek@4.1.3
	dbl@0.3.2
	der@0.7.9
	des@0.8.1
	difflib@0.4.0
	digest@0.10.7
	dirs-next@2.0.0
	dirs-sys-next@0.1.2
	displaydoc@0.2.5
	doc-comment@0.3.3
	dsa@0.6.3
	dyn-clone@1.0.17
	eax@0.5.0
	ecb@0.1.2
	ecdsa@0.16.9
	ed25519-dalek@2.1.1
	ed25519@2.2.3
	either@1.13.0
	elliptic-curve@0.13.8
	ena@0.14.3
	equivalent@1.0.1
	errno@0.3.9
	fastrand@2.1.0
	ff@0.13.0
	fiat-crypto@0.2.9
	fixedbitset@0.4.2
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	generic-array@0.14.7
	generic-array@1.1.0
	getrandom@0.2.15
	ghash@0.5.1
	glob@0.3.1
	group@0.13.0
	hashbrown@0.14.5
	hkdf@0.12.4
	hmac@0.12.1
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.60
	icu_collections@1.5.0
	icu_locid@1.5.0
	icu_locid_transform@1.5.0
	icu_locid_transform_data@1.5.0
	icu_normalizer@1.5.0
	icu_normalizer_data@1.5.0
	icu_properties@1.5.1
	icu_properties_data@1.5.0
	icu_provider@1.5.0
	icu_provider_macros@1.5.0
	idea@0.5.1
	idna@1.0.2
	indexmap@2.2.6
	inout@0.1.3
	itertools@0.11.0
	js-sys@0.3.69
	lalrpop-util@0.20.2
	lalrpop@0.20.2
	lazy_static@1.5.0
	lazycell@1.3.0
	libc@0.2.155
	libloading@0.8.4
	libm@0.2.8
	libredox@0.1.3
	linux-raw-sys@0.4.14
	litemap@0.7.3
	lock_api@0.4.12
	log@0.4.22
	md-5@0.10.6
	memchr@2.7.4
	memsec@0.7.0
	minimal-lexical@0.2.1
	nettle-sys@2.3.0
	nettle@7.4.0
	new_debug_unreachable@1.0.6
	nom@7.1.3
	num-bigint-dig@0.8.4
	num-integer@0.1.46
	num-iter@0.1.45
	num-traits@0.2.19
	once_cell@1.19.0
	opaque-debug@0.3.1
	openssl-macros@0.1.1
	openssl-sys@0.9.102
	openssl@0.10.64
	p256@0.13.2
	p384@0.13.0
	p521@0.13.3
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	peeking_take_while@0.1.2
	pem-rfc7468@0.7.0
	petgraph@0.6.5
	phf_shared@0.10.0
	pkcs1@0.7.5
	pkcs8@0.10.2
	pkg-config@0.3.30
	polyval@0.6.2
	ppv-lite86@0.2.17
	precomputed-hash@0.1.1
	predicates-core@1.0.6
	predicates-tree@1.0.9
	predicates@3.1.0
	primeorder@0.13.6
	proc-macro2@1.0.86
	quote@1.0.36
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.5.2
	redox_users@0.4.5
	regex-automata@0.4.7
	regex-syntax@0.8.4
	regex@1.10.5
	rfc6979@0.4.0
	ripemd@0.1.3
	rsa@0.9.6
	rustc-hash@1.1.0
	rustc_version@0.4.0
	rustix@0.38.34
	rustversion@1.0.17
	same-file@1.0.6
	scopeguard@1.2.0
	sec1@0.7.3
	semver@1.0.23
	sequoia-openpgp@1.21.1
	sequoia-policy-config@0.6.0
	serde@1.0.204
	serde_derive@1.0.204
	sha1collisiondetection@0.3.4
	sha2@0.10.8
	shlex@1.3.0
	signature@2.2.0
	siphasher@0.3.11
	smallvec@1.13.2
	spin@0.9.8
	spki@0.7.3
	stable_deref_trait@1.2.0
	string_cache@0.8.7
	subtle@2.6.1
	syn@2.0.70
	synstructure@0.13.1
	tempfile@3.10.1
	term@0.7.0
	termtree@0.4.1
	thiserror-impl@1.0.61
	thiserror@1.0.61
	tiny-keccak@2.0.2
	tinystr@0.7.6
	toml@0.5.11
	twofish@0.7.1
	typenum@1.17.0
	unicode-ident@1.0.12
	unicode-xid@0.2.4
	universal-hash@0.5.1
	utf16_iter@1.0.5
	utf8_iter@1.0.4
	vcpkg@0.2.15
	version_check@0.9.4
	wait-timeout@0.2.0
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-shared@0.2.92
	wasm-bindgen@0.2.92
	win-crypto-ng@0.5.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.8
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-sys@0.52.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	write16@1.0.0
	writeable@0.5.5
	x25519-dalek@2.0.1
	xxhash-rust@0.8.11
	yoke-derive@0.7.4
	yoke@0.7.4
	zerofrom-derive@0.1.4
	zerofrom@0.1.4
	zeroize@1.8.1
	zeroize_derive@1.4.2
	zerovec-derive@0.10.3
	zerovec@0.10.4
"

LLVM_COMPAT=( {17..18} )

inherit cargo llvm-r1

DESCRIPTION="Implementation of the RPM PGP interface using Sequoia"
HOMEPAGE="https://sequoia-pgp.org/ https://github.com/rpm-software-management/rpm-sequoia"
SRC_URI="
	https://github.com/rpm-software-management/rpm-sequoia/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="LGPL-2+"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD Boost-1.0 CC0-1.0 ISC LGPL-2+ MIT Unicode-3.0
	Unicode-DFS-2016
	|| ( GPL-2 GPL-3 LGPL-3 )
"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~loong ~ppc ~ppc64 ~sparc ~x86"
IUSE="nettle +openssl"
REQUIRED_USE="^^ ( nettle openssl )"

DEPEND="
	nettle? (
		dev-libs/gmp:=
		dev-libs/nettle:=
	)
	openssl? ( dev-libs/openssl:= )
"
RDEPEND="${DEPEND}"
# Clang is required for bindgen
BDEPEND="
	virtual/pkgconfig
	>=virtual/rust-1.73
	nettle? ( $(llvm_gen_dep 'sys-devel/clang:${LLVM_SLOT}') )
"

QA_FLAGS_IGNORED="usr/lib.*/librpm_sequoia.so.1"

src_configure() {
	local myfeatures=(
		$(usev nettle crypto-nettle)
		$(usev openssl crypto-openssl)
	)
	cargo_src_configure --no-default-features
}

src_compile() {
	# These variables will be used to generate the pkgconfig file.
	PREFIX="${EPREFIX}/usr" LIBDIR="${PREFIX}"/$(get_libdir) cargo_src_compile
}

src_install() {
	newlib.so "$(cargo_target_dir)"/librpm_sequoia.so librpm_sequoia.so.1
	dosym librpm_sequoia.so.1 /usr/$(get_libdir)/librpm_sequoia.so

	insinto /usr/$(get_libdir)/pkgconfig
	# build.rs sets the output dir to be target/<PROFILE>, so don't use helper.
	doins target/$(usex debug debug release)/rpm-sequoia.pc
}
