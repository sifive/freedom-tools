# The default target
.PHONY: all
all:

BINDIR := bin
OBJDIR := obj
SRCDIR := src

UBUNTU32 ?= i686-linux-ubuntu14
UBUNTU64 ?= x86_64-linux-ubuntu14
REDHAT ?= x86_64-linux-centos6
WIN32  ?= i686-w64-mingw32
WIN64  ?= x86_64-w64-mingw32
DARWIN ?= x86_64-apple-darwin


-include /etc/lsb-release
ifneq ($(wildcard /etc/redhat-release),)
NATIVE ?= $(REDHAT)
all: redhat
else ifeq ($(DISTRIB_ID),Ubuntu)
ifeq ($(shell uname -m),x86_64)
NATIVE ?= $(UBUNTU64)
all: ubuntu64
else
NATIVE ?= $(UBUNTU32)
all: ubuntu32
endif
all: win64
else ifeq ($(shell uname),Darwin)
NATIVE ?= $(DARWIN)
LIBTOOLIZE ?= glibtoolize
TAR ?= gtar
SED ?= gsed
AWK ?= gawk
all: darwin
else
$(error Unknown host)
endif

LIBTOOLIZE ?= libtoolize
TAR ?= tar
SED ?= sed
AWK ?= awk

OBJ_NATIVE   := $(OBJDIR)/$(NATIVE)
OBJ_UBUNTU32 := $(OBJDIR)/$(UBUNTU32)
OBJ_UBUNTU64 := $(OBJDIR)/$(UBUNTU64)
OBJ_WIN32    := $(OBJDIR)/$(WIN32)
OBJ_WIN64    := $(OBJDIR)/$(WIN64)
OBJ_DARWIN   := $(OBJDIR)/$(DARWIN)
OBJ_REDHAT   := $(OBJDIR)/$(REDHAT)

SRC_RBU      := $(SRCDIR)/riscv-binutils
SRC_RGCC     := $(SRCDIR)/riscv-gcc
SRC_RGDB     := $(SRCDIR)/riscv-gdb
SRC_RNL      := $(SRCDIR)/riscv-newlib
SRC_ROCD     := $(SRCDIR)/riscv-openocd
SRC_EXPAT    := $(SRCDIR)/libexpat/expat
SRC_LIBUSB   := $(SRCDIR)/libusb
SRC_LIBFTDI  := $(SRCDIR)/libftdi

# The version that will be appended to the various tool builds.
RGT_VERSION := 8.2.0-2019.01.0-scie-rve-b1
ROCD_VERSION := 0.10.0-2019.01.0-scie-rve-b1

# Misc common variables
PATH := $(abspath $(OBJ_NATIVE)/install/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(NATIVE)/bin):$(PATH)
export PATH

# The actual output of this repository is a set of tarballs.
.PHONY: win64 win64-openocd win64-gcc
win64: win64-openocd win64-gcc
win64-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN64).zip
win64-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN64).tar.gz
win64-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN64).src.tar.gz
win64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN64).zip
win64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN64).tar.gz
win64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN64).src.tar.gz
.PHONY: win32 win32-openocd win32-gcc
win32: win32-openocd win32-gcc
win32-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN32).zip
win32-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN32).tar.gz
win32-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN32).src.tar.gz
win32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN32).zip
win32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN32).tar.gz
win32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN32).src.tar.gz
.PHONY: ubuntu64 ubuntu64-gcc ubuntu64-openocd
ubuntu64: ubuntu64-gcc ubuntu64-openocd
ubuntu64-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(UBUNTU64).src.tar.gz
ubuntu64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64).src.tar.gz
.PHONY: ubuntu32 ubuntu32-gcc ubuntu32-openocd
ubuntu32: ubuntu32-gcc ubuntu32-openocd
ubuntu32-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(UBUNTU32).tar.gz
ubuntu32-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(UBUNTU32).src.tar.gz
ubuntu32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU32).tar.gz
ubuntu32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU32).src.tar.gz
.PHONY: redhat redhat-gcc redhat-openocd
redhat: redhat-gcc redhat-openocd
redhat-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(REDHAT).tar.gz
redhat-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(REDHAT).src.tar.gz
redhat-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(REDHAT).tar.gz
redhat-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(REDHAT).src.tar.gz
.PHONY: darwin darwin-gcc darwin-openocd
darwin: darwin-gcc darwin-openocd
darwin-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(DARWIN).tar.gz
darwin-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(DARWIN).src.tar.gz
darwin-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(DARWIN).tar.gz
darwin-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(DARWIN).src.tar.gz


