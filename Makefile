# The default target
.PHONY: all toolchain openocd qemu
all:
toolchain:
openocd:
qemu:

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
toolchain: redhat-gcc
openocd: redhat-openocd
qemu: redhat-qemu
else ifeq ($(DISTRIB_ID),Ubuntu)
ifeq ($(shell uname -m),x86_64)
NATIVE ?= $(UBUNTU64)
all: ubuntu64
toolchain: ubuntu64-gcc
openocd: ubuntu64-openocd
qemu: ubuntu64-qemu
else
NATIVE ?= $(UBUNTU32)
all: ubuntu32
toolchain: ubuntu32-gcc
openocd: ubuntu32-openocd
endif
all: win64
toolchain: win64-gcc
openocd: win64-openocd
qemu: win64-qemu
else ifeq ($(shell uname),Darwin)
NATIVE ?= $(DARWIN)
LIBTOOLIZE ?= glibtoolize
TAR ?= gtar
SED ?= gsed
AWK ?= gawk
all: darwin
toolchain: darwin-gcc
openocd: darwin-openocd
qemu: darwin-qemu
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
SRC_RQEMU    := $(SRCDIR)/riscv-qemu
SRC_EXPAT    := $(SRCDIR)/libexpat/expat
SRC_LIBUSB   := $(SRCDIR)/libusb
SRC_LIBFTDI  := $(SRCDIR)/libftdi

# The version that will be appended to the various tool builds.
RGT_VERSION := 8.2.0-2019.05.3
RGDB_VERSION := 8.3.0-2019.05.3
RGBU_VERSION := 2.32.0-2019.05.3
ROCD_VERSION := 0.10.0-2019.05.3
RQEMU_VERSION := 3.1.0-2019.05.3

# The toolchain build needs the tools in the PATH, and the windows build uses the ubuntu (native)
PATH := $(abspath $(OBJ_NATIVE)/install/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(NATIVE)/bin):$(PATH)
export PATH

# The actual output of this repository is a set of tarballs.
.PHONY: win64 win64-openocd win64-gcc win64-qemu
win64: win64-openocd win64-gcc win64-qemu
win64-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN64).zip
win64-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN64).src.zip
win64-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN64).tar.gz
win64-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN64).src.tar.gz
win64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN64).zip
win64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN64).src.zip
win64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN64).tar.gz
win64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN64).src.tar.gz
win64-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(WIN64).zip
win64-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(WIN64).src.zip
win64-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(WIN64).tar.gz
win64-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(WIN64).src.tar.gz
.PHONY: win32 win32-openocd win32-gcc
win32: win32-openocd win32-gcc
win32-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN32).zip
win32-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN32).src.zip
win32-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN32).tar.gz
win32-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN32).src.tar.gz
win32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN32).zip
win32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN32).src.zip
win32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN32).tar.gz
win32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN32).src.tar.gz
.PHONY: ubuntu64 ubuntu64-gcc ubuntu64-openocd ubuntu64-qemu
ubuntu64: ubuntu64-gcc ubuntu64-openocd ubuntu64-qemu
ubuntu64-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(UBUNTU64).src.tar.gz
ubuntu64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64).src.tar.gz
ubuntu64-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(UBUNTU64).src.tar.gz
.PHONY: ubuntu32 ubuntu32-gcc ubuntu32-openocd
ubuntu32: ubuntu32-gcc ubuntu32-openocd
ubuntu32-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(UBUNTU32).tar.gz
ubuntu32-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(UBUNTU32).src.tar.gz
ubuntu32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU32).tar.gz
ubuntu32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU32).src.tar.gz
.PHONY: redhat redhat-gcc redhat-openocd redhat-qemu
redhat: redhat-gcc redhat-openocd redhat-qemu
redhat-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(REDHAT).tar.gz
redhat-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(REDHAT).src.tar.gz
redhat-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(REDHAT).tar.gz
redhat-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(REDHAT).src.tar.gz
redhat-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT).tar.gz
redhat-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT).src.tar.gz
.PHONY: darwin darwin-gcc darwin-openocd darwin-qemu
darwin: darwin-gcc darwin-openocd darwin-qemu
darwin-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(DARWIN).tar.gz
darwin-gcc: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(DARWIN).src.tar.gz
darwin-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(DARWIN).tar.gz
darwin-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(DARWIN).src.tar.gz
darwin-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN).tar.gz
darwin-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN).src.tar.gz


