# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4

EAPI=8

CRATES="
	addr2line-0.19.0
	adler-1.0.2
	adler32-1.2.0
	ahash-0.7.6
	ahash-0.8.3
	aho-corasick-0.7.20
	android_system_properties-0.1.5
	anes-0.1.6
	anstream-0.2.6
	anstyle-0.3.5
	anstyle-parse-0.1.1
	anstyle-wincon-0.2.0
	anyhow-1.0.70
	arrayref-0.3.7
	arrayvec-0.7.2
	ash-0.37.2+1.3.238
	assert_fs-1.0.12
	async-broadcast-0.5.1
	async-channel-1.8.0
	async-executor-1.5.0
	async-fs-1.6.0
	async-io-1.13.0
	async-lock-2.7.0
	async-net-1.7.0
	async-process-1.6.0
	async-recursion-1.0.4
	async-task-4.4.0
	async-trait-0.1.68
	atomic-0.5.1
	atomic-waker-1.1.0
	atty-0.2.14
	autocfg-1.1.0
	backtrace-0.3.67
	base64-0.13.1
	base64-0.21.0
	benchmarking-0.4.12
	bit-set-0.5.3
	bit-vec-0.6.3
	bit_field-0.10.2
	bitflags-1.3.2
	bitflags-2.0.2
	block-0.1.6
	block-buffer-0.10.4
	blocking-1.3.0
	bstr-0.1.4
	bstr-0.2.17
	bstr-1.4.0
	bumpalo-3.12.0
	bytemuck-1.13.1
	bytemuck_derive-1.4.1
	byteorder-1.4.3
	bytes-1.4.0
	camino-1.1.4
	cassowary-0.3.0
	cast-0.3.0
	cc-1.0.79
	cfg-if-1.0.0
	cgl-0.3.2
	chrono-0.4.24
	ciborium-0.2.0
	ciborium-io-0.2.0
	ciborium-ll-0.2.0
	clap-2.34.0
	clap-3.2.23
	clap-4.2.1
	clap_builder-4.2.1
	clap_complete-4.2.0
	clap_complete_fig-4.2.0
	clap_derive-4.2.0
	clap_lex-0.2.4
	clap_lex-0.4.1
	clipboard-win-2.2.0
	clipboard_macos-0.1.0
	cocoa-0.20.2
	codespan-reporting-0.11.1
	color_quant-1.1.0
	colored-1.9.3
	colorgrad-0.6.2
	com-rs-0.2.1
	concolor-override-1.0.0
	concolor-query-0.3.3
	concurrent-queue-2.1.0
	core-foundation-0.7.0
	core-foundation-0.9.3
	core-foundation-sys-0.7.0
	core-foundation-sys-0.8.4
	core-graphics-0.19.2
	core-graphics-0.22.3
	core-graphics-types-0.1.1
	core-text-19.2.0
	cpufeatures-0.2.6
	crc32fast-1.3.2
	criterion-0.3.6
	criterion-0.4.0
	criterion-plot-0.4.5
	criterion-plot-0.5.0
	crossbeam-0.8.2
	crossbeam-channel-0.5.7
	crossbeam-deque-0.8.3
	crossbeam-epoch-0.9.14
	crossbeam-queue-0.3.8
	crossbeam-utils-0.8.15
	crunchy-0.2.2
	crypto-common-0.1.6
	csscolorparser-0.6.2
	csv-1.2.1
	csv-core-0.1.10
	cxx-1.0.94
	cxx-build-1.0.94
	cxxbridge-flags-1.0.94
	cxxbridge-macro-1.0.94
	d3d12-0.6.0
	darling-0.14.4
	darling_core-0.14.4
	darling_macro-0.14.4
	dashmap-5.4.0
	data-encoding-2.3.3
	deltae-0.3.0
	derivative-2.2.0
	dhat-0.3.2
	diff-0.1.13
	difflib-0.4.0
	digest-0.10.6
	dirs-4.0.0
	dirs-next-2.0.0
	dirs-sys-0.3.7
	dirs-sys-next-0.1.2
	dlib-0.5.0
	doc-comment-0.3.3
	downcast-rs-1.2.0
	dwrote-0.11.0
	either-1.8.1
	embed-resource-1.8.0
	emojis-0.5.2
	encoding_rs-0.8.32
	enum-display-derive-0.1.1
	enumflags2-0.7.6
	enumflags2_derive-0.7.6
	env_logger-0.10.0
	errno-0.2.8
	errno-0.3.0
	errno-dragonfly-0.1.2
	euclid-0.22.9
	event-listener-2.5.3
	exr-1.6.3
	fallible-iterator-0.2.0
	fallible-streaming-iterator-0.1.9
	fancy-regex-0.11.0
	fastrand-1.9.0
	filenamegen-0.2.4
	filetime-0.2.20
	finl_unicode-1.2.0
	fixedbitset-0.4.2
	flate2-1.0.25
	float-cmp-0.9.0
	flume-0.10.14
	fnv-1.0.7
	foreign-types-0.3.2
	foreign-types-shared-0.1.1
	form_urlencoded-1.1.0
	fsevent-sys-4.1.0
	futures-0.3.28
	futures-channel-0.3.28
	futures-core-0.3.28
	futures-executor-0.3.28
	futures-io-0.3.28
	futures-lite-1.12.0
	futures-macro-0.3.28
	futures-sink-0.3.28
	futures-task-0.3.28
	futures-timer-3.0.2
	futures-util-0.3.28
	fuzzy-matcher-0.3.7
	fxhash-0.2.1
	generic-array-0.14.7
	gethostname-0.4.1
	getopts-0.2.21
	getrandom-0.2.8
	gif-0.12.0
	gimli-0.27.2
	git2-0.16.1
	gl_generator-0.14.0
	glium-0.31.0
	globset-0.4.10
	globwalk-0.8.1
	glow-0.12.1
	governor-0.4.2
	gpu-alloc-0.5.3
	gpu-alloc-types-0.2.0
	gpu-allocator-0.22.0
	gpu-descriptor-0.2.3
	gpu-descriptor-types-0.1.1
	guillotiere-0.6.2
	h2-0.3.16
	half-1.8.2
	half-2.2.1
	hashbrown-0.11.2
	hashbrown-0.12.3
	hashlink-0.7.0
	hassle-rs-0.9.0
	hdrhistogram-7.5.2
	heck-0.4.1
	hermit-abi-0.1.19
	hermit-abi-0.2.6
	hermit-abi-0.3.1
	hex-0.4.3
	hexf-parse-0.2.1
	hostname-0.3.1
	http-0.2.9
	http-body-0.4.5
	http_req-0.9.1
	httparse-1.8.0
	httpdate-1.0.2
	humansize-2.1.3
	humantime-2.1.0
	hyper-0.14.25
	hyper-tls-0.5.0
	iana-time-zone-0.1.54
	iana-time-zone-haiku-0.1.1
	ident_case-1.0.1
	idna-0.3.0
	ignore-0.4.20
	image-0.24.6
	indexmap-1.9.3
	inotify-0.9.6
	inotify-sys-0.1.5
	instant-0.1.12
	intrusive-collections-0.9.5
	io-lifetimes-1.0.9
	ioctl-rs-0.1.6
	ipnet-2.7.2
	is-terminal-0.4.6
	itertools-0.10.5
	itoa-1.0.6
	jobserver-0.1.26
	jpeg-decoder-0.3.0
	js-sys-0.3.61
	k9-0.11.6
	khronos-egl-4.1.0
	khronos_api-3.1.0
	kqueue-1.0.7
	kqueue-sys-1.0.3
	lab-0.11.0
	lazy_static-1.4.0
	lazycell-1.3.0
	leb128-0.2.5
	lebe-0.5.2
	libc-0.2.140
	libflate-1.3.0
	libflate_lz77-1.2.0
	libgit2-sys-0.14.2+1.5.1
	libloading-0.6.7
	libloading-0.7.4
	libm-0.2.6
	libsqlite3-sys-0.24.2
	libssh-rs-0.1.8
	libssh-rs-sys-0.1.3
	libssh2-sys-0.3.0
	libz-sys-1.1.8
	line-wrap-0.1.1
	line_drawing-0.8.1
	link-cplusplus-1.0.8
	linked-hash-map-0.5.6
	linux-raw-sys-0.1.4
	linux-raw-sys-0.3.1
	lock_api-0.4.9
	log-0.4.17
	lru-0.7.8
	lua-src-544.0.1
	luajit-src-210.4.5+resty2cf5186
	mac_address-1.1.4
	mach-0.3.2
	malloc_buf-0.0.6
	maplit-1.0.2
	match_cfg-0.1.0
	memchr-2.5.0
	memmap2-0.2.3
	memmap2-0.5.10
	memmem-0.1.1
	memoffset-0.6.5
	memoffset-0.7.1
	memoffset-0.8.0
	metal-0.24.0
	metrics-0.17.1
	metrics-macros-0.4.1
	mime-0.3.17
	minimal-lexical-0.2.1
	miniz_oxide-0.4.4
	miniz_oxide-0.6.2
	mintex-0.1.2
	mio-0.8.6
	mlua-0.8.8
	naga-0.11.0
	names-0.12.0
	nanorand-0.7.0
	native-tls-0.2.11
	nix-0.23.2
	nix-0.24.3
	nix-0.25.1
	nix-0.26.2
	no-std-compat-0.4.1
	nom-7.1.3
	nonzero_ext-0.3.0
	normalize-line-endings-0.3.0
	notify-5.1.0
	ntapi-0.4.0
	num-0.3.1
	num-bigint-0.3.3
	num-complex-0.3.1
	num-derive-0.3.3
	num-integer-0.1.45
	num-iter-0.1.43
	num-rational-0.3.2
	num-rational-0.4.1
	num-traits-0.2.15
	num_cpus-1.15.0
	objc-0.2.7
	objc-foundation-0.1.1
	objc_exception-0.1.2
	objc_id-0.1.1
	object-0.30.3
	once_cell-1.17.1
	oorandom-11.1.3
	openssl-0.10.38
	openssl-probe-0.1.5
	openssl-src-300.1.0+3.1.0
	openssl-sys-0.9.71
	ordered-float-3.6.0
	ordered-stream-0.2.0
	os_str_bytes-6.5.0
	parking-2.0.0
	parking_lot-0.11.2
	parking_lot-0.12.1
	parking_lot_core-0.8.6
	parking_lot_core-0.9.7
	pem-1.1.1
	percent-encoding-2.2.0
	pest-2.5.7
	pest_derive-2.5.7
	pest_generator-2.5.7
	pest_meta-2.5.7
	phf-0.11.1
	phf_codegen-0.11.1
	phf_generator-0.11.1
	phf_macros-0.11.1
	phf_shared-0.11.1
	pin-project-1.0.12
	pin-project-internal-1.0.12
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	pkg-config-0.3.26
	plist-1.4.3
	plotters-0.3.4
	plotters-backend-0.3.4
	plotters-svg-0.3.3
	png-0.17.7
	polling-2.6.0
	ppv-lite86-0.2.17
	predicates-3.0.2
	predicates-core-1.0.6
	predicates-tree-1.0.9
	proc-macro-crate-1.3.1
	proc-macro2-1.0.55
	profiling-1.0.7
	pulldown-cmark-0.9.2
	pure-rust-locales-0.5.6
	qoi-0.4.1
	quanta-0.9.3
	quick-xml-0.22.0
	quick-xml-0.28.1
	quote-1.0.26
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.6.4
	range-alloc-0.1.3
	raw-cpuid-10.7.0
	raw-window-handle-0.5.2
	rayon-1.7.0
	rayon-core-1.11.0
	rcgen-0.9.3
	redox_syscall-0.2.16
	redox_syscall-0.3.5
	redox_users-0.4.3
	regex-1.7.3
	regex-automata-0.1.10
	regex-syntax-0.6.29
	renderdoc-sys-0.7.1
	reqwest-0.11.16
	resize-0.5.5
	rgb-0.8.36
	ring-0.16.20
	rle-decode-fast-1.0.3
	rstest-0.17.0
	rstest_macros-0.17.0
	rusqlite-0.27.0
	rustc-demangle-0.1.22
	rustc-hash-1.1.0
	rustc_version-0.4.0
	rustix-0.36.11
	rustix-0.37.6
	ryu-1.0.13
	safemem-0.3.3
	same-file-1.0.6
	schannel-0.1.21
	scoped-tls-1.0.1
	scopeguard-1.1.0
	scratch-1.0.5
	security-framework-2.8.2
	security-framework-sys-2.8.0
	semver-0.11.0
	semver-1.0.17
	semver-parser-0.10.2
	serde-1.0.159
	serde_cbor-0.11.2
	serde_derive-1.0.159
	serde_json-1.0.95
	serde_repr-0.1.12
	serde_spanned-0.6.1
	serde_urlencoded-0.7.1
	serde_with-2.3.1
	serde_with_macros-2.3.1
	serde_yaml-0.9.19
	serial-0.4.0
	serial-core-0.4.0
	serial-unix-0.4.0
	serial-windows-0.4.0
	sha1-0.10.5
	sha2-0.10.6
	shared_library-0.1.9
	shell-words-1.1.0
	shlex-1.1.0
	signal-hook-0.3.15
	signal-hook-registry-1.4.1
	simd-adler32-0.3.5
	siphasher-0.3.10
	slab-0.4.8
	slotmap-1.0.6
	smallvec-1.10.0
	smawk-0.3.1
	smithay-client-toolkit-0.16.0
	smol-1.3.0
	smol-potat-1.1.2
	smol-potat-macro-0.6.0
	socket2-0.4.9
	socket2-0.5.1
	spa-0.3.0
	spin-0.5.2
	spin-0.9.7
	spirv-0.2.0+1.5.4
	sqlite-cache-0.1.3
	ssh2-0.9.4
	starship-battery-0.7.9
	static_assertions-1.1.0
	strict-num-0.1.0
	strsim-0.10.0
	svg_fmt-0.4.1
	syn-1.0.109
	syn-2.0.13
	sys-info-0.9.1
	takeable-option-0.5.0
	tar-0.4.38
	tempfile-3.5.0
	term_size-0.3.2
	termcolor-1.2.0
	terminal_size-0.2.5
	terminfo-0.8.0
	termios-0.2.2
	termios-0.3.3
	termtree-0.4.1
	textwrap-0.11.0
	textwrap-0.16.0
	thiserror-1.0.40
	thiserror-impl-1.0.40
	thousands-0.2.0
	thread_local-1.1.7
	tiff-0.8.1
	time-0.1.43
	time-0.3.20
	time-core-0.1.0
	time-macros-0.2.8
	tiny-skia-0.8.3
	tiny-skia-path-0.8.3
	tinytemplate-1.2.1
	tinyvec-1.6.0
	tinyvec_macros-0.1.1
	tokio-1.27.0
	tokio-macros-2.0.0
	tokio-native-tls-0.3.1
	tokio-util-0.7.7
	toml-0.5.11
	toml-0.7.3
	toml_datetime-0.6.1
	toml_edit-0.19.8
	tower-service-0.3.2
	tracing-0.1.37
	tracing-attributes-0.1.23
	tracing-core-0.1.30
	try-lock-0.2.4
	typenum-1.16.0
	ucd-trie-0.1.5
	uds_windows-1.0.2
	unicase-2.6.0
	unicode-bidi-0.3.13
	unicode-ident-1.0.8
	unicode-linebreak-0.1.4
	unicode-normalization-0.1.22
	unicode-segmentation-1.10.1
	unicode-width-0.1.10
	unicode-xid-0.2.4
	unsafe-libyaml-0.2.7
	untrusted-0.7.1
	uom-0.30.0
	url-2.3.1
	utf8parse-0.2.1
	uuid-1.3.0
	varbincode-0.1.0
	vcpkg-0.2.15
	version_check-0.9.4
	vswhom-0.1.0
	vswhom-sys-0.1.2
	waker-fn-1.1.0
	walkdir-2.3.3
	want-0.3.0
	wasi-0.10.2+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.84
	wasm-bindgen-backend-0.2.84
	wasm-bindgen-futures-0.4.34
	wasm-bindgen-macro-0.2.84
	wasm-bindgen-macro-support-0.2.84
	wasm-bindgen-shared-0.2.84
	wayland-client-0.29.5
	wayland-commons-0.29.5
	wayland-cursor-0.29.5
	wayland-egl-0.29.5
	wayland-protocols-0.29.5
	wayland-scanner-0.29.5
	wayland-sys-0.29.5
	web-sys-0.3.61
	weezl-0.1.7
	wgpu-0.15.1
	wgpu-core-0.15.1
	wgpu-hal-0.15.4
	wgpu-types-0.15.2
	whoami-1.4.0
	widestring-0.5.1
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-0.33.0
	windows-0.43.0
	windows-0.44.0
	windows-0.46.0
	windows-sys-0.42.0
	windows-sys-0.45.0
	windows-targets-0.42.2
	windows_aarch64_gnullvm-0.42.2
	windows_aarch64_msvc-0.33.0
	windows_aarch64_msvc-0.42.2
	windows_i686_gnu-0.33.0
	windows_i686_gnu-0.42.2
	windows_i686_msvc-0.33.0
	windows_i686_msvc-0.42.2
	windows_x86_64_gnu-0.33.0
	windows_x86_64_gnu-0.42.2
	windows_x86_64_gnullvm-0.42.2
	windows_x86_64_msvc-0.33.0
	windows_x86_64_msvc-0.42.2
	winnow-0.4.1
	winreg-0.10.1
	wio-0.2.2
	x11-2.21.0
	xattr-0.2.3
	xcb-1.2.0
	xcb-imdkit-0.1.2
	xcursor-0.3.4
	xkbcommon-0.5.0
	xml-rs-0.8.4
	yaml-rust-0.4.5
	yasna-0.5.1
	zbus-3.11.1
	zbus_macros-3.11.1
	zbus_names-2.5.0
	zstd-0.11.2+zstd.1.5.2
	zstd-safe-5.0.2+zstd.1.5.2
	zstd-sys-2.0.7+zstd.1.5.4
	zune-inflate-0.2.53
	zvariant-3.12.0
	zvariant_derive-3.12.0
	zvariant_utils-1.0.0
