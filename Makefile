RUST_NIGHTLY_VERSION  := $(shell cat rust-toolchain-nightly)
GRCOV_VERSION         := 0.8.13

install-nightly:
	rustup toolchain install $(RUST_NIGHTLY_VERSION)

tools/grcov/$(GRCOV_VERSION)/grcov:
	mkdir -p tools/grcov/$(GRCOV_VERSION)/ && \
	cd tools/grcov/$(GRCOV_VERSION) && wget https://github.com/mozilla/grcov/releases/download/v$(GRCOV_VERSION)/$(GRCOV_RELEASE) && tar -xvf $(GRCOV_RELEASE)
	rm tools/grcov/$(GRCOV_VERSION)/grcov-*.tar.bz2
	rustup component add llvm-tools-preview

.PHONY: test
test:
	cargo test --workspace --all-targets
	cargo test --workspace --doc

lint:
	cargo +$(RUST_NIGHTLY_VERSION) fmt \
		-- \
		--check
	cargo clippy \
		--workspace \
		--tests \
		--benches \
		-- \
		-D clippy::complexity \
		-D clippy::correctness \
		-D clippy::perf \
		-D clippy::style \
		-D clippy::suspicious \
		-D clippy::todo \
		-D clippy::doc_link_with_quotes \
		-D clippy::doc_markdown \
		-D clippy::cloned_instead_of_copied \
		-D clippy::checked_conversions \
		-D clippy::filter_map_next \
		-D clippy::manual_instant_elapsed \
		-D clippy::cast_possible_wrap \
		-D clippy::cast_lossless \
		-D clippy::cast_possible_truncation \
		-D clippy::cast_sign_loss \
		-D clippy::dbg_macro \
		-D clippy::expect_used \
		-D clippy::format_push_string \
		-D clippy::get_unwrap \
		-D clippy::if_then_some_else_none \
		-D clippy::panic \
		-D clippy::panic_in_result_fn \
		-D clippy::print_stderr \
		-D clippy::print_stdout \
		-D clippy::try_err \
		-D clippy::unimplemented \
		-D clippy::unnecessary_self_imports \
		-D clippy::unneeded_field_pattern \
		-D clippy::unreachable \
		-D clippy::use_debug
	cargo doc \
		--all \
		--no-deps \
		--document-private-items

fmt:
	cargo +$(RUST_NIGHTLY_VERSION) fmt

udeps:
	cargo +$(RUST_NIGHTLY_VERSION) udeps

.PHONY: clean
clean:
	rm -rf target

.PHONY: build
build:
	cargo build

.PHONY: build-release
build-release:
	cargo build --release

.PHONY: coverage-lcov
coverage-lcov: tools/grcov/$(GRCOV_VERSION)/grcov
	export RUSTFLAGS="-Zinstrument-coverage" && \
	export RUSTC_BOOTSTRAP=1 && \
	export LLVM_PROFILE_FILE="llvm-%p-%m.profraw" && \
	cargo build && \
	cargo test --workspace --lib --bins && \
	tools/grcov/$(GRCOV_VERSION)/grcov . \
		-s . \
		--binary-path ./target/debug/ \
		-t lcov \
		--branch \
		--ignore-not-existing \
		--keep-only=/src/**/*.rs \
		-o ./coverage.lcov

.PHONY: coverage-html
coverage-html: tools/grcov/$(GRCOV_VERSION)/grcov
	export RUSTFLAGS="-Zinstrument-coverage" && \
	export RUSTC_BOOTSTRAP=1 && \
	export LLVM_PROFILE_FILE="llvm-%p-%m.profraw" && \
	cargo build && \
	cargo test --workspace --lib --bins && \
	tools/grcov/$(GRCOV_VERSION)/grcov . \
		-s . \
		--binary-path ./target/debug/ \
		-t html \
		--branch \
		--ignore-not-existing \
		--keep-only=/src/**/*.rs \
		-o ./coverage && \
		open coverage/index.html