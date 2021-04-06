# Setup the Freedom build script environment
include ../../scripts/Freedom.mk

# Include version identifiers to build up the full version string
include Metadata.mk
PACKAGE_WORDING := Bare Metal GCC
PACKAGE_HEADING := riscv64-unknown-elf-gcc
PACKAGE_VERSION := $(RISCV_GCC_VERSION)-$(FREEDOM_GCC_METAL_ID)$(EXTRA_SUFFIX)
PACKAGE_COMMENT := \# SiFive Freedom Package Properties File

# Source code directory references
BARE_METAL_ABI := lp64d
BARE_METAL_ARCH := rv64imafdc
BARE_METAL_CMODEL := medany
BARE_METAL_TUPLE := riscv64-unknown-elf
BARE_METAL_CC_FOR_TARGET ?= $(BARE_METAL_TUPLE)-gcc
BARE_METAL_CXX_FOR_TARGET ?= $(BARE_METAL_TUPLE)-g++
BARE_METAL_CFLAGS_FOR_TARGET := -mcmodel=$(BARE_METAL_CMODEL)
BARE_METAL_CXXFLAGS_FOR_TARGET := -mcmodel=$(BARE_METAL_CMODEL)

ifeq ($(EXTRA_OPTION),minimal)
BARE_METAL_MULTILIBS_GEN := \
	rv32emac-ilp32e-- \
	rv32imac-ilp32-- \
	rv32imafc-ilp32f-- \
	rv32imafdc-ilp32d-- \
	rv64imac-lp64-- \
	rv64imafc-lp64f-- \
	rv64imafdc-lp64d-- \
	--cmodel=compact
else ifeq ($(EXTRA_OPTION),basic)
BARE_METAL_MULTILIBS_GEN := \
	rv32e-ilp32e-- \
	rv32emac-ilp32e-- \
	rv32i-ilp32-- \
	rv32imac-ilp32-- \
	rv32if-ilp32f-- \
	rv32imafc-ilp32f-- \
	rv32ifd-ilp32d-- \
	rv32imafdc-ilp32d-- \
	rv64i-lp64-- \
	rv64imac-lp64-- \
	rv64if-lp64f-- \
	rv64imafc-lp64f-- \
	rv64ifd-lp64d-- \
	rv64imafdc-lp64d-- \
	--cmodel=compact
else
BARE_METAL_MULTILIBS_GEN := \
	rv32ec-ilp32e-- \
	rv32ec_zba_zbb-ilp32e-- \
	rv32eac-ilp32e-- \
	rv32eac_zba_zbb-ilp32e-- \
	rv32emc-ilp32e-- \
	rv32emc_zba_zbb-ilp32e-- \
	rv32emac-ilp32e-- \
	rv32emac_zba_zbb-ilp32e-- \
	rv32ic-ilp32-- \
	rv32ic_zba_zbb-ilp32-- \
	rv32iac-ilp32-- \
	rv32iac_zba_zbb-ilp32-- \
	rv32imc-ilp32-- \
	rv32imc_zba_zbb-ilp32-- \
	rv32imac-ilp32-- \
	rv32imac_zba_zbb-ilp32-- \
	rv32imfc-ilp32f-- \
	rv32imfc_zba_zbb-ilp32f-- \
	rv32imafc-ilp32f-- \
	rv32imafc_zba_zbb-ilp32f-- \
	rv32imfdc-ilp32d-- \
	rv32imfdc_zba_zbb-ilp32d-- \
	rv32imafdc-ilp32d-- \
	rv32imafdc_zba_zbb-ilp32d-- \
	rv64ic-lp64-- \
	rv64ic_zba_zbb-lp64-- \
	rv64iac-lp64-- \
	rv64iac_zba_zbb-lp64-- \
	rv64imc-lp64-- \
	rv64imc_zba_zbb-lp64-- \
	rv64imac-lp64-- \
	rv64imac_zba_zbb-lp64-- \
	rv64imfc-lp64f-- \
	rv64imfc_zba_zbb-lp64f-- \
	rv64imafc-lp64f-- \
	rv64imafc_zba_zbb-lp64f-- \
	rv64imfdc-lp64d-- \
	rv64imfdc_zba_zbb-lp64d-- \
	rv64imafdc-lp64d-- \
	rv64imafdc_zba_zbb-lp64d-- \
	--cmodel=compact