# Some special riscv-gnu-toolchain configure flags for specific targets.
$(WIN32)-rgt-host         := --host=$(WIN32)
$(WIN32)-rocd-vars        := LIBUSB1_LIBS="-L$(abspath $(OBJ_WIN32)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN32))/lib" CFLAGS="-O2"
$(WIN32)-rocd-configure   := --host=$(WIN32)
$(WIN32)-expat-configure  := --host=$(WIN32)
$(WIN32)-libusb-configure := --host=$(WIN32)
$(WIN32)-libftdi-configure := -DCMAKE_TOOLCHAIN_FILE="$(abspath $(SRC_LIBFTDI)/cmake/Toolchain-i686-w64-mingw32.cmake)" -DLIBUSB_LIBRARIES="$(abspath $(OBJ_WIN32)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN32)/bin/libusb-1.0.dll)" -DLIBUSB_INCLUDE_DIR="$(abspath $(OBJ_WIN32)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN32)/include/libusb-1.0)"
$(WIN64)-rgt-host         := --host=$(WIN64)
$(WIN64)-rocd-vars        := LIBUSB1_LIBS="-L$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64))/lib" CFLAGS="-O2"
$(WIN64)-rocd-configure   := --host=$(WIN64)
$(WIN64)-expat-configure  := --host=$(WIN64)
$(WIN64)-libusb-configure := --host=$(WIN64)
$(WIN64)-libftdi-configure := -DCMAKE_TOOLCHAIN_FILE="$(abspath $(SRC_LIBFTDI)/cmake/Toolchain-x86_64-w64-mingw32.cmake)" -DLIBUSB_LIBRARIES="$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64)/bin/libusb-1.0.dll)" -DLIBUSB_INCLUDE_DIR="$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64)/include/libusb-1.0)"
$(UBUNTU32)-rgt-host         := --host=i686-linux-gnu
$(UBUNTU32)-rocd-configure   := --host=i686-linux-gnu
$(UBUNTU32)-expat-configure  := --host=i686-linux-gnu
$(UBUNTU32)-libusb-configure := --host=i686-linux-gnu
$(UBUNTU64)-rgt-host         := --host=x86_64-linux-gnu
$(UBUNTU64)-rocd-configure   := --host=x86_64-linux-gnu
$(UBUNTU64)-expat-configure  := --host=x86_64-linux-gnu
$(UBUNTU64)-libusb-configure := --host=x86_64-linux-gnu
$(DARWIN)-rocd-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/riscv-openocd-$(ROCD_VERSION)-$(DARWIN))/lib/pkgconfig" LDFLAGS="-Wl,-framework,IOKit -Wl,-framework,CoreFoundation"
$(DARWIN)-expat-configure    := --disable-shared --enable-static
$(DARWIN)-libusb-configure   := --disable-shared --enable-static
$(DARWIN)-libftdi-configure  := -DCMAKE_SHARED_LINKER_FLAGS="-framework corefoundation -framework iokit"
$(REDHAT)-rocd-vars        := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/lib/pkgconfig" CFLAGS="-O2" LDFLAGS="-lrt"

