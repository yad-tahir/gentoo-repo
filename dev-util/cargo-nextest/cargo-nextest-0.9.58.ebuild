# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.6.1

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	aho-corasick@1.1.1
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.5.0
	anstyle-parse@0.2.1
	anstyle-query@1.0.0
	anstyle-wincon@2.1.0
	anstyle@1.0.3
	anyhow@1.0.75
	async-scoped@0.7.1
	async-trait@0.1.73
	atomicwrites@0.4.1
	atty@0.2.14
	autocfg@1.1.0
	axum-core@0.3.4
	axum@0.6.20
	backtrace-ext@0.2.1
	backtrace@0.3.69
	base64@0.13.1
	base64@0.21.4
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.4.0
	bstr@0.2.17
	bumpalo@3.14.0
	bytecount@0.6.3
	byteorder@1.4.3
	bytes@1.5.0
	camino-tempfile@1.0.2
	camino@1.1.6
	cargo-platform@0.1.3
	cargo_metadata@0.17.0
	cc@1.0.83
	cfg-expr@0.15.5
	cfg-if@1.0.0
	chrono@0.4.31
	clap@4.4.4
	clap_builder@4.4.4
	clap_derive@4.4.2
	clap_lex@0.5.1
	color-eyre@0.6.2
	colorchoice@1.0.0
	config@0.13.3
	console-api@0.5.0
	console-subscriber@0.1.10
	console@0.15.7
	core-foundation-sys@0.8.4
	core-foundation@0.9.3
	crc32fast@1.3.2
	crossbeam-channel@0.5.8
	crossbeam-utils@0.8.16
	debug-ignore@1.0.5
	dialoguer@0.10.4
	diff@0.1.13
	duct@0.13.6
	dunce@1.0.4
	either@1.9.0
	enable-ansi-support@0.2.1
	encode_unicode@0.3.6
	encoding_rs@0.8.33
	env_logger@0.10.0
	equivalent@1.0.1
	errno-dragonfly@0.1.2
	errno@0.3.3
	eyre@0.6.8
	fastrand@1.9.0
	fastrand@2.0.0
	filetime@0.2.22
	fixedbitset@0.4.2
	flate2@1.0.27
	fnv@1.0.7
	foreign-types-shared@0.1.1
	foreign-types@0.3.2
	form_urlencoded@1.2.0
	future-queue@0.3.0
	futures-channel@0.3.28
	futures-core@0.3.28
	futures-executor@0.3.28
	futures-io@0.3.28
	futures-macro@0.3.28
	futures-sink@0.3.28
	futures-task@0.3.28
	futures-util@0.3.28
	futures@0.3.28
	getrandom@0.2.10
	gimli@0.28.0
	goldenfile@1.5.2
	guppy-workspace-hack@0.1.0
	guppy@0.17.1
	h2@0.3.21
	hashbrown@0.12.3
	hashbrown@0.14.0
	hdrhistogram@7.5.2
	heck@0.4.1
	hermit-abi@0.1.19
	hermit-abi@0.3.3
	home@0.5.5
	http-body@0.4.5
	http@0.2.9
	httparse@1.8.0
	httpdate@1.0.3
	humantime-serde@1.1.1
	humantime@2.1.0
	hyper-rustls@0.24.1
	hyper-timeout@0.4.1
	hyper-tls@0.5.0
	hyper@0.14.27
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.57
	idna@0.4.0
	indent_write@2.2.0
	indenter@0.3.3
	indexmap@1.9.3
	indexmap@2.0.0
	indicatif@0.17.6
	indoc@2.0.4
	insta@1.31.0
	instant@0.1.12
	io-lifetimes@1.0.11
	ipnet@2.8.0
	is-terminal@0.4.9
	is_ci@1.1.1
	itertools@0.10.5
	itertools@0.11.0
	itoa@1.0.9
	jobserver@0.1.26
	js-sys@0.3.64
	lazy_static@1.4.0
	libc@0.2.148
	libm@0.2.7
	linked-hash-map@0.5.6
	linux-raw-sys@0.3.8
	linux-raw-sys@0.4.7
	log@0.4.20
	maplit@1.0.2
	matchers@0.1.0
	matchit@0.7.2
	memchr@2.6.3
	miette-derive@5.10.0
	miette@5.10.0
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.1
	mio@0.8.8
	mukti-metadata@0.1.0
	native-tls@0.2.11
	nested@0.1.1
	nix@0.27.1
	nom-tracable-macros@0.9.0
	nom-tracable@0.9.0
	nom@7.1.3
	nom_locate@4.2.0
	num-traits@0.2.16
	num_cpus@1.16.0
	number_prefix@0.4.0
	object@0.32.1
	once_cell@1.18.0
	openssl-macros@0.1.1
	openssl-probe@0.1.5
	openssl-sys@0.9.93
	openssl@0.10.57
	os_pipe@1.1.4
	owo-colors@3.5.0
	pathdiff@0.2.1
	percent-encoding@2.3.0
	petgraph@0.6.4
	pin-project-internal@1.1.3
	pin-project-lite@0.2.13
	pin-project@1.1.3
	pin-utils@0.1.0
	pkg-config@0.3.27
	portable-atomic@1.4.3
	ppv-lite86@0.2.17
	pretty_assertions@1.4.0
	proc-macro-error-attr@1.0.4
	proc-macro-error@1.0.4
	proc-macro2@0.4.30
	proc-macro2@1.0.67
	proptest-derive@0.3.0
	proptest@1.2.0
	prost-derive@0.11.9
	prost-types@0.11.9
	prost@0.11.9
	quick-error@1.2.3
	quick-xml@0.23.1
	quick-xml@0.30.0
	quote@0.6.13
	quote@1.0.33
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rand_xorshift@0.3.0
	recursion@0.4.0
	redox_syscall@0.3.5
	regex-automata@0.1.10
	regex-automata@0.3.8
	regex-syntax@0.6.29
	regex-syntax@0.7.5
	regex@1.9.5
	reqwest@0.11.20
	ring@0.16.20
	rustc-demangle@0.1.23
	rustix@0.37.23
	rustix@0.38.14
	rustls-pemfile@1.0.3
	rustls-webpki@0.101.5
	rustls@0.21.7
	rustversion@1.0.14
	rusty-fork@0.3.0
	ryu@1.0.15
	schannel@0.1.22
	sct@0.7.0
	security-framework-sys@2.9.1
	security-framework@2.9.2
	self-replace@1.3.7
	self_update@0.38.0
	semver@1.0.18
	serde@1.0.188
	serde_derive@1.0.188
	serde_ignored@0.1.9
	serde_json@1.0.107
	serde_path_to_error@0.1.14
	serde_spanned@0.6.3
	serde_urlencoded@0.7.1
	sharded-slab@0.1.4
	shared_child@1.0.0
	shell-words@1.1.0
	signal-hook-registry@1.4.1
	similar-asserts@1.5.0
	similar@2.2.1
	slab@0.4.9
	smallvec@1.11.1
	smawk@0.3.2
	smol_str@0.2.0
	socket2@0.4.9
	socket2@0.5.4
	spin@0.5.2
	static_assertions@1.1.0
	strip-ansi-escapes@0.2.0
	strsim@0.10.0
	structmeta-derive@0.2.0
	structmeta@0.2.0
	supports-color@1.3.1
	supports-color@2.1.0
	supports-hyperlinks@2.1.0
	supports-unicode@2.0.0
	syn@0.15.44
	syn@1.0.109
	syn@2.0.37
	sync_wrapper@0.1.2
	tar@0.4.40
	target-lexicon@0.12.11
	target-spec-miette@0.3.0
	target-spec@3.0.1
	tempfile@3.8.0
	terminal_size@0.1.17
	test-case-core@3.2.1
	test-case-macros@3.2.1
	test-case@3.2.1
	test-strategy@0.3.1
	textwrap@0.15.2
	thiserror-impl@1.0.48
	thiserror@1.0.48
	thread_local@1.1.7
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio-io-timeout@1.2.0
	tokio-macros@2.1.0
	tokio-native-tls@0.3.1
	tokio-rustls@0.24.1
	tokio-stream@0.1.14
	tokio-util@0.7.9
	tokio@1.32.0
	toml@0.5.11
	toml@0.7.8
	toml_datetime@0.6.3
	toml_edit@0.19.15
	tonic@0.9.2
	tower-layer@0.3.2
	tower-service@0.3.2
	tower@0.4.13
	tracing-attributes@0.1.26
	tracing-core@0.1.31
	tracing-subscriber@0.3.17
	tracing@0.1.37
	try-lock@0.2.4
	twox-hash@1.6.3
	unarray@0.1.4
	unicode-bidi@0.3.13
	unicode-ident@1.0.12
	unicode-linebreak@0.1.5
	unicode-normalization@0.1.22
	unicode-segmentation@1.10.1
	unicode-width@0.1.11
	unicode-xid@0.1.0
	untrusted@0.7.1
	url@2.4.1
	urlencoding@2.1.3
	utf8parse@0.2.1
	uuid@1.4.1
	valuable@0.1.0
	vcpkg@0.2.15
	version_check@0.9.4
	vte@0.11.1
	vte_generate_state_changes@0.1.1
	wait-timeout@0.2.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.87
	wasm-bindgen-futures@0.4.37
	wasm-bindgen-macro-support@0.2.87
	wasm-bindgen-macro@0.2.87
	wasm-bindgen-shared@0.2.87
	wasm-bindgen@0.2.87
	web-sys@0.3.64
	webpki-roots@0.25.2
	win32job@1.0.2
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.42.0
	windows-sys@0.45.0
	windows-sys@0.48.0
	windows-targets@0.42.2
	windows-targets@0.48.5
	windows@0.48.0
	windows_aarch64_gnullvm@0.42.2
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.42.2
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.42.2
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.42.2
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.42.2
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.42.2
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.42.2
	windows_x86_64_msvc@0.48.5
	winnow@0.5.15
	winreg@0.50.0
	xattr@1.0.1
	yaml-rust@0.4.5
	yansi@0.5.1
	zeroize@1.6.0
	zstd-safe@6.0.6
	zstd-sys@2.0.8+zstd.1.5.5
	zstd@0.12.4
"

inherit cargo

DESCRIPTION="Next-generation test runner for Rust"
HOMEPAGE="https://nexte.st/"
SRC_URI=" https://github.com/nextest-rs/nextest/archive/refs/tags/${P}.tar.gz"
SRC_URI+=" ${CARGO_CRATE_URIS}"
S="${WORKDIR}"/nextest-${P}/${PN}

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD ISC MIT MPL-2.0
	Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

QA_FLAGS_IGNORED="usr/bin/cargo-nextest"