endif

# Some special package configure flags for specific targets
$(WIN64)-binutils-host          := --host=$(WIN64)
$(WIN64)-binutils-configure     := --with-included-gettext
$(WIN64)-gcc-host               := --host=$(WIN64)
$(WIN64)-gcc-configure          := --without-system-zlib
$(UBUNTU64)-binutils-host       := --host=x86_64-linux-gnu
$(UBUNTU64)-binutils-configure  := --with-included-gettext
$(UBUNTU64)-gcc-host            := --host=x86_64-linux-gnu
$(UBUNTU64)-gcc-configure       := --with-system-zlib
$(DARWIN)-binutils-configure    := --with-included-gettext
$(DARWIN)-gcc-configure         := --with-system-zlib
$(REDHAT)-binutils-configure    := --with-included-gettext
$(REDHAT)-gcc-configure         := --with-system-zlib

# Setup the package targets and switch into secondary makefile targets
# Targets $(PACKAGE_HEADING)/install.stamp and $(PACKAGE_HEADING)/libs.stamp
include ../../scripts/Package.mk

# The package build needs the tools in the PATH, and the windows build might use the ubuntu (native)
PATH := $(abspath $(OBJ_WIN64)/build/$(PACKAGE_HEADING)/extra-install/bin):$(PATH)
export PATH

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/install.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gcc-stage2/build.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/install.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/install.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_PROPERTIES := $(patsubst %/build/$(PACKAGE_HEADING)/install.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET).properties,$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/install.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/install.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	mkdir -p $(dir $@)
	git log --format="[%ad] %s" > $(abspath $($@_INSTALL))/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET).changelog
	rm -f $(abspath $($@_PROPERTIES))
	echo "$(PACKAGE_COMMENT)" > $(abspath $($@_PROPERTIES))
	echo "PACKAGE_TYPE = freedom-tools" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_DESC_SEG = $(PACKAGE_WORDING)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_FIXED_ID = $(PACKAGE_HEADING)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_BUILD_ID = $(FREEDOM_GCC_METAL_ID)$(EXTRA_SUFFIX)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_CORE_VER = $(RISCV_GCC_VERSION)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_TARGET = $($@_TARGET)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_VENDOR = SiFive" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_RIGHTS = sifive-v00 eclipse-v20" >> $(abspath $($@_PROPERTIES))
	echo "RISCV_TAGS = $(FREEDOM_GCC_METAL_RISCV_TAGS)" >> $(abspath $($@_PROPERTIES))
	echo "TOOLS_TAGS = $(FREEDOM_GCC_METAL_TOOLS_TAGS)" >> $(abspath $($@_PROPERTIES))
	cp $(abspath $($@_PROPERTIES)) $(abspath $($@_INSTALL))/
	tclsh ../../scripts/check-maximum-path-length.tcl $(abspath $($@_INSTALL)) "$(PACKAGE_HEADING)" "$(RISCV_GCC_VERSION)" "$(FREEDOM_GCC_METAL_ID)$(EXTRA_SUFFIX)"
	tclsh ../../scripts/check-same-name-different-case.tcl $(abspath $($@_INSTALL))
	rm -rf $(abspath $($@_BUILD))/install-gcc
	cp -a $(abspath $($@_INSTALL)) $(abspath $($@_BUILD))/install-gcc
	cat $($@_BUILDLOG)/install-binutils-file-list | xargs rm -rf
	echo $(PATH)
	date > $@

# We might need some extra target libraries for this package
$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/libs.stamp: \
		$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/install.stamp
	date > $@