# Some general riscv-gnu-toolchain flags
WITH_ABI := lp64d
WITH_ARCH := rv64imafdc
WITH_CMODEL := medany
NEWLIB_TUPLE := riscv64-unknown-elf
MULTILIB_FLAGS := --enable-multilib
NEWLIB_MULTILIBS := rv32e-ilp32e--c rv32em-ilp32e--c rv32eac-ilp32e-- rv32emac-ilp32e-- rv32i-ilp32--c rv32im-ilp32--c rv32iac-ilp32-- rv32imac-ilp32-- rv32imafc-ilp32f-rv32imafdc- rv32imafdc-ilp32d-- rv64imac-lp64-- rv64imafc-lp64f-rv64imafdc- rv64imafdc-lp64d--
GCC_CHECKING_FLAGS := --enable-checking=yes
GCC_SYSTEM_ZLIB_FLAGS := --without-system-zlib

CFLAGS_FOR_TARGET := $(CFLAGS_FOR_TARGET_EXTRA) -mcmodel=$(WITH_CMODEL)
CXXFLAGS_FOR_TARGET := $(CXXFLAGS_FOR_TARGET_EXTRA) -mcmodel=$(WITH_CMODEL)
# --with-expat is required to enable XML support used by OpenOCD.
BINUTILS_TARGET_FLAGS := --with-expat=yes $(BINUTILS_TARGET_FLAGS_EXTRA) --with-mpc=no --with-mpfr=no --with-gmp=no --with-python=no
GDB_TARGET_FLAGS := --with-expat=yes $(GDB_TARGET_FLAGS_EXTRA) --with-mpc=no --with-mpfr=no --with-gmp=no --with-python=no
NEWLIB_CC_FOR_TARGET ?= $(NEWLIB_TUPLE)-gcc
NEWLIB_CXX_FOR_TARGET ?= $(NEWLIB_TUPLE)-g++

# There's enough % rules that make starts blowing intermediate files away.
.SECONDARY:

# Builds riscv-gnu-toolchain for various targets.
$(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-%.zip: \
		$(OBJDIR)/%/stamps/riscv-gnu-toolchain/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-%.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/install; zip -r $(abspath $@) riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET)

$(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-%.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-gnu-toolchain/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-%.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/install -c riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET) | gzip > $(abspath $@)

$(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-%.src.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-gnu-toolchain/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-%.src.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/build -c . | gzip > $(abspath $@)

$(OBJDIR)/%/stamps/riscv-gnu-toolchain/install.stamp: \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/build-gcc-newlib-stage2/stamp \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/build-gdb-newlib/stamp
	mkdir -p $(dir $@)
	date > $@

$(OBJDIR)/%/build/riscv-gnu-toolchain/stamp:
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cp -a $(SRC_RBU) $(SRC_RGCC) $(SRC_RGDB) $(SRC_RNL) $(dir $@)
	cd $(dir $@)/riscv-gcc; ./contrib/download_prerequisites
	cd $(dir $@)/riscv-gcc/gcc/config/riscv; rm t-elf-multilib; ./multilib-generator $(NEWLIB_MULTILIBS) > t-elf-multilib
	date > $@

$(OBJDIR)/%/build/riscv-gnu-toolchain/build-binutils-newlib/stamp: \
		$(OBJDIR)/%/stamps/expat/install.stamp \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-toolchain/build-binutils-newlib/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-gnu-toolchain/build-binutils-newlib/stamp,%/install/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-gnu-toolchain/build-binutils-newlib/stamp,%/build/riscv-gnu-toolchain,$@))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
# CC_FOR_TARGET is required for the ld testsuite.
	cd $(dir $@) && CC_FOR_TARGET=$(NEWLIB_CC_FOR_TARGET) $(abspath $($@_BUILD))/riscv-binutils/configure \
		--target=$(NEWLIB_TUPLE) \
		$($($@_TARGET)-rgt-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--disable-werror \
		$(BINUTILS_TARGET_FLAGS) \
		--disable-gdb \
		--disable-sim \
		--disable-libdecnumber \
		--disable-libreadline
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install install-pdf install-html &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-gnu-toolchain/build-gdb-newlib/stamp: \
		$(OBJDIR)/%/stamps/expat/install.stamp \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-toolchain/build-gdb-newlib/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-gnu-toolchain/build-gdb-newlib/stamp,%/install/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-gnu-toolchain/build-gdb-newlib/stamp,%/build/riscv-gnu-toolchain,$@))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