"

inherit bash-completion-r1 desktop cargo xdg-utils

DESCRIPTION="A GPU-accelerated cross-platform terminal emulator and multiplexer"
HOMEPAGE="https://wezfurlong.org/wezterm/"

MY_PV="$(ver_rs 1 -)-69ae8472"
MY_P="${PN}-${MY_PV}"

SRC_URI="
	https://github.com/wez/${PN}/releases/download/${MY_PV}/${MY_P}-src.tar.gz
	$(cargo_crate_uris)
	"

SUBMODULES=(
	"freetype2 github freetype https://github.com/wez/freetype2 3f83daeecb1a78d851b660eed025eeba362c0e4a"
	"libpng github freetype https://github.com/glennrp/libpng 8439534daa1d3a5705ba92e653eda9251246dd61"
	"zlib github freetype https://github.com/madler/zlib cacf7f1d4e3d44d871b605da3b647f07d718623f"
	"harfbuzz github harfbuzz https://github.com/harfbuzz/harfbuzz afcae83a064843d71d47624bc162e121cc56c08b"
	"libssh-rs-tmp github crates https://github.com/wez/libssh-rs 44a08196acd1a2277ec7ebce2a47618775f3c59c"
	"libssh gitlab crates https://gitlab.com/wez1/libssh-mirror 56e1b0a43a7601d3b2989299262a09db5d81eea0"
)