# Some special riscv-gnu-toolchain configure flags for specific targets.
$(WIN32)-rgt-host            := --host=$(WIN32)
$(WIN32)-rgcc-configure      := --without-system-zlib
$(WIN32)-rocd-vars           := LIBUSB1_CFLAGS="-I$(abspath $(OBJ_WIN32)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN32))/include/libusb-1.0" LIBUSB1_LIBS="-L$(abspath $(OBJ_WIN32)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN32))/lib -lusb-1.0" CFLAGS="-O2"
$(WIN32)-rocd-configure      := --host=$(WIN32)
$(WIN32)-expat-configure     := --host=$(WIN32)
$(WIN32)-libusb-configure    := --host=$(WIN32)
$(WIN32)-libftdi-configure   := -DCMAKE_TOOLCHAIN_FILE="$(abspath $(SRC_LIBFTDI)/cmake/Toolchain-i686-w64-mingw32.cmake)" -DLIBUSB_LIBRARIES="$(abspath $(OBJ_WIN32)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN32)/bin/libusb-1.0.dll)" -DLIBUSB_INCLUDE_DIR="$(abspath $(OBJ_WIN32)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN32)/include/libusb-1.0)"
$(WIN64)-rgt-host            := --host=$(WIN64)
$(WIN64)-rgcc-configure      := --without-system-zlib
$(WIN64)-rocd-vars           := LIBUSB1_CFLAGS="-I$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64))/include/libusb-1.0" LIBUSB1_LIBS="-L$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64))/lib -lusb-1.0" CFLAGS="-O2"
$(WIN64)-rocd-configure      := --host=$(WIN64)
$(WIN64)-rqemu-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include"
$(WIN64)-rqemu-host          := --host=$(WIN64)
$(WIN64)-rqemu-cross         := --cross-prefix=x86_64-w64-mingw32-
$(WIN64)-rqemu-bindir        := /bin
$(WIN64)-expat-configure     := --host=$(WIN64)
$(WIN64)-libusb-configure    := --host=$(WIN64)
$(WIN64)-libftdi-configure   := -DCMAKE_TOOLCHAIN_FILE="$(abspath $(SRC_LIBFTDI)/cmake/Toolchain-x86_64-w64-mingw32.cmake)" -DLIBUSB_LIBRARIES="$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64)/bin/libusb-1.0.dll)" -DLIBUSB_INCLUDE_DIR="$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64)/include/libusb-1.0)"
$(WIN64)-gettext-configure   := --enable-threads=windows
$(WIN64)-glib-vars           := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include"
$(WIN64)-libpng-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include"
$(WIN64)-pixman-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include"
$(UBUNTU32)-rgt-host         := --host=i686-linux-gnu
$(UBUNTU32)-rgcc-configure   := --without-system-zlib
$(UBUNTU32)-rocd-configure   := --host=i686-linux-gnu
$(UBUNTU32)-expat-configure  := --host=i686-linux-gnu
$(UBUNTU32)-libusb-configure := --host=i686-linux-gnu
$(UBUNTU64)-rgt-host         := --host=x86_64-linux-gnu
$(UBUNTU64)-rgcc-configure   := --without-system-zlib
$(UBUNTU64)-rocd-configure   := --host=x86_64-linux-gnu
$(UBUNTU64)-rqemu-host       := --host=x86_64-linux-gnu
$(UBUNTU64)-expat-configure  := --host=x86_64-linux-gnu
$(UBUNTU64)-libusb-configure := --host=x86_64-linux-gnu
$(UBUNTU64)-gettext-configure:= --enable-threads=posix
$(UBUNTU64)-glib-vars        := PKG_CONFIG_PATH="$(abspath $(OBJ_UBUNTU64)/install/riscv-qemu-$(RQEMU_VERSION)-$(UBUNTU64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_UBUNTU64)/install/riscv-qemu-$(RQEMU_VERSION)-$(UBUNTU64))/lib -I$(abspath $(OBJ_UBUNTU64)/install/riscv-qemu-$(RQEMU_VERSION)-$(UBUNTU64))/include"
$(DARWIN)-rgcc-configure     := --with-system-zlib
$(DARWIN)-rocd-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/riscv-openocd-$(ROCD_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-O2" LDFLAGS="-Wl,-framework,IOKit -Wl,-framework,CoreFoundation"
$(DARWIN)-rqemu-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/include" CPPFLAGS="-I$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/include" LDFLAGS="-L$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/lib -liconv -framework CoreFoundation -framework Carbon" PATH=/usr/local/opt/gettext/bin:$(PATH)
$(DARWIN)-expat-configure    := --disable-shared --enable-static
$(DARWIN)-libusb-configure   := --disable-shared --enable-static
$(DARWIN)-libftdi-configure  := -DCMAKE_SHARED_LINKER_FLAGS="-framework corefoundation -framework iokit"
$(DARWIN)-gettext-configure  := --enable-threads=posix
$(DARWIN)-glib-configure     := --enable-static
$(DARWIN)-glib-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/lib -I$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/include" PATH=/usr/local/opt/gettext/bin:$(PATH)
$(REDHAT)-rgcc-configure     := --with-system-zlib
$(REDHAT)-rocd-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/lib/pkgconfig" CFLAGS="-O2" LDFLAGS="-lrt"
$(REDHAT)-rqemu-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/lib/pkgconfig" CFLAGS="-fPIC -I$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/include -Wno-unused-result" CPPFLAGS="-fPIC -I$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/include" LDFLAGS="-L$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/lib -liconv" LIBS="-L$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/lib -liconv" SIFIVE_LIBS_QGA="-L$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/lib -liconv"
$(REDHAT)-zlib-configure     := -static
$(REDHAT)-gettext-configure  := --enable-threads=posix
$(REDHAT)-glib-configure     := --enable-static
$(REDHAT)-glib-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/lib/pkgconfig" CFLAGS="-fPIC -L$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/lib -I$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/include"
$(REDHAT)-libpng-vars        := CFLAGS="-fPIC" CPPFLAGS="-fPIC"
$(REDHAT)-pixman-vars        := CFLAGS="-fPIC" CPPFLAGS="-fPIC"
$(REDHAT)-deps-vars          := CFLAGS="-fPIC"

# Some general riscv-gnu-toolchain flags and list of multilibs for the multilibs generator script
WITH_ABI := lp64d
WITH_ARCH := rv64imafdc
WITH_CMODEL := medany
NEWLIB_TUPLE := riscv64-unknown-elf
MULTILIBS_GEN := rv32e-ilp32e--c rv32em-ilp32e--c rv32eac-ilp32e-- rv32emac-ilp32e-- rv32i-ilp32--c rv32im-ilp32--c rv32imf-ilp32f--c rv32iac-ilp32-- rv32imac-ilp32-- rv32imafc-ilp32f-rv32imafdc- rv32imafdc-ilp32d-- rv64i-lp64--c rv64im-lp64--c rv64imf-lp64f--c rv64iac-lp64-- rv64imac-lp64-- rv64imafc-lp64f-rv64imafdc- rv64imafdc-lp64d--

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
	cd $(OBJDIR)/$($@_TARGET)/install; zip -rq $(abspath $@) riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET)