# CC_FOR_TARGET is required for the ld testsuite.
	cd $(dir $@) && CC_FOR_TARGET=$(NEWLIB_CC_FOR_TARGET) $(abspath $($@_BUILD))/riscv-gdb/configure \
		--target=$(NEWLIB_TUPLE) \
		$($($@_TARGET)-rgt-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--disable-werror \
		$(GDB_TARGET_FLAGS) \
		--enable-gdb \
		--disable-gas \
		--disable-binutils \
		--disable-ld \
		--disable-gold \
		--disable-gprof
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install install-pdf install-html &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-gnu-toolchain/build-gcc-newlib-stage1/stamp: \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/build-binutils-newlib/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-toolchain/build-gcc-newlib-stage1/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-gnu-toolchain/build-gcc-newlib-stage1/stamp,%/install/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-gnu-toolchain/build-gcc-newlib-stage1/stamp,%/build/riscv-gnu-toolchain,$@))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cd $(dir $@) && $(abspath $($@_BUILD))/riscv-gcc/configure \
		--target=$(NEWLIB_TUPLE) \
		$($($@_TARGET)-rgt-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--disable-shared \
		--disable-threads \
		--disable-tls \
		--enable-languages=c,c++ \
		$(GCC_SYSTEM_ZLIB_FLAGS) \
		--with-newlib \
		--with-sysroot=$(abspath $($@_INSTALL))/$(NEWLIB_TUPLE) \
		--disable-libmudflap \
		--disable-libssp \
		--disable-libquadmath \
		--disable-libgomp \
		--disable-nls \
		--src=../riscv-gcc \
		$(GCC_CHECKING_FLAGS) \
		$(MULTILIB_FLAGS) \
		--with-abi=$(WITH_ABI) \
		--with-arch=$(WITH_ARCH) \
		CFLAGS_FOR_TARGET="-Os $(CFLAGS_FOR_TARGET)" \
		CXXFLAGS_FOR_TARGET="-Os $(CXXFLAGS_FOR_TARGET)"
	$(MAKE) -C $(dir $@) all-gcc &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install-gcc &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-gnu-toolchain/build-newlib/stamp: \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/build-gcc-newlib-stage1/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-toolchain/build-newlib/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-gnu-toolchain/build-newlib/stamp,%/install/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-gnu-toolchain/build-newlib/stamp,%/build/riscv-gnu-toolchain,$@))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cd $(dir $@) && $(abspath $($@_BUILD))/riscv-newlib/configure \
		--target=$(NEWLIB_TUPLE) \
		$($($@_TARGET)-rgt-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-newlib-io-long-double \
		--enable-newlib-io-long-long \
		--enable-newlib-io-c99-formats \
		CFLAGS_FOR_TARGET="-Os $(CFLAGS_FOR_TARGET)" \
		CXXFLAGS_FOR_TARGET="-Os $(CXXFLAGS_FOR_TARGET)"
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
# These install multiple copies of the same docs into the same destination
# for a multilib build.  So we must not parallelize them.
# TODO: Rewrite so that we only install one copy of the docs.
	$(MAKE) -j1 -C $(dir $@) install-pdf install-html &>$(dir $@)/make-install-doc.log
	date > $@

$(OBJDIR)/%/build/riscv-gnu-toolchain/build-newlib-nano/stamp: \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/build-gcc-newlib-stage1/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-toolchain/build-newlib-nano/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-gnu-toolchain/build-newlib-nano/stamp,%/install/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-gnu-toolchain/build-newlib-nano/stamp,%/build/riscv-gnu-toolchain,$@))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cd $(dir $@) && $(abspath $($@_BUILD))/riscv-newlib/configure \
		--target=$(NEWLIB_TUPLE) \
		$($($@_TARGET)-rgt-host) \
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
		--enable-newlib-register-fini \
		CFLAGS_FOR_TARGET="-Os -ffunction-sections -fdata-sections $(CFLAGS_FOR_TARGET)" \
		CXXFLAGS_FOR_TARGET="-Os -ffunction-sections -fdata-sections $(CXXFLAGS_FOR_TARGET)"
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-gnu-toolchain/build-newlib-nano-install/stamp: \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/build-newlib-nano/stamp \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/build-newlib/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-toolchain/build-newlib-nano-install/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-gnu-toolchain/build-newlib-nano-install/stamp,%/install/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-gnu-toolchain/build-newlib-nano-install/stamp,%/build/riscv-gnu-toolchain,$@))
# Copy nano library files into newlib install dir.
	set -e; \
	bnl="$(abspath $($@_BUILD))/build-newlib-nano-install/$(NEWLIB_TUPLE)/lib"; \
	inl="$(abspath $($@_INSTALL))/$(NEWLIB_TUPLE)/lib"; \
	for bnlc in `find $${bnl} -name libc.a`; \
	do \
		inlc=`echo $${bnlc} | $(SED) -e "s:$${bnl}::" | $(SED) -e "s:libc\.a:libc_nano.a:g"`; \
		cp $${bnlc} $${inl}$${inlc}; \
	done; \
	for bnlg in `find $${bnl} -name libg.a`; \
	do \
		inlg=`echo $${bnlg} | $(SED) -e "s:$${bnl}::" | $(SED) -e "s:libg\.a:libg_nano.a:g"`; \
		cp $${bnlg} $${inl}$${inlg}; \
	done; \
	for bnls in `find $${bnl} -name libgloss.a`; \
	do \
		inls=`echo $${bnls} | $(SED) -e "s:$${bnl}::" | $(SED) -e "s:libgloss\.a:libgloss_nano.a:g"`; \
		cp $${bnls} $${inl}$${inls}; \
	done