# License set may be more restrictive as OR is not respected
# use cargo-license for a more accurate license picture
LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions Artistic-2 BSD BSD-2 Boost-1.0 CC0-1.0 GPL-3 ISC LGPL-2.1 MIT MPL-2.0 Unicode-DFS-2016 Unlicense WTFPL-2 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="wayland"

RESTRICT=test # tests require network

PATCHES=(
	"${FILESDIR}/${PN}-20230320-124340-vendored-sources.patch"
	"${FILESDIR}/${PN}-20230320-124340-xcb-imdkit.patch"
	"${FILESDIR}/${PN}-20230320-124340-image.patch"
)

DEPEND="
	dev-libs/openssl
	wayland? ( dev-libs/wayland )
	media-fonts/jetbrains-mono
	media-fonts/noto
	media-fonts/noto-emoji
	media-fonts/roboto
	media-libs/fontconfig
	media-libs/mesa
	sys-apps/dbus
	x11-libs/libX11
	x11-libs/libxkbcommon[X,wayland?]
	x11-libs/xcb-util
	x11-libs/xcb-util-image
	x11-libs/xcb-util-keysyms
	x11-libs/xcb-util-wm
	x11-themes/hicolor-icon-theme
	x11-themes/xcursor-themes
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	dev-vcs/git
	virtual/pkgconfig
	virtual/rust