$(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-%.src.zip: \
		$(OBJDIR)/%/stamps/riscv-gnu-toolchain/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-%.src.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/build; zip -rq $(abspath $@) riscv-gnu-toolchain expat

$(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-%.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-gnu-toolchain/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-%.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/install -c riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET) | gzip > $(abspath $@)

$(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-%.src.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-gnu-toolchain/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-%.src.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/build -c riscv-gnu-toolchain expat | gzip > $(abspath $@)

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
	cd $(dir $@)/riscv-gcc/gcc/config/riscv; rm t-elf-multilib; ./multilib-generator $(MULTILIBS_GEN) > t-elf-multilib
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
		--with-pkgversion="SiFive Binutils $(RGBU_VERSION)" \
		--with-bugurl="https://github.com/sifive/freedom-tools/issues" \
		--disable-werror \
		$(BINUTILS_TARGET_FLAGS) \
		--disable-gdb \
		--disable-sim \
		--disable-libdecnumber \
		--disable-libreadline \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" &>make-configure.log
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
		--with-pkgversion="SiFive GDB $(RGDB_VERSION)" \
		--with-bugurl="https://github.com/sifive/freedom-tools/issues" \
		--disable-werror \
		$(GDB_TARGET_FLAGS) \
		--enable-gdb \
		--disable-gas \
		--disable-binutils \
		--disable-ld \
		--disable-gold \
		--disable-gprof \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" &>make-configure.log
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
		--with-pkgversion="SiFive GCC $(RGT_VERSION)" \
		--with-bugurl="https://github.com/sifive/freedom-tools/issues" \
		--disable-shared \
		--disable-threads \
		--disable-tls \
		--enable-languages=c,c++ \
		--with-newlib \
		--with-sysroot=$(abspath $($@_INSTALL))/$(NEWLIB_TUPLE) \
		--disable-libmudflap \
		--disable-libssp \
		--disable-libquadmath \
		--disable-libgomp \
		--disable-nls \
		--src=../riscv-gcc \
		$($($@_TARGET)-rgcc-configure) \
		--enable-checking=yes \
		--enable-multilib \
		--with-abi=$(WITH_ABI) \
		--with-arch=$(WITH_ARCH) \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" \
		CFLAGS_FOR_TARGET="-Os $(CFLAGS_FOR_TARGET)" \
		CXXFLAGS_FOR_TARGET="-Os $(CXXFLAGS_FOR_TARGET)" &>make-configure.log
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
		CXXFLAGS_FOR_TARGET="-Os $(CXXFLAGS_FOR_TARGET)" &>make-configure.log
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
		CXXFLAGS_FOR_TARGET="-Os -ffunction-sections -fdata-sections $(CXXFLAGS_FOR_TARGET)" &>make-configure.log
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
		--with-pkgversion="SiFive GCC $(RGT_VERSION)" \
		--with-bugurl="https://github.com/sifive/freedom-tools/issues" \
		--disable-shared \
		--disable-threads \
		--enable-languages=c,c++ \
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
		$($($@_TARGET)-rgcc-configure) \
		--enable-checking=yes \
		--enable-multilib \
		--with-abi=$(WITH_ABI) \
		--with-arch=$(WITH_ARCH) \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" \
		CFLAGS_FOR_TARGET="-Os $(CFLAGS_FOR_TARGET)" \
		CXXFLAGS_FOR_TARGET="-Os $(CXXFLAGS_FOR_TARGET)" &>make-configure.log
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
	cd $($@_BUILD); ./configure --prefix=$(abspath $($@_INSTALL)) $($($@_TARGET)-expat-configure) &>make-configure.log
	$(MAKE) -C $($@_BUILD) buildlib &>$($@_BUILD)/make-buildlib.log
	$(MAKE) -C $($@_BUILD) installlib &>$($@_BUILD)/make-installlib.log
	mkdir -p $(dir $@)
	date > $@

$(OBJDIR)/%/build/expat/configure:
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cp -a $(SRC_EXPAT)/* $(dir $@)
	cd $(dir $@); ./buildconf.sh &>make-buildconf.log
	touch -c $@

# The OpenOCD builds go here
$(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.zip: \
		$(OBJDIR)/%/stamps/riscv-openocd/install.stamp \
		$(OBJDIR)/%/stamps/riscv-openocd/libs.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/install; zip -rq $(abspath $@) riscv-openocd-$(ROCD_VERSION)-$($@_TARGET)

$(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.src.zip: \
		$(OBJDIR)/%/stamps/riscv-openocd/install.stamp \
		$(OBJDIR)/%/stamps/riscv-openocd/libs.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.src.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/build; zip -rq $(abspath $@) riscv-openocd libftdi libusb

$(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-openocd/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/install -c riscv-openocd-$(ROCD_VERSION)-$($@_TARGET) | gzip > $(abspath $@)

$(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.src.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-openocd/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.src.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/build -c riscv-openocd libftdi libusb | gzip > $(abspath $@)

$(OBJDIR)/%/stamps/riscv-openocd/install.stamp: \
		$(OBJDIR)/%/build/riscv-openocd/configure \
		$(OBJDIR)/%/stamps/libftdi/install.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/stamps/riscv-openocd/install.stamp,%,$@))
	$(eval $@_BUILD := $(patsubst %/stamps/riscv-openocd/install.stamp,%/build/riscv-openocd,$@))
	$(eval $@_INSTALL := $(patsubst %/stamps/riscv-openocd/install.stamp,%/install/riscv-openocd-$(ROCD_VERSION)-$($@_TARGET),$@))
	mkdir -p $($@_BUILD)
	cd $($@_BUILD); $($($@_TARGET)-rocd-vars) ./configure --prefix=$(abspath $($@_INSTALL)) --disable-remote-bitbang --disable-werror --enable-ftdi $($($@_TARGET)-rocd-configure) &>make-configure.log
	$(MAKE) $($($@_TARGET)-rocd-vars) -C $($@_BUILD) &>$($@_BUILD)/make-build.log
	$(MAKE) $($($@_TARGET)-rocd-vars) -C $($@_BUILD) pdf html &>$($@_BUILD)/make-build-doc.log
	$(MAKE) $($($@_TARGET)-rocd-vars) -C $($@_BUILD) install install-pdf install-html &>$($@_BUILD)/make-install.log
	mkdir -p $(dir $@)
	date > $@

$(OBJDIR)/%/build/riscv-openocd/configure:
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cp -a $(SRC_ROCD)/* $(dir $@)
	$(SED) -i -f scripts/openocd.sed -e "s/SIFIVE_PACKAGE_VERSION/SiFive OpenOCD $(ROCD_VERSION)/" $(dir $@)/src/openocd.c
	find $(dir $@) -iname configure.ac | $(SED) s/configure.ac/m4/ | xargs mkdir -p
	cd $(dir $@); ./bootstrap nosubmodule &>make-bootstrap.log
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
	cd $($@_BUILD); ./configure --prefix=$(abspath $($@_INSTALL)) --disable-udev $($($@_TARGET)-libusb-configure) &>make-configure.log
	$(MAKE) -C $($@_BUILD) &>$($@_BUILD)/make-build.log
	$(MAKE) -C $($@_BUILD) install &>$($@_BUILD)/make-install.log
	mkdir -p $(dir $@)
	date > $@

$(OBJDIR)/%/build/libusb/configure:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/libusb/configure,%,$@))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cp -a $(SRC_LIBUSB)/* $(dir $@)
	mkdir -p $(dir $@)/m4
	cd $(dir $@); $(LIBTOOLIZE) &>make-libtoolize.log
	cd $(dir $@); autoreconf -ivf &>make-autoreconf.log
	touch -c $@

# OpenOCD needs libftdi
$(OBJDIR)/%/stamps/libftdi/install.stamp: \
		$(OBJDIR)/%/build/libftdi/CMakeLists.txt \
		$(OBJDIR)/%/stamps/libusb/install.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/stamps/libftdi/install.stamp,%,$@))
	$(eval $@_BUILD := $(patsubst %/stamps/libftdi/install.stamp,%/build/libftdi,$@))
	$(eval $@_INSTALL := $(patsubst %/stamps/libftdi/install.stamp,%/install/riscv-openocd-$(ROCD_VERSION)-$($@_TARGET),$@))
	mkdir -p $($@_BUILD)
	cd $($@_BUILD); cmake -DCMAKE_INSTALL_PREFIX:PATH=$(abspath $($@_INSTALL)) $($($@_TARGET)-libftdi-configure) . &>make-cmake.log
	$(MAKE) -C $($@_BUILD) &>$($@_BUILD)/make-build.log
	$(MAKE) -C $($@_BUILD) install &>$($@_BUILD)/make-install.log
	rm -f $(abspath $($@_INSTALL))/lib/libftdi*.dylib
	rm -f $(abspath $($@_INSTALL))/lib/libftdi*.so*
	rm -f $(abspath $($@_INSTALL))/lib64/libftdi*.so*
	mkdir -p $(dir $@)
	date > $@

$(OBJDIR)/%/build/libftdi/CMakeLists.txt:
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cp -a $(SRC_LIBFTDI)/* $(dir $@)
	touch -c $@

# The QEMU builds go here
$(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-%.zip: \
		$(OBJDIR)/%/stamps/riscv-qemu/install.stamp \
		$(OBJDIR)/%/stamps/riscv-qemu/libs.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-%.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/install; zip -rq $(abspath $@) riscv-qemu-$(RQEMU_VERSION)-$($@_TARGET)

$(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-%.src.zip: \
		$(OBJDIR)/%/stamps/riscv-qemu/install.stamp \
		$(OBJDIR)/%/stamps/riscv-qemu/libs.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-%.src.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/build; zip -rq $(abspath $@) riscv-qemu

$(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-%.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-qemu/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-%.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/install -c riscv-qemu-$(RQEMU_VERSION)-$($@_TARGET) | gzip > $(abspath $@)

$(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-%.src.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-qemu/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-%.src.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/build -c riscv-qemu | gzip > $(abspath $@)

$(OBJDIR)/%/stamps/riscv-qemu/install.stamp: \
		$(OBJDIR)/%/build/riscv-qemu/riscv-qemu/stamp
	mkdir -p $(dir $@)
	date > $@

# We might need some extra target libraries for QEMU
$(OBJ_NATIVE)/stamps/riscv-qemu/libs.stamp: \
		$(OBJ_NATIVE)/stamps/riscv-qemu/install.stamp
	date > $@

$(OBJ_WIN64)/stamps/riscv-qemu/libs.stamp: \
		$(OBJ_WIN64)/stamps/riscv-qemu/install.stamp
	$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libgcc_s_seh*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64)/bin
	$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libssp*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64)/bin
	$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libwinpthread*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64)/bin
	date > $@

$(OBJ_WIN32)/stamps/riscv-qemu/libs.stamp: \
		$(OBJ_WIN32)/stamps/riscv-qemu/install.stamp
	$(WIN32)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libgcc_s_seh*.dll" | xargs cp -t $(OBJDIR)/$(WIN32)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN32)/bin
	$(WIN32)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libssp*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN32)/bin
	$(WIN32)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libwinpthread*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN32)/bin
	date > $@

$(OBJDIR)/%/build/riscv-qemu/stamp:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-qemu/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-qemu/stamp,%/install/riscv-qemu-$(RQEMU_VERSION)-$($@_TARGET),$@))
	rm -rf $($@_INSTALL)
	mkdir -p $($@_INSTALL)
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cd $(dir $@); curl -L -f -s -o zlib-1.2.11.tar.gz http://zlib.net/fossils/zlib-1.2.11.tar.gz
	cd $(dir $@); $(TAR) -xf zlib-1.2.11.tar.gz
	cd $(dir $@); mv zlib-1.2.11 zlib
	cd $(dir $@); curl -L -f -s -o libffi-3.2.1.tar.gz ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz
	cd $(dir $@); $(TAR) -xf libffi-3.2.1.tar.gz
	cd $(dir $@); mv libffi-3.2.1 libffi
	cd $(dir $@); curl -L -f -s -o libiconv-1.15.tar.gz https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz
	cd $(dir $@); $(TAR) -xf libiconv-1.15.tar.gz
	cd $(dir $@); mv libiconv-1.15 libiconv
	cd $(dir $@); curl -L -f -s -o gettext-0.19.8.1.tar.gz https://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.8.1.tar.gz
	cd $(dir $@); $(TAR) -xf gettext-0.19.8.1.tar.gz
	cd $(dir $@); mv gettext-0.19.8.1 gettext
	cd $(dir $@); curl -L -f -s -o glib-2.56.4.tar.xz http://ftp.acc.umu.se/pub/GNOME/sources/glib/2.56/glib-2.56.4.tar.xz
	cd $(dir $@); $(TAR) -xf glib-2.56.4.tar.xz
	cd $(dir $@); mv glib-2.56.4 glib
	cd $(dir $@); curl -L -f -s -o libpng-1.6.36.tar.gz https://sourceforge.net/projects/libpng/files/libpng16/1.6.36/libpng-1.6.36.tar.gz
	cd $(dir $@); $(TAR) -xf libpng-1.6.36.tar.gz
	cd $(dir $@); mv libpng-1.6.36 libpng
	cd $(dir $@); curl -L -f -s -o jpegsrc.v9b.tar.gz http://www.ijg.org/files/jpegsrc.v9b.tar.gz
	cd $(dir $@); $(TAR) -xf jpegsrc.v9b.tar.gz
	cd $(dir $@); mv jpeg-9b jpeg
	cd $(dir $@); curl -L -f -s -o pixman-0.38.0.tar.gz https://cairographics.org/releases/pixman-0.38.0.tar.gz
	cd $(dir $@); $(TAR) -xf pixman-0.38.0.tar.gz
	cd $(dir $@); mv pixman-0.38.0 pixman
	cp -a $(SRC_RQEMU) $(dir $@)
	$(SED) -i -f scripts/qemu-configure.sed $(dir $@)/riscv-qemu/configure
	$(SED) -i -f scripts/qemu-common.sed $(dir $@)/riscv-qemu/include/qemu-common.h
	$(SED) -i -f scripts/qemu-vl.sed $(dir $@)/riscv-qemu/vl.c
	date > $@

$(OBJ_NATIVE)/build/riscv-qemu/zlib/stamp: \
		$(OBJ_NATIVE)/build/riscv-qemu/stamp
	cd $(dir $@) && $($(NATIVE)-deps-vars) ./configure \
		--prefix=$(abspath $(OBJ_NATIVE)/install/riscv-qemu-$(RQEMU_VERSION)-$(NATIVE)) \
		$($(NATIVE)-zlib-configure) &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJ_WIN64)/build/riscv-qemu/zlib/stamp: \
		$(OBJ_WIN64)/build/riscv-qemu/stamp
	$(MAKE) -C $(dir $@) -f win32/Makefile.gcc PREFIX=$(WIN64)- prefix=$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/ &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) -f win32/Makefile.gcc SHARED_MODE=1 install DESTDIR=$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/ INCLUDE_PATH=include LIBRARY_PATH=lib BINARY_PATH=bin &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-qemu/libffi/stamp: \
		$(OBJDIR)/%/build/riscv-qemu/zlib/stamp \
		$(OBJDIR)/%/build/riscv-qemu/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-qemu/libffi/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-qemu/libffi/stamp,%/install/riscv-qemu-$(RQEMU_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-qemu/libffi/stamp,%/build/riscv-qemu,$@))
	cd $(dir $@) && $($($@_TARGET)-deps-vars) ./configure \
		$($($@_TARGET)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-qemu/libiconv/stamp: \
		$(OBJDIR)/%/build/riscv-qemu/libffi/stamp \
		$(OBJDIR)/%/build/riscv-qemu/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-qemu/libiconv/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-qemu/libiconv/stamp,%/install/riscv-qemu-$(RQEMU_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-qemu/libiconv/stamp,%/build/riscv-qemu,$@))
	cd $(dir $@) && $($($@_TARGET)-deps-vars) ./configure \
		$($($@_TARGET)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-qemu/gettext/stamp: \
		$(OBJDIR)/%/build/riscv-qemu/libiconv/stamp \
		$(OBJDIR)/%/build/riscv-qemu/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-qemu/gettext/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-qemu/gettext/stamp,%/install/riscv-qemu-$(RQEMU_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-qemu/gettext/stamp,%/build/riscv-qemu,$@))
	cd $(dir $@) && $($($@_TARGET)-deps-vars) ./configure \
		$($($@_TARGET)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--disable-installed-tests \
		--disable-always-build-tests \
		--disable-rpath \
		--disable-java \
		--disable-native-java \
		--disable-c++ \
		--enable-static \
		$($($@_TARGET)-gettext-configure) &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-qemu/glib/stamp: \
		$(OBJDIR)/%/build/riscv-qemu/gettext/stamp \
		$(OBJDIR)/%/build/riscv-qemu/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-qemu/glib/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-qemu/glib/stamp,%/install/riscv-qemu-$(RQEMU_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-qemu/glib/stamp,%/build/riscv-qemu,$@))
	mkdir -p $(dir $@)/gio/lib
	cd $(dir $@) && $($($@_TARGET)-glib-vars) ./configure \
		$($($@_TARGET)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		$($($@_TARGET)-glib-configure) \
		--with-libiconv=gnu \
		--without-pcre \
		--disable-selinux \
		--disable-fam \
		--disable-xattr \
		--disable-libelf \
		--disable-libmount \
		--disable-dtrace \
		--disable-systemtap \
		--disable-coverage \
		--disable-Bsymbolic \
		--disable-znodelete \
		--disable-compile-warnings \
		--disable-installed-tests \
		--disable-always-build-tests &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-qemu/libpng/stamp: \
		$(OBJDIR)/%/build/riscv-qemu/libffi/stamp \
		$(OBJDIR)/%/build/riscv-qemu/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-qemu/libpng/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-qemu/libpng/stamp,%/install/riscv-qemu-$(RQEMU_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-qemu/libpng/stamp,%/build/riscv-qemu,$@))
	cd $(dir $@) && $($($@_TARGET)-libpng-vars) ./configure \
		$($($@_TARGET)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-qemu/jpeg/stamp: \
		$(OBJDIR)/%/build/riscv-qemu/libpng/stamp \
		$(OBJDIR)/%/build/riscv-qemu/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-qemu/jpeg/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-qemu/jpeg/stamp,%/install/riscv-qemu-$(RQEMU_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-qemu/jpeg/stamp,%/build/riscv-qemu,$@))
	cd $(dir $@) && $($($@_TARGET)-deps-vars) ./configure \
		$($($@_TARGET)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-qemu/pixman/stamp: \
		$(OBJDIR)/%/build/riscv-qemu/jpeg/stamp \
		$(OBJDIR)/%/build/riscv-qemu/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-qemu/pixman/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-qemu/pixman/stamp,%/install/riscv-qemu-$(RQEMU_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-qemu/pixman/stamp,%/build/riscv-qemu,$@))
	mkdir -p $(dir $@)/test/lib
	cd $(dir $@) && $($($@_TARGET)-pixman-vars) ./configure \
		$($($@_TARGET)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static \
		--with-gnu-ld \
		--disable-static-testprogs &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-qemu/riscv-qemu/stamp: \
		$(OBJDIR)/%/build/riscv-qemu/glib/stamp \
		$(OBJDIR)/%/build/riscv-qemu/pixman/stamp \
		$(OBJDIR)/%/build/riscv-qemu/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-qemu/riscv-qemu/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-qemu/riscv-qemu/stamp,%/install/riscv-qemu-$(RQEMU_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-qemu/riscv-qemu/stamp,%/build/riscv-qemu,$@))
	rm -f $(abspath $($@_INSTALL))/lib/lib*.dylib
	rm -f $(abspath $($@_INSTALL))/lib/lib*.so*
	rm -f $(abspath $($@_INSTALL))/lib64/lib*.so*
	cd $(dir $@) && $($($@_TARGET)-rqemu-vars) ./configure \
		$($($@_TARGET)-rqemu-cross) \
		--prefix=$(abspath $($@_INSTALL))$($($@_TARGET)-rqemu-bindir) \
		--with-pkgversion="SiFive QEMU $(RQEMU_VERSION)" \
		--target-list=riscv32-softmmu,riscv64-softmmu \
		--interp-prefix=$(abspath $($@_INSTALL))/sysroot \
		--disable-libusb &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

# Targets that don't build anything
.PHONY: clean
clean::
	rm -rf $(OBJDIR) $(BINDIR)