# Copy nano header files into newlib install dir.
	mkdir -p $(abspath $($@_INSTALL))/$(NEWLIB_TUPLE)/include/newlib-nano; \
	cp $(abspath $($@_BUILD))/build-newlib-nano-install/$(NEWLIB_TUPLE)/include/newlib.h \
		$(abspath $($@_INSTALL))/$(NEWLIB_TUPLE)/include/newlib-nano/newlib.h; \
	date > $@

$(OBJDIR)/%/build/riscv-gnu-toolchain/build-gcc-newlib-stage2/stamp: \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/build-newlib/stamp \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/build-newlib-nano-install/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-toolchain/build-gcc-newlib-stage2/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-gnu-toolchain/build-gcc-newlib-stage2/stamp,%/install/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-gnu-toolchain/build-gcc-newlib-stage2/stamp,%/build/riscv-gnu-toolchain,$@))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cd $(dir $@) && $(abspath $($@_BUILD))/riscv-gcc/configure \
		--target=$(NEWLIB_TUPLE) \
		$($($@_TARGET)-rgt-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--disable-shared \
		--disable-threads \
		--enable-languages=c,c++ \
		$(GCC_SYSTEM_ZLIB_FLAGS) \
		--enable-tls \
		--with-newlib \
		--with-sysroot=$(abspath $($@_INSTALL))/$(NEWLIB_TUPLE) \
		--with-native-system-header-dir=/include \
		--disable-libmudflap \
		--disable-libssp \
		--disable-libquadmath \
		--disable-libgomp \
		--disable-nls \
		--src=../riscv-gcc \
		$(GCC_CHECKING_FLAGS) \
		$(MULTILIB_FLAGS) \
		--with-abi=$(WITH_ABI) \
		--with-arch=$(WITH_ARCH) \
		CFLAGS_FOR_TARGET="-Os $(CFLAGS_FOR_TARGET)" \
		CXXFLAGS_FOR_TARGET="-Os $(CXXFLAGS_FOR_TARGET)"
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install install-pdf install-html &>$(dir $@)/make-install.log
	date > $@

# The Windows build requires the native toolchain.  The dependency is enforced
# here, PATH allows the tools to get access.
$(OBJ_WIN64)/stamps/riscv-gnu-toolchain/install.stamp: \
	$(OBJ_NATIVE)/stamps/riscv-gnu-toolchain/install.stamp

$(OBJ_WIN32)/stamps/riscv-gnu-toolchain/install.stamp: \
	$(OBJ_NATIVE)/stamps/riscv-gnu-toolchain/install.stamp

# OpenOCD requires a GDB that's been build with expat support so it can read
# the target XML files.
$(OBJDIR)/%/stamps/expat/install.stamp: \
		$(OBJDIR)/%/build/expat/configure
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/stamps/expat/install.stamp,%,$@))
	$(eval $@_BUILD := $(patsubst %/stamps/expat/install.stamp,%/build/expat,$@))
	$(eval $@_INSTALL := $(patsubst %/stamps/expat/install.stamp,%/install/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET),$@))
	mkdir -p $($@_BUILD)
	cd $($@_BUILD); ./configure --prefix=$(abspath $($@_INSTALL)) $($($@_TARGET)-expat-configure)
	$(MAKE) -C $($@_BUILD) buildlib
	$(MAKE) -C $($@_BUILD) installlib
	mkdir -p $(dir $@)
	date > $@