"

QA_FLAGS_IGNORED="
	usr/bin/.*
"

S="${WORKDIR}/${MY_P}"

submodule_uris() {
	for line in "${SUBMODULES[@]}"; do
		read -r name hoster dep url commit <<< "${line}" || die

		if [ ${hoster} == "github" ];
		then
			SRC_URI+=" ${url}/archive/${commit}.tar.gz -> ${url##*/}-${commit}.tar.gz"
		elif [ ${hoster} == "gitlab" ];
		then
			SRC_URI+=" ${url}/-/archive/${commit}/${url##*/}-${commit}.tar.gz"
		else
			die
		fi
	done
}

submodule_uris

src_prepare() {
	for line in "${SUBMODULES[@]}"; do
		read -r name hoster dep url commit <<< "${line}" || die

		mkdir -p "${S}/deps/${dep}/${name}" || die
		cp -r "${WORKDIR}"/${url##*/}-${commit}/* "${S}/deps/${dep}/${name}" || die
	done

	pushd "${WORKDIR}"/cargo_home/gentoo/xcb-imdkit-0.1.2 || die
	eapply "${FILESDIR}"/xcb-imdkit-0.1.2-p1.patch
	eapply "${FILESDIR}"/xcb-imdkit-0.1.2-p2.patch
	eapply "${FILESDIR}"/xcb-imdkit-0.1.2-p3.patch
	popd || die

	mv "${S}/deps/crates/libssh-rs-tmp/libssh-rs" "${S}/deps/crates" || die
	mv "${S}/deps/crates/libssh-rs-tmp/libssh-rs-sys" "${S}/deps/crates" || die
	cp -r "${S}"/deps/crates/libssh/* "${S}/deps/crates/libssh-rs-sys/vendored/" || die
	rm -rf "${S}/deps/crates/libssh-rs-tmp" || die
	rm -rf "${S}/deps/crates/libssh" || die
	echo '{"files":{}}' > "${S}/deps/crates/libssh-rs/.cargo-checksum.json" || die
	echo '{"files":{}}' > "${S}/deps/crates/libssh-rs-sys/.cargo-checksum.json" || die
	echo '{"files":{}}' > "${WORKDIR}/cargo_home/gentoo/xcb-imdkit-0.1.2/.cargo-checksum.json" || die

	echo "${MY_PV}-gentoo" > .tag || die

	default
	eapply_user
}

src_configure() {
	local myfeatures=(
		distro-defaults
		vendor-nerd-font-symbols-font
		$(usev wayland)
	)
	cargo_src_configure --no-default-features
}

src_compile() {
	cargo_src_compile
}

src_install() {
	exeinto /usr/bin
	doexe target/$(usex debug "debug" "release")/wezterm
	doexe target/$(usex debug "debug" "release")/wezterm-gui
	doexe target/$(usex debug "debug" "release")/wezterm-mux-server
	doexe target/$(usex debug "debug" "release")/strip-ansi-escapes

	insinto /usr/share/icons/hicolor/128x128/apps
	newins assets/icon/terminal.png org.wezfurlong.wezterm.png

	newmenu assets/wezterm.desktop org.wezfurlong.wezterm.desktop

	insinto /usr/share/metainfo
	newins assets/wezterm.appdata.xml org.wezfurlong.wezterm.appdata.xml

	newbashcomp assets/shell-completion/bash ${PN}

	insopts -m 0644
	insinto /usr/share/zsh/site-functions
	newins assets/shell-completion/zsh _${PN}

	insopts -m 0644
	insinto /usr/share/fish/vendor_completions.d
	newins assets/shell-completion/fish ${PN}.fish
}

pkg_postinst() {
	xdg_icon_cache_update
	einfo "It may be necessary to configure wezterm to use a cursor theme, see:"
	einfo "https://wezfurlong.org/wezterm/faq.html?highlight=xcursor_theme#i-use-x11-or-wayland-and-my-mouse-cursor-theme-doesnt-seem-to-work"
	einfo "It may be necessary to set the environment variable XCURSOR_PATH"
	einfo "to the directory containing the cursor icons, for example"
	einfo 'export XCURSOR_PATH="/usr/share/cursors/xorg-x11/"'
	einfo "before starting the wayland or X11 window compositor to avoid the error:"
	einfo "ERROR  window::os::wayland::frame > Unable to set cursor to left_ptr: cursor not found"
	einfo "For example, in the file ~/.wezterm.lua:"
	einfo "return {"
	einfo '  xcursor_theme = "whiteglass"'
	einfo "}"
}

pkg_postrm() {
	xdg_icon_cache_update
}