$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/libs.stamp: \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/install.stamp
	-$(WIN64)-gcc -print-search-dirs | grep ^programs | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libwinpthread*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/bin
	-$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libgcc_s_seh*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/bin
	-$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libstdc*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/bin
	-$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libssp*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/bin
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/source.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/source.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	$(eval $@_SRCBALL := $(abspath $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET).src.tar.gz))
	tclsh ../../scripts/check-naming-and-version-syntax.tcl "$(PACKAGE_WORDING)" "$(PACKAGE_HEADING)" "$(RISCV_GCC_VERSION)" "$(FREEDOM_GCC_METAL_ID)$(EXTRA_SUFFIX)"
	rm -rf $($@_INSTALL)
	mkdir -p $($@_INSTALL)
	rm -rf $($@_BUILDLOG)
	mkdir -p $($@_BUILDLOG)
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	git log > $($@_BUILDLOG)/$(PACKAGE_HEADING)-git-commit.log
	git remote -v > $($@_BUILDLOG)/$(PACKAGE_HEADING)-git-remote.log
	git clone --single-branch --branch $(RISCV_BINUTILS_BRANCH) $(RISCV_BINUTILS_GITURL) $(dir $@)/$(RISCV_BINUTILS_FOLDER)
	cd $(dir $@)/$(RISCV_BINUTILS_FOLDER) && git checkout --detach $(RISCV_BINUTILS_COMMIT)
	cd $(dir $@)/$(RISCV_BINUTILS_FOLDER) && git submodule update --init --recursive
	git clone --single-branch --branch $(RISCV_GCC_BRANCH) $(RISCV_GCC_GITURL) $(dir $@)/$(RISCV_GCC_FOLDER)
	cd $(dir $@)/$(RISCV_GCC_FOLDER) && git checkout --detach $(RISCV_GCC_COMMIT)
	cd $(dir $@)/$(RISCV_GCC_FOLDER) && git submodule update --init --recursive
	git clone --single-branch --branch $(RISCV_NEWLIB_BRANCH) $(RISCV_NEWLIB_GITURL) $(dir $@)/$(RISCV_NEWLIB_FOLDER)
	cd $(dir $@)/$(RISCV_NEWLIB_FOLDER) && git checkout --detach $(RISCV_NEWLIB_COMMIT)
	cd $(dir $@)/$(RISCV_NEWLIB_FOLDER) && git submodule update --init --recursive
	cd $(dir $@)/riscv-gcc; ./contrib/download_prerequisites
	cd $(dir $@)/riscv-gcc/gcc/config/riscv; rm t-elf-multilib; ./multilib-generator $(BARE_METAL_MULTILIBS_GEN) > t-elf-multilib
	cp $(dir $@)/riscv-gcc/gcc/config/riscv/t-elf-multilib $($@_BUILDLOG)/riscv-gcc-t-elf-multilib
	mkdir -p $(dir $($@_SRCBALL))
	cd $(dir $@); $(TAR) --dereference --hard-dereference -c $(RISCV_BINUTILS_FOLDER) $(RISCV_GCC_FOLDER) $(RISCV_NEWLIB_FOLDER) | gzip > $($@_SRCBALL)
	date > $@

# Reusing binutils build script across binutils-metal, gcc-metal and trace-decoder
include ../freedom-binutils-metal/scripts/build_binutils_target.mk
include ../freedom-binutils-metal/scripts/extra_binutils_target.mk