$(OBJDIR)/%/build/expat/configure:
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cp -a $(SRC_EXPAT)/* $(dir $@)
	cd $(dir $@); ./buildconf.sh
	touch -c $@

# The OpenOCD builds go here
$(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.zip: \
		$(OBJDIR)/%/stamps/riscv-openocd/install.stamp \
		$(OBJDIR)/%/stamps/riscv-openocd/libs.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/install; zip -r $(abspath $@) riscv-openocd-$(ROCD_VERSION)-$($@_TARGET)

$(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-openocd/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/install -c riscv-openocd-$(ROCD_VERSION)-$($@_TARGET) | gzip > $(abspath $@)

$(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.src.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-openocd/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.src.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/build -c . | gzip > $(abspath $@)

$(OBJDIR)/%/stamps/riscv-openocd/install.stamp: \
		$(OBJDIR)/%/build/riscv-openocd/configure \
		$(OBJDIR)/%/stamps/libftdi/install.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/stamps/riscv-openocd/install.stamp,%,$@))
	$(eval $@_BUILD := $(patsubst %/stamps/riscv-openocd/install.stamp,%/build/riscv-openocd,$@))
	$(eval $@_INSTALL := $(patsubst %/stamps/riscv-openocd/install.stamp,%/install/riscv-openocd-$(ROCD_VERSION)-$($@_TARGET),$@))
	mkdir -p $($@_BUILD)
	cd $($@_BUILD); $($($@_TARGET)-rocd-vars) ./configure --prefix=$(abspath $($@_INSTALL)) --disable-remote-bitbang --disable-werror --enable-ftdi $($($@_TARGET)-rocd-configure)
	$(MAKE) $($($@_TARGET)-rocd-vars) -C $($@_BUILD)
	$(MAKE) $($($@_TARGET)-rocd-vars) -C $($@_BUILD) pdf html
	$(MAKE) $($($@_TARGET)-rocd-vars) -C $($@_BUILD) install install-pdf install-html
	mkdir -p $(dir $@)
	date > $@

$(OBJDIR)/%/build/riscv-openocd/configure:
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cp -a $(SRC_ROCD)/* $(dir $@)
	find $(dir $@) -iname configure.ac | $(SED) s/configure.ac/m4/ | xargs mkdir -p
	cd $(dir $@); ./bootstrap nosubmodule
	touch -c $@

# We might need some extra target libraries for OpenOCD
$(OBJDIR)/%/stamps/riscv-openocd/libs.stamp: \
		$(OBJDIR)/%/stamps/riscv-openocd/install.stamp
	date > $@

$(OBJ_WIN64)/stamps/riscv-openocd/libs.stamp: \
		$(OBJ_WIN64)/stamps/riscv-openocd/install.stamp
	$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | xargs -I {} -d: find {} -iname "libgcc_*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64)/bin
	date > $@

$(OBJ_WIN32)/stamps/riscv-openocd/libs.stamp: \
		$(OBJ_WIN32)/stamps/riscv-openocd/install.stamp
	$(WIN32)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | xargs -I {} -d: find {} -iname "libgcc_*.dll" | xargs cp -t $(OBJDIR)/$(WIN32)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN32)/bin
	date > $@

# Use the host libusb unless we expect there to be none
$(OBJ_WIN64)/stamps/riscv-openocd/install.stamp: \
		$(OBJ_WIN64)/stamps/libusb/install.stamp

$(OBJ_WIN32)/stamps/riscv-openocd/install.stamp: \
		$(OBJ_WIN32)/stamps/libusb/install.stamp

$(OBJ_DARWIN)/stamps/riscv-openocd/install.stamp: \
		$(OBJ_DARWIN)/stamps/libusb/install.stamp

# OpenOCD needs libusb
$(OBJDIR)/%/stamps/libusb/install.stamp: \
		$(OBJDIR)/%/build/libusb/configure
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/stamps/libusb/install.stamp,%,$@))
	$(eval $@_BUILD := $(patsubst %/stamps/libusb/install.stamp,%/build/libusb,$@))
	$(eval $@_INSTALL := $(patsubst %/stamps/libusb/install.stamp,%/install/riscv-openocd-$(ROCD_VERSION)-$($@_TARGET),$@))
	mkdir -p $($@_BUILD)
	cd $($@_BUILD); ./configure --prefix=$(abspath $($@_INSTALL)) --disable-udev $($($@_TARGET)-libusb-configure)
	$(MAKE) -C $($@_BUILD)
	$(MAKE) -C $($@_BUILD) install
	mkdir -p $(dir $@)
	date > $@

$(OBJDIR)/%/build/libusb/configure:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/libusb/configure,%,$@))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cp -a $(SRC_LIBUSB)/* $(dir $@)
	mkdir -p $(dir $@)/m4
	cd $(dir $@); $(LIBTOOLIZE)
	cd $(dir $@); autoreconf -ivf
	touch -c $@

# OpenOCD needs libftdi
$(OBJDIR)/%/stamps/libftdi/install.stamp: \
		$(OBJDIR)/%/build/libftdi/CMakeLists.txt \
		$(OBJDIR)/%/stamps/libusb/install.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/stamps/libftdi/install.stamp,%,$@))
	$(eval $@_BUILD := $(patsubst %/stamps/libftdi/install.stamp,%/build/libftdi,$@))
	$(eval $@_INSTALL := $(patsubst %/stamps/libftdi/install.stamp,%/install/riscv-openocd-$(ROCD_VERSION)-$($@_TARGET),$@))
	mkdir -p $($@_BUILD)
	cd $($@_BUILD); cmake -DCMAKE_INSTALL_PREFIX:PATH=$(abspath $($@_INSTALL)) $($($@_TARGET)-libftdi-configure) .
	$(MAKE) -C $($@_BUILD)
	$(MAKE) -C $($@_BUILD) install
	rm -f $(abspath $($@_INSTALL))/lib/libftdi*.dylib
	rm -f $(abspath $($@_INSTALL))/lib/libftdi*.so.*
	mkdir -p $(dir $@)
	date > $@

$(OBJDIR)/%/build/libftdi/CMakeLists.txt:
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cp -a $(SRC_LIBFTDI)/* $(dir $@)
	touch -c $@

# Targets that don't build anything
.PHONY: clean
clean::
	rm -rf $(OBJDIR) $(BINDIR)