$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/extra-binutils/extra.stamp: \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/extra-binutils/transit.stamp
	$(eval $@_EXTRA := $(patsubst %/build/$(PACKAGE_HEADING)/extra-binutils/extra.stamp,%/build/$(PACKAGE_HEADING)/extra-install,$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/extra-binutils/extra.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/extra-binutils-make-install.log
	date > $@

$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/extra-gcc-stage1/extra.stamp: \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/extra-binutils/extra.stamp
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/extra-gcc-stage1/extra.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64),$@))
	$(eval $@_EXTRA := $(patsubst %/build/$(PACKAGE_HEADING)/extra-gcc-stage1/extra.stamp,%/build/$(PACKAGE_HEADING)/extra-install,$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/extra-gcc-stage1/extra.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/extra-gcc-stage1/extra.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	# Workaround for CentOS random build fail issue
	#
	# Corresponding bugzilla entry on upstream:
	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92008
	touch $(abspath $($@_BUILD))/riscv-gcc/intl/plural.c
	cd $(dir $@) && $(abspath $($@_BUILD))/riscv-gcc/configure \
		--target=$(BARE_METAL_TUPLE) \
		$($(NATIVE)-gcc-host) \
		--prefix=$(abspath $($@_EXTRA)) \
		--with-pkgversion="SiFive GCC-Metal $(PACKAGE_VERSION)" \
		--with-bugurl="https://github.com/sifive/freedom-tools/issues" \
		--disable-shared \
		--disable-threads \
		--disable-tls \
		--enable-languages=c,c++ \
		--with-newlib \
		--with-sysroot=$(abspath $($@_EXTRA))/$(BARE_METAL_TUPLE) \
		--disable-libmudflap \
		--disable-libssp \
		--disable-libquadmath \
		--disable-libgomp \
		--disable-nls \
		--disable-tm-clone-registry \
		--src=../riscv-gcc \
		$($(NATIVE)-gcc-configure) \
		--enable-checking=yes \
		--enable-multilib \
		--with-abi=$(BARE_METAL_ABI) \
		--with-arch=$(BARE_METAL_ARCH) \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" \
		CFLAGS_FOR_TARGET="-Os $(BARE_METAL_CFLAGS_FOR_TARGET)" \
		CXXFLAGS_FOR_TARGET="-Os $(BARE_METAL_CXXFLAGS_FOR_TARGET)" &>$($@_BUILDLOG)/extra-gcc-stage1-make-configure.log
	$(MAKE) -C $(dir $@) all-gcc &>$($@_BUILDLOG)/extra-gcc-stage1-make-build.log
	$(MAKE) -C $(dir $@) -j1 install-gcc &>$($@_BUILDLOG)/extra-gcc-stage1-make-install.log
	mkdir -p $(abspath $($@_INSTALL))/$(BARE_METAL_TUPLE)/include
	rm -rf $(abspath $($@_EXTRA))/$(BARE_METAL_TUPLE)/include
	ln -s $(abspath $($@_INSTALL))/$(BARE_METAL_TUPLE)/include $(abspath $($@_EXTRA))/$(BARE_METAL_TUPLE)/include
	mkdir -p $(abspath $($@_INSTALL))/$(BARE_METAL_TUPLE)/lib
	rm -rf $(abspath $($@_EXTRA))/$(BARE_METAL_TUPLE)/lib
	ln -s $(abspath $($@_INSTALL))/$(BARE_METAL_TUPLE)/lib $(abspath $($@_EXTRA))/$(BARE_METAL_TUPLE)/lib
	rm -rf $(abspath $($@_EXTRA))/lib/gcc/$(BARE_METAL_TUPLE)/$(RISCV_GCC_VERSION)/include/unwind.h
	ln -s $(abspath $($@_BUILD))/riscv-gcc/libgcc/unwind-generic.h $(abspath $($@_EXTRA))/lib/gcc/$(BARE_METAL_TUPLE)/$(RISCV_GCC_VERSION)/include/unwind.h
	date > $@

$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/build-binutils/build.stamp: \
		$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/build-binutils/support.stamp
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/build-binutils/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/build-binutils/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/build-binutils-make-install.log
	find $(abspath $($@_INSTALL)) -type f > $($@_BUILDLOG)/install-binutils-file-list
	date > $@

$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/build-binutils/build.stamp: \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/build-binutils/support.stamp \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/extra-gcc-stage1/extra.stamp
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/build-binutils/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/build-binutils/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/build-binutils-make-install.log
	find $(abspath $($@_INSTALL)) -type f > $($@_BUILDLOG)/install-binutils-file-list
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gcc-stage1/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-binutils/build.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gcc-stage1/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/build-gcc-stage1/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/build-gcc-stage1/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/build-gcc-stage1/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	# Workaround for CentOS random build fail issue
	#
	# Corresponding bugzilla entry on upstream:
	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92008
	touch $(abspath $($@_BUILD))/riscv-gcc/intl/plural.c
	cd $(dir $@) && $(abspath $($@_BUILD))/riscv-gcc/configure \
		--target=$(BARE_METAL_TUPLE) \
		$($($@_TARGET)-gcc-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--with-pkgversion="SiFive GCC-Metal $(PACKAGE_VERSION)" \
		--with-bugurl="https://github.com/sifive/freedom-tools/issues" \
		--disable-shared \
		--disable-threads \
		--disable-tls \
		--enable-languages=c,c++ \
		--with-newlib \
		--with-sysroot=$(abspath $($@_INSTALL))/$(BARE_METAL_TUPLE) \
		--disable-libmudflap \
		--disable-libssp \
		--disable-libquadmath \
		--disable-libgomp \
		--disable-nls \
		--disable-tm-clone-registry \
		--src=../riscv-gcc \
		$($($@_TARGET)-gcc-configure) \
		--enable-checking=yes \
		--enable-multilib \
		--with-abi=$(BARE_METAL_ABI) \
		--with-arch=$(BARE_METAL_ARCH) \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" \
		CFLAGS_FOR_TARGET="-Os $(BARE_METAL_CFLAGS_FOR_TARGET)" \
		CXXFLAGS_FOR_TARGET="-Os $(BARE_METAL_CXXFLAGS_FOR_TARGET)" &>$($@_BUILDLOG)/build-gcc-stage1-make-configure.log
	$(MAKE) -C $(dir $@) all-gcc &>$($@_BUILDLOG)/build-gcc-stage1-make-build.log
	$(MAKE) -C $(dir $@) -j1 install-gcc &>$($@_BUILDLOG)/build-gcc-stage1-make-install.log
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-newlib/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gcc-stage1/build.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-newlib/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/build-newlib/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/build-newlib/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/build-newlib/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	@echo "PATH: $(PATH)"
	cd $(dir $@) && $(abspath $($@_BUILD))/riscv-newlib/configure \
		--target=$(BARE_METAL_TUPLE) \
		$($($@_TARGET)-gcc-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-newlib-io-long-double \
		--enable-newlib-io-long-long \
		--enable-newlib-io-c99-formats \
		--enable-newlib-register-fini \
		CFLAGS_FOR_TARGET="-O2 -D_POSIX_MODE $(BARE_METAL_CFLAGS_FOR_TARGET)" \
		CXXFLAGS_FOR_TARGET="-O2 -D_POSIX_MODE $(BARE_METAL_CXXFLAGS_FOR_TARGET)" &>$($@_BUILDLOG)/build-newlib-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/build-newlib-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/build-newlib-make-install.log
# These install multiple copies of the same docs into the same destination
# for a multilib build.  So we must not parallelize them.
# TODO: Rewrite so that we only install one copy of the docs.
	$(MAKE) -j1 -C $(dir $@) install-pdf install-html &>$($@_BUILDLOG)/build-newlib-make-install-doc.log
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-newlib-nano/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gcc-stage1/build.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-newlib-nano/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/build-newlib-nano/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/build-newlib-nano/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/build-newlib-nano/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	@echo "PATH: $(PATH)"
	cd $(dir $@) && $(abspath $($@_BUILD))/riscv-newlib/configure \
		--target=$(BARE_METAL_TUPLE) \
		$($($@_TARGET)-gcc-host) \
		--prefix=$(abspath $($@_BUILD)/build-newlib-nano-install) \
		--enable-newlib-reent-small \
		--disable-newlib-fvwrite-in-streamio \
		--disable-newlib-fseek-optimization \
		--disable-newlib-wide-orient \
		--enable-newlib-nano-malloc \
		--disable-newlib-unbuf-stream-opt \
		--enable-lite-exit \
		--enable-newlib-global-atexit \
		--enable-newlib-nano-formatted-io \
		--disable-newlib-supplied-syscalls \
		--disable-nls \
		CFLAGS_FOR_TARGET="-Os -ffunction-sections -fdata-sections $(BARE_METAL_CFLAGS_FOR_TARGET)" \
		CXXFLAGS_FOR_TARGET="-Os -ffunction-sections -fdata-sections $(BARE_METAL_CXXFLAGS_FOR_TARGET)" &>$($@_BUILDLOG)/build-newlib-nano-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/build-newlib-nano-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/build-newlib-nano-make-install.log
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-newlib-nano-install/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-newlib-nano/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-newlib/build.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-newlib-nano-install/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/build-newlib-nano-install/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/build-newlib-nano-install/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/build-newlib-nano-install/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
# Copy nano library files into newlib install dir.
	set -e; \
	bnl="$(abspath $($@_BUILD))/build-newlib-nano-install/$(BARE_METAL_TUPLE)/lib"; \
	inl="$(abspath $($@_INSTALL))/$(BARE_METAL_TUPLE)/lib"; \
	for bnlc in `find $${bnl} -name libc.a`; \
	do \
		inlc=`echo $${bnlc} | $(SED) -e "s:$${bnl}::" | $(SED) -e "s:libc\.a:libc_nano.a:g"`; \
		cp -v $${bnlc} $${inl}$${inlc}; \
	done; \
	for bnlm in `find $${bnl} -name libm.a`; \
	do \
		inlm=`echo $${bnlm} | $(SED) -e "s:$${bnl}::" | $(SED) -e "s:libm\.a:libm_nano.a:g"`; \
		cp -v $${bnlm} $${inl}$${inlm}; \
	done; \
	for bnlg in `find $${bnl} -name libg.a`; \
	do \
		inlg=`echo $${bnlg} | $(SED) -e "s:$${bnl}::" | $(SED) -e "s:libg\.a:libg_nano.a:g"`; \
		cp -v $${bnlg} $${inl}$${inlg}; \
	done; \
	for bnls in `find $${bnl} -name libgloss.a`; \
	do \
		inls=`echo $${bnls} | $(SED) -e "s:$${bnl}::" | $(SED) -e "s:libgloss\.a:libgloss_nano.a:g"`; \
		cp -v $${bnls} $${inl}$${inls}; \
	done; \
	for bnls in `find $${bnl} -name crt0.o`; \
	do \
		inls=`echo $${bnls} | $(SED) -e "s:$${bnl}::"`; \
		cp -v $${bnls} $${inl}$${inls}; \
	done
# Copy nano header files into newlib install dir.
	mkdir -p $(abspath $($@_INSTALL))/$(BARE_METAL_TUPLE)/include/newlib-nano; \
	cp $(abspath $($@_BUILD))/build-newlib-nano-install/$(BARE_METAL_TUPLE)/include/newlib.h \
		$(abspath $($@_INSTALL))/$(BARE_METAL_TUPLE)/include/newlib-nano/newlib.h; \
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gcc-stage2/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-newlib-nano-install/build.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gcc-stage2/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/build-gcc-stage2/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/build-gcc-stage2/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/build-gcc-stage2/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cd $(dir $@) && $(abspath $($@_BUILD))/riscv-gcc/configure \
		--target=$(BARE_METAL_TUPLE) \
		$($($@_TARGET)-gcc-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--with-pkgversion="SiFive GCC-Metal $(PACKAGE_VERSION)" \
		--with-bugurl="https://github.com/sifive/freedom-tools/issues" \
		--disable-shared \
		--disable-threads \
		--enable-languages=c,c++ \
		--enable-tls \
		--with-newlib \
		--with-sysroot=$(abspath $($@_INSTALL))/$(BARE_METAL_TUPLE) \
		--with-native-system-header-dir=/include \
		--disable-libmudflap \
		--disable-libssp \
		--disable-libquadmath \
		--disable-libgomp \
		--disable-nls \
		--disable-tm-clone-registry \
		--src=../riscv-gcc \
		$($($@_TARGET)-gcc-configure) \
		--enable-checking=yes \
		--enable-multilib \
		--with-abi=$(BARE_METAL_ABI) \
		--with-arch=$(BARE_METAL_ARCH) \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" \
		CFLAGS_FOR_TARGET="-Os $(BARE_METAL_CFLAGS_FOR_TARGET)" \
		CXXFLAGS_FOR_TARGET="-Os $(BARE_METAL_CXXFLAGS_FOR_TARGET)" &>$($@_BUILDLOG)/build-gcc-stage2-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/build-gcc-stage2-make-build.log
	$(MAKE) -C $(dir $@) -j1 install install-pdf install-html &>$($@_BUILDLOG)/build-gcc-stage2-make-install.log
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/riscv64-unknown-elf-c++
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/riscv64-unknown-elf-g++
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/riscv64-unknown-elf-gcc
	date > $@

$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/test.stamp: \
		$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/launch.stamp
	mkdir -p $(dir $@)
	PATH=$(abspath $(OBJDIR)/$(NATIVE)/launch/$(PACKAGE_TARNAME)/bin):$(PATH) riscv64-unknown-elf-c++ -v
	PATH=$(abspath $(OBJDIR)/$(NATIVE)/launch/$(PACKAGE_TARNAME)/bin):$(PATH) riscv64-unknown-elf-g++ -v
	PATH=$(abspath $(OBJDIR)/$(NATIVE)/launch/$(PACKAGE_TARNAME)/bin):$(PATH) riscv64-unknown-elf-gcc -v
	@echo "Finished testing $(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).tar.gz tarball"
	date > $@
