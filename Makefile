# The default target
.PHONY: all non-toolchain toolchain gdb-only openocd qemu xc3sprog trace-decoder sdk-utilities python combo-package
all:
non-toolchain:
toolchain:
gdb-only:
openocd:
qemu:
xc3sprog:
trace-decoder:
sdk-utilities:
python:
combo-package:

.NOTPARALLEL:
export MAKEFLAGS=-j1

# Make uses /bin/sh by default, ignoring the user's value of SHELL.
# Some systems now ship with /bin/sh pointing at dash, and this Makefile
# requires bash
SHELL = /bin/bash

PREFIXPATH ?=
BINDIR := bin
OBJDIR := obj
SRCDIR := $(PREFIXPATH)src
SCRIPTSDIR := $(PREFIXPATH)scripts

UBUNTU32 ?= i686-linux-ubuntu14
UBUNTU64 ?= x86_64-linux-ubuntu14
REDHAT ?= x86_64-linux-centos6
WIN32  ?= i686-w64-mingw32
WIN64  ?= x86_64-w64-mingw32
DARWIN ?= x86_64-apple-darwin


-include /etc/lsb-release
ifneq ($(wildcard /etc/redhat-release),)
NATIVE ?= $(REDHAT)
NINJA ?= ninja-build
all: redhat
non-toolchain: redhat-non-toolchain
toolchain: redhat-toolchain
gdb-only: redhat-gdb-only
openocd: redhat-openocd
qemu: redhat-qemu
xc3sprog: redhat-xc3sprog
trace-decoder: redhat-trace-decoder
sdk-utilities: redhat-sdk-utilities
python: redhat-python
combo-package: redhat-combo-package
else ifeq ($(DISTRIB_ID),Ubuntu)
ifeq ($(shell uname -m),x86_64)
NATIVE ?= $(UBUNTU64)
all: ubuntu64
non-toolchain: ubuntu64-non-toolchain
toolchain: ubuntu64-toolchain
gdb-only: ubuntu64-gdb-only
openocd: ubuntu64-openocd
qemu: ubuntu64-qemu
xc3sprog: ubuntu64-xc3sprog
trace-decoder: ubuntu64-trace-decoder
sdk-utilities: ubuntu64-sdk-utilities
python: ubuntu64-python
combo-package: ubuntu64-combo-package
else
NATIVE ?= $(UBUNTU32)
all: ubuntu32
toolchain: ubuntu32-toolchain
openocd: ubuntu32-openocd
endif
all: win64
non-toolchain: win64-non-toolchain
toolchain: win64-toolchain
gdb-only: win64-gdb-only
openocd: win64-openocd
qemu: win64-qemu
xc3sprog: win64-xc3sprog
trace-decoder: win64-trace-decoder
sdk-utilities: win64-sdk-utilities
python: win64-python
combo-package: win64-combo-package
else ifeq ($(shell uname),Darwin)
NATIVE ?= $(DARWIN)
LIBTOOLIZE ?= glibtoolize
TAR ?= gtar
SED ?= gsed
AWK ?= gawk
all: darwin
non-toolchain: darwin-non-toolchain
toolchain: darwin-toolchain
gdb-only: darwin-gdb-only
openocd: darwin-openocd
qemu: darwin-qemu
xc3sprog: darwin-xc3sprog
trace-decoder: darwin-trace-decoder
sdk-utilities: darwin-sdk-utilities
python: darwin-python
combo-package: darwin-combo-package
else
$(error Unknown host)
endif

LIBTOOLIZE ?= libtoolize
TAR ?= tar
SED ?= sed
AWK ?= awk
NINJA ?= ninja

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
SRC_RIS      := $(SRCDIR)/riscv-isa-sim
SRC_ROCD     := $(SRCDIR)/riscv-openocd
SRC_RQEMU    := $(SRCDIR)/riscv-qemu
SRC_XC3SP    := $(SRCDIR)/xc3sprog
SRC_TDC      := $(SRCDIR)/trace-decoder
SRC_DTC      := $(SRCDIR)/dtc
SRC_FE2H     := $(SRCDIR)/freedom-elf2hex
SRC_EXPAT    := $(SRCDIR)/libexpat/expat
SRC_LIBUSB   := $(SRCDIR)/libusb
SRC_LIBFTDI  := $(SRCDIR)/libftdi
SRC_PICOLIBC := $(SRCDIR)/picolibc

# The version that will be appended to the various tool builds.
RGT_VERSION ?= 9.2.0-2019.11.0-preview6
RGDB_VERSION ?= 8.3.0-2019.11.0-preview4
RGBU_VERSION ?= 2.32.0-2019.11.0-preview4
ROCD_VERSION ?= 0.10.0-2019.08.2
RQEMU_VERSION ?= 4.1.0-2019.08.0
XC3SP_VERSION ?= 0.1.2-2019.08.0
TDC_VERSION ?= 0.0.1-2019.11.0-preview1
SDKU_VERSION ?= 0.0.0-2019.11.0-dasm1
PY_VERSION ?= 2.7.0-2019.11.0-preview1
FT_VERSION ?= 2019.11.0-preview4

# The toolchain build needs the tools in the PATH, and the windows build uses the ubuntu (native)
PATH := $(abspath $(OBJ_NATIVE)/install/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(NATIVE)/bin):$(PATH)
export PATH

# The actual output of this repository is a set of tarballs.
.PHONY: win64 win64-non-toolchain win64-toolchain win64-gdb-only win64-openocd win64-qemu win64-xc3sprog win64-trace-decoder win64-sdk-utilities win64-python win64-combo-package
win64: win64-toolchain win64-openocd win64-qemu win64-xc3sprog win64-trace-decoder win64-sdk-utilities win64-python win64-combo-package
win64-non-toolchain: win64-openocd win64-qemu win64-xc3sprog win64-trace-decoder win64-sdk-utilities win64-python
win64-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN64).zip
win64-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN64).src.zip
win64-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN64).tar.gz
win64-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN64).src.tar.gz
win64-gdb-only: $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$(WIN64).zip
win64-gdb-only: $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$(WIN64).src.zip
win64-gdb-only: $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$(WIN64).tar.gz
win64-gdb-only: $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$(WIN64).src.tar.gz
win64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN64).zip
win64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN64).src.zip
win64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN64).tar.gz
win64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN64).src.tar.gz
win64-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(WIN64).zip
win64-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(WIN64).src.zip
win64-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(WIN64).tar.gz
win64-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(WIN64).src.tar.gz
win64-xc3sprog: $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-$(WIN64).zip
win64-xc3sprog: $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-$(WIN64).src.zip
win64-xc3sprog: $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-$(WIN64).tar.gz
win64-xc3sprog: $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-$(WIN64).src.tar.gz
win64-trace-decoder: $(BINDIR)/trace-decoder-$(TDC_VERSION)-$(WIN64).zip
win64-trace-decoder: $(BINDIR)/trace-decoder-$(TDC_VERSION)-$(WIN64).src.zip
win64-trace-decoder: $(BINDIR)/trace-decoder-$(TDC_VERSION)-$(WIN64).tar.gz
win64-trace-decoder: $(BINDIR)/trace-decoder-$(TDC_VERSION)-$(WIN64).src.tar.gz
win64-sdk-utilities: $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-$(WIN64).zip
win64-sdk-utilities: $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-$(WIN64).src.zip
win64-sdk-utilities: $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-$(WIN64).tar.gz
win64-sdk-utilities: $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-$(WIN64).src.tar.gz
win64-python: $(BINDIR)/python-$(PY_VERSION)-$(WIN64).zip
win64-python: $(BINDIR)/python-$(PY_VERSION)-$(WIN64).tar.gz
win64-combo-package: $(BINDIR)/freedom-tools-$(FT_VERSION)-$(WIN64).zip
win64-combo-package: $(BINDIR)/freedom-tools-$(FT_VERSION)-$(WIN64).tar.gz
.PHONY: win32 win32-openocd win32-toolchain
win32: win32-openocd win32-toolchain
win32-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN32).zip
win32-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN32).src.zip
win32-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN32).tar.gz
win32-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(WIN32).src.tar.gz
win32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN32).zip
win32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN32).src.zip
win32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN32).tar.gz
win32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(WIN32).src.tar.gz
.PHONY: ubuntu64 ubuntu64-non-toolchain ubuntu64-toolchain ubuntu64-gdb-only ubuntu64-openocd ubuntu64-qemu ubuntu64-xc3sprog ubuntu64-trace-decoder ubuntu64-sdk-utilities ubuntu64-python ubuntu64-combo-package
ubuntu64: ubuntu64-toolchain ubuntu64-openocd ubuntu64-qemu ubuntu64-xc3sprog ubuntu64-trace-decoder ubuntu64-sdk-utilities ubuntu64-python ubuntu64-combo-package
ubuntu64-non-toolchain: ubuntu64-openocd ubuntu64-qemu ubuntu64-xc3sprog ubuntu64-trace-decoder ubuntu64-sdk-utilities ubuntu64-python
ubuntu64-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(UBUNTU64).src.tar.gz
ubuntu64-gdb-only: $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-gdb-only: $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$(UBUNTU64).src.tar.gz
ubuntu64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64).src.tar.gz
ubuntu64-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(UBUNTU64).src.tar.gz
ubuntu64-xc3sprog: $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-xc3sprog: $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-$(UBUNTU64).src.tar.gz
ubuntu64-trace-decoder: $(BINDIR)/trace-decoder-$(TDC_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-trace-decoder: $(BINDIR)/trace-decoder-$(TDC_VERSION)-$(UBUNTU64).src.tar.gz
ubuntu64-sdk-utilities: $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-sdk-utilities: $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-$(UBUNTU64).src.tar.gz
ubuntu64-python: $(BINDIR)/python-$(PY_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-combo-package: $(BINDIR)/freedom-tools-$(FT_VERSION)-$(UBUNTU64).tar.gz
.PHONY: ubuntu32 ubuntu32-toolchain ubuntu32-openocd
ubuntu32: ubuntu32-toolchain ubuntu32-openocd
ubuntu32-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(UBUNTU32).tar.gz
ubuntu32-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(UBUNTU32).src.tar.gz
ubuntu32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU32).tar.gz
ubuntu32-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU32).src.tar.gz
.PHONY: redhat redhat-non-toolchain redhat-toolchain redhat-gdb-only redhat-openocd redhat-qemu redhat-xc3sprog redhat-trace-decoder redhat-sdk-utilities redhat-python redhat-combo-package
redhat: redhat-toolchain redhat-openocd redhat-qemu redhat-xc3sprog redhat-trace-decoder redhat-sdk-utilities redhat-python redhat-combo-package
redhat-non-toolchain: redhat-openocd redhat-qemu redhat-xc3sprog redhat-trace-decoder redhat-sdk-utilities redhat-python
redhat-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(REDHAT).tar.gz
redhat-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(REDHAT).src.tar.gz
redhat-gdb-only: $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$(REDHAT).tar.gz
redhat-gdb-only: $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$(REDHAT).src.tar.gz
redhat-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(REDHAT).tar.gz
redhat-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(REDHAT).src.tar.gz
redhat-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT).tar.gz
redhat-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT).src.tar.gz
redhat-xc3sprog: $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-$(REDHAT).tar.gz
redhat-xc3sprog: $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-$(REDHAT).src.tar.gz
redhat-trace-decoder: $(BINDIR)/trace-decoder-$(TDC_VERSION)-$(REDHAT).tar.gz
redhat-trace-decoder: $(BINDIR)/trace-decoder-$(TDC_VERSION)-$(REDHAT).src.tar.gz
redhat-sdk-utilities: $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-$(REDHAT).tar.gz
redhat-sdk-utilities: $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-$(REDHAT).src.tar.gz
redhat-python: $(BINDIR)/python-$(PY_VERSION)-$(REDHAT).tar.gz
redhat-combo-package: $(BINDIR)/freedom-tools-$(FT_VERSION)-$(REDHAT).tar.gz
.PHONY: darwin darwin-non-toolchain darwin-toolchain darwin-gdb-only darwin-openocd darwin-qemu darwin-xc3sprog darwin-trace-decoder darwin-sdk-utilities darwin-python darwin-combo-package
darwin: darwin-toolchain darwin-openocd darwin-qemu darwin-xc3sprog darwin-trace-decoder darwin-sdk-utilities darwin-python darwin-combo-package
darwin-non-toolchain: darwin-openocd darwin-qemu darwin-xc3sprog darwin-trace-decoder darwin-sdk-utilities darwin-python
darwin-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(DARWIN).tar.gz
darwin-toolchain: $(BINDIR)/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$(DARWIN).src.tar.gz
darwin-gdb-only: $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$(DARWIN).tar.gz
darwin-gdb-only: $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$(DARWIN).src.tar.gz
darwin-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(DARWIN).tar.gz
darwin-openocd: $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-$(DARWIN).src.tar.gz
darwin-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN).tar.gz
darwin-qemu: $(BINDIR)/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN).src.tar.gz
darwin-xc3sprog: $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-$(DARWIN).tar.gz
darwin-xc3sprog: $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-$(DARWIN).src.tar.gz
darwin-trace-decoder: $(BINDIR)/trace-decoder-$(TDC_VERSION)-$(DARWIN).tar.gz
darwin-trace-decoder: $(BINDIR)/trace-decoder-$(TDC_VERSION)-$(DARWIN).src.tar.gz
darwin-sdk-utilities: $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-$(DARWIN).tar.gz
darwin-sdk-utilities: $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-$(DARWIN).src.tar.gz
darwin-python: $(BINDIR)/python-$(PY_VERSION)-$(DARWIN).tar.gz
darwin-combo-package: $(BINDIR)/freedom-tools-$(FT_VERSION)-$(DARWIN).tar.gz


# Some special riscv-gnu-toolchain configure flags for specific targets.
$(WIN32)-rgt-host            := --host=$(WIN32)
$(WIN32)-rgcc-configure      := --without-system-zlib
$(WIN32)-expat-configure     := --host=$(WIN32)
$(WIN32)-xc3sp-host          := --host=$(WIN32)
$(WIN64)-rgt-host            := --host=$(WIN64)
$(WIN64)-rgcc-configure      := --without-system-zlib
$(WIN64)-rgdb-configure      := --with-python="$(abspath $(SCRIPTSDIR)/pyconfig-mingw32.sh)"
$(WIN64)-rocd-host           := --host=$(WIN64)
$(WIN64)-oftdi-configure     := -DCMAKE_TOOLCHAIN_FILE="$(abspath $(OBJ_WIN64)/build/riscv-openocd/libftdi/cmake/Toolchain-x86_64-w64-mingw32.cmake)" -DLIBUSB_LIBRARIES="$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64)/bin/libusb-1.0.dll)" -DLIBUSB_INCLUDE_DIR="$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64)/include/libusb-1.0)"
$(WIN64)-odeps-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64))/include"
$(WIN64)-rocd-vars           := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-openocd-$(ROCD_VERSION)-$(WIN64))/include"
$(WIN64)-rqemu-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include"
$(WIN64)-rqemu-host          := --host=$(WIN64)
$(WIN64)-rqemu-cross         := --cross-prefix=x86_64-w64-mingw32-
$(WIN64)-rqemu-bindir        := /bin
$(WIN64)-expat-configure     := --host=$(WIN64)
$(WIN64)-gettext-configure   := --enable-threads=windows
$(WIN64)-glib-vars           := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include"
$(WIN64)-libpng-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include"
$(WIN64)-pixman-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/riscv-qemu-$(RQEMU_VERSION)-$(WIN64))/include"
$(WIN64)-xc3sp-host          := --host=$(WIN64)
$(WIN64)-xftdi-configure     := -DCMAKE_TOOLCHAIN_FILE="$(abspath $(OBJ_WIN64)/build/xc3sprog/libftdi/cmake/Toolchain-x86_64-w64-mingw32.cmake)" -DLIBUSB_LIBRARIES="$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64)/bin/libusb-1.0.dll)" -DLIBUSB_INCLUDE_DIR="$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64)/include/libusb-1.0)"
$(WIN64)-xdeps-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64))/include"
$(WIN64)-xc3sp-configure     := -DCMAKE_TOOLCHAIN_FILE="$(abspath $(OBJ_WIN64)/build/xc3sprog/xc3sprog/Toolchain-mingw32.cmake)" -DLIBUSB_LIBRARIES="$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64)/bin/libusb-1.0.dll)" -DLIBUSB_INCLUDE_DIR="$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64)/include/libusb-1.0)"
$(WIN64)-xc3sp-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64))/include"
$(WIN64)-tdc-cross           := x86_64-w64-mingw32-
$(WIN64)-tdc-binext          := .exe
$(WIN64)-dtc-configure       := CROSSPREFIX=x86_64-w64-mingw32- BINEXT=.exe CC=gcc
$(WIN64)-fe2h-configure      := HOST_PREFIX=x86_64-w64-mingw32- EXEC_SUFFIX=.exe
$(WIN64)-sdasm-configure     := HOST_PREFIX=x86_64-w64-mingw32- EXEC_SUFFIX=.exe
$(WIN64)-pyobj-tarball       := python-2.7.15-x86_64-w64-mingw32.tar.gz
$(UBUNTU32)-rgt-host         := --host=i686-linux-gnu
$(UBUNTU32)-rgcc-configure   := --with-system-zlib
$(UBUNTU32)-expat-configure  := --host=i686-linux-gnu
$(UBUNTU32)-xc3sp-host       := --host=x86_64-linux-gnu
$(UBUNTU64)-rgt-host         := --host=x86_64-linux-gnu
$(UBUNTU64)-rgcc-configure   := --with-system-zlib
$(UBUNTU64)-rgdb-configure   := --with-python=python2.7
$(UBUNTU64)-ousb-configure   := --disable-shared
$(UBUNTU64)-rocd-host        := --host=x86_64-linux-gnu
$(UBUNTU64)-odeps-vars       := PKG_CONFIG_PATH="$(abspath $(OBJ_UBUNTU64)/install/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_UBUNTU64)/install/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64))/include -fPIC" LDFLAGS="-L$(abspath $(OBJ_UBUNTU64)/install/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64))/lib -pthread"
$(UBUNTU64)-rocd-vars        := PKG_CONFIG_PATH="$(abspath $(OBJ_UBUNTU64)/install/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_UBUNTU64)/install/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64))/include" CPPFLAGS="-I$(abspath $(OBJ_UBUNTU64)/install/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64))/include" LIBUSB_INCLUDE_DIRS="$(abspath $(OBJ_UBUNTU64)/install/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64))/include" LDFLAGS="-L$(abspath $(OBJ_UBUNTU64)/install/riscv-openocd-$(ROCD_VERSION)-$(UBUNTU64))/lib"
$(UBUNTU64)-rqemu-host       := --host=x86_64-linux-gnu
$(UBUNTU64)-expat-configure  := --host=x86_64-linux-gnu
$(UBUNTU64)-gettext-configure:= --enable-threads=posix
$(UBUNTU64)-glib-vars        := PKG_CONFIG_PATH="$(abspath $(OBJ_UBUNTU64)/install/riscv-qemu-$(RQEMU_VERSION)-$(UBUNTU64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_UBUNTU64)/install/riscv-qemu-$(RQEMU_VERSION)-$(UBUNTU64))/lib -I$(abspath $(OBJ_UBUNTU64)/install/riscv-qemu-$(RQEMU_VERSION)-$(UBUNTU64))/include"
$(UBUNTU64)-xc3sp-host       := --host=x86_64-linux-gnu
$(UBUNTU64)-xdeps-vars       := PKG_CONFIG_PATH="$(abspath $(OBJ_UBUNTU64)/install/xc3sprog-$(XC3SP_VERSION)-$(UBUNTU64))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_UBUNTU64)/install/xc3sprog-$(XC3SP_VERSION)-$(UBUNTU64))/include" LDFLAGS="-L$(abspath $(OBJ_UBUNTU64)/install/xc3sprog-$(XC3SP_VERSION)-$(UBUNTU64))/lib"
$(UBUNTU64)-xc3sp-vars       := PKG_CONFIG_PATH="$(abspath $(OBJ_UBUNTU64)/install/xc3sprog-$(XC3SP_VERSION)-$(UBUNTU64))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_UBUNTU64)/install/xc3sprog-$(XC3SP_VERSION)-$(UBUNTU64))/include" CPPFLAGS="-I$(abspath $(OBJ_UBUNTU64)/install/xc3sprog-$(XC3SP_VERSION)-$(UBUNTU64))/include" LIBUSB_INCLUDE_DIRS="$(abspath $(OBJ_UBUNTU64)/install/xc3sprog-$(XC3SP_VERSION)-$(UBUNTU64))/include" LDFLAGS="-L$(abspath $(OBJ_UBUNTU64)/install/xc3sprog-$(XC3SP_VERSION)-$(UBUNTU64))/lib"
$(UBUNTU64)-pyobj-tarball    := python-2.7.12-x86_64-linux-ubuntu14.tar.gz
$(UBUNTU64)-trace-configure  := --enable-shared --enable-static
$(DARWIN)-rgcc-configure     := --with-system-zlib
$(DARWIN)-rgdb-configure     := --with-python=python2.7
$(DARWIN)-ousb-configure     := --disable-shared
$(DARWIN)-odeps-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/riscv-openocd-$(ROCD_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_DARWIN)/install/riscv-openocd-$(ROCD_VERSION)-$(DARWIN))/include" CPPFLAGS="-I$(abspath $(OBJ_DARWIN)/install/riscv-openocd-$(ROCD_VERSION)-$(DARWIN))/include" LDFLAGS="-L$(abspath $(OBJ_DARWIN)/install/riscv-openocd-$(ROCD_VERSION)-$(DARWIN))/lib -framework CoreFoundation -framework IOKit"
$(DARWIN)-rocd-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/riscv-openocd-$(ROCD_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_DARWIN)/install/riscv-openocd-$(ROCD_VERSION)-$(DARWIN))/include -O2" CPPFLAGS="-I$(abspath $(OBJ_DARWIN)/install/riscv-openocd-$(ROCD_VERSION)-$(DARWIN))/include" LDFLAGS="-L$(abspath $(OBJ_DARWIN)/install/riscv-openocd-$(ROCD_VERSION)-$(DARWIN))/lib -framework CoreFoundation -framework IOKit"
$(DARWIN)-rqemu-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/include" CPPFLAGS="-I$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/include" LDFLAGS="-L$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/lib -liconv -framework CoreFoundation -framework Carbon" PATH=/usr/local/opt/gettext/bin:$(PATH)
$(DARWIN)-expat-configure    := --disable-shared --enable-static
$(DARWIN)-gettext-configure  := --enable-threads=posix
$(DARWIN)-glib-configure     := --enable-static
$(DARWIN)-glib-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/lib -I$(abspath $(OBJ_DARWIN)/install/riscv-qemu-$(RQEMU_VERSION)-$(DARWIN))/include" PATH=/usr/local/opt/gettext/bin:$(PATH)
$(DARWIN)-xdeps-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/xc3sprog-$(XC3SP_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_DARWIN)/install/xc3sprog-$(XC3SP_VERSION)-$(DARWIN))/include" CPPFLAGS="-I$(abspath $(OBJ_DARWIN)/install/xc3sprog-$(XC3SP_VERSION)-$(DARWIN))/include" LDFLAGS="-L$(abspath $(OBJ_DARWIN)/install/xc3sprog-$(XC3SP_VERSION)-$(DARWIN))/lib -framework CoreFoundation -framework IOKit"
$(DARWIN)-xc3sp-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/xc3sprog-$(XC3SP_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_DARWIN)/install/xc3sprog-$(XC3SP_VERSION)-$(DARWIN))/include" CPPFLAGS="-I$(abspath $(OBJ_DARWIN)/install/xc3sprog-$(XC3SP_VERSION)-$(DARWIN))/include" LDFLAGS="-L$(abspath $(OBJ_DARWIN)/install/xc3sprog-$(XC3SP_VERSION)-$(DARWIN))/lib -liconv -framework CoreFoundation -framework IOKit"
$(DARWIN)-xc3sp-framework    := -framework CoreFoundation -framework IOKit
$(DARWIN)-pyobj-tarball      := python-2.7.10-x86_64-apple-darwin.tar.gz
$(REDHAT)-rgcc-configure     := --with-system-zlib
$(REDHAT)-rgdb-configure     := --with-python="$(abspath $(SCRIPTSDIR)/pyconfig-centos.sh)"
$(REDHAT)-ousb-configure     := --disable-shared
$(REDHAT)-odeps-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/lib/pkgconfig:$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/lib64/pkgconfig" CFLAGS="-I$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/include -fPIC" LDFLAGS="-L$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/lib64 -lrt"
$(REDHAT)-rocd-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/lib/pkgconfig:$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/lib64/pkgconfig" CFLAGS="-I$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/include -O2" CPPFLAGS="-I$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/include" LIBUSB_INCLUDE_DIRS="$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/include" LDFLAGS="-L$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/riscv-openocd-$(ROCD_VERSION)-$(REDHAT))/lib64 -lrt"
$(REDHAT)-rqemu-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/lib/pkgconfig" CFLAGS="-fPIC -I$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/include -Wno-unused-result" CPPFLAGS="-fPIC -I$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/include" LDFLAGS="-L$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/lib -liconv" LIBS="-L$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/lib -liconv" SIFIVE_LIBS_QGA="-L$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/lib -liconv"
$(REDHAT)-zlib-configure     := -static
$(REDHAT)-gettext-configure  := --enable-threads=posix
$(REDHAT)-glib-configure     := --enable-static
$(REDHAT)-glib-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/lib/pkgconfig" CFLAGS="-fPIC -L$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/lib -I$(abspath $(OBJ_REDHAT)/install/riscv-qemu-$(RQEMU_VERSION)-$(REDHAT))/include"
$(REDHAT)-libpng-vars        := CFLAGS="-fPIC" CPPFLAGS="-fPIC"
$(REDHAT)-pixman-vars        := CFLAGS="-fPIC" CPPFLAGS="-fPIC"
$(REDHAT)-deps-vars          := CFLAGS="-fPIC"
$(REDHAT)-xdeps-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/xc3sprog-$(XC3SP_VERSION)-$(REDHAT))/lib/pkgconfig:$(abspath $(OBJ_REDHAT)/install/xc3sprog-$(XC3SP_VERSION)-$(REDHAT))/lib64/pkgconfig" CFLAGS="-I$(abspath $(OBJ_REDHAT)/install/xc3sprog-$(XC3SP_VERSION)-$(REDHAT))/include" LDFLAGS="-L$(abspath $(OBJ_REDHAT)/install/xc3sprog-$(XC3SP_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/xc3sprog-$(XC3SP_VERSION)-$(REDHAT))/lib64 -lrt"
$(REDHAT)-xc3sp-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/xc3sprog-$(XC3SP_VERSION)-$(REDHAT))/lib/pkgconfig:$(abspath $(OBJ_REDHAT)/install/xc3sprog-$(XC3SP_VERSION)-$(REDHAT))/lib64/pkgconfig" CFLAGS="-I$(abspath $(OBJ_REDHAT)/install/xc3sprog-$(XC3SP_VERSION)-$(REDHAT))/include" CPPFLAGS="-I$(abspath $(OBJ_REDHAT)/install/xc3sprog-$(XC3SP_VERSION)-$(REDHAT))/include" LIBUSB_INCLUDE_DIRS="$(abspath $(OBJ_REDHAT)/install/xc3sprog-$(XC3SP_VERSION)-$(REDHAT))/include" LDFLAGS="-L$(abspath $(OBJ_REDHAT)/install/xc3sprog-$(XC3SP_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/xc3sprog-$(XC3SP_VERSION)-$(REDHAT))/lib64 -lrt"
$(REDHAT)-xc3sp-configure    := -DLIBRT_LIBRARIES="rt"
$(REDHAT)-pyobj-tarball      := python-2.7.16-x86_64-linux-centos6.tar.gz
$(REDHAT)-trace-configure    := --enable-shared --enable-static

# Some general riscv-gnu-toolchain flags and list of multilibs for the multilibs generator script
WITH_ABI := lp64d
WITH_ARCH := rv64imafdc
WITH_CMODEL := medany
NEWLIB_TUPLE := riscv64-unknown-elf
MULTILIBS_GEN := \
	rv32e-ilp32e--c \
	rv32ea-ilp32e--m \
	rv32em-ilp32e--c \
	rv32eac-ilp32e-- \
	rv32emac-ilp32e-- \
	rv32i-ilp32--c,f,fc,fd,fdc \
	rv32ia-ilp32-rv32ima,rv32iaf,rv32imaf,rv32iafd,rv32imafd- \
	rv32im-ilp32--c,f,fc,fd,fdc \
	rv32iac-ilp32--f,fd \
	rv32imac-ilp32-rv32imafc,rv32imafdc- \
	rv32if-ilp32f--c,d,dc \
	rv32iaf-ilp32f--c,d,dc \
	rv32imf-ilp32f--d \
	rv32imaf-ilp32f-rv32imafd- \
	rv32imfc-ilp32f--d \
	rv32imafc-ilp32f-rv32imafdc- \
	rv32ifd-ilp32d--c \
	rv32imfd-ilp32d--c \
	rv32iafd-ilp32d-rv32imafd,rv32iafdc- \
	rv32imafdc-ilp32d-- \
	rv64i-lp64--c,f,fc,fd,fdc \
	rv64ia-lp64-rv64ima,rv64iaf,rv64imaf,rv64iafd,rv64imafd- \
	rv64im-lp64--c,f,fc,fd,fdc \
	rv64iac-lp64--f,fd \
	rv64imac-lp64-rv64imafc,rv64imafdc- \
	rv64if-lp64f--c,d,dc \
	rv64iaf-lp64f--c,d,dc \
	rv64imf-lp64f--d \
	rv64imaf-lp64f-rv64imafd- \
	rv64imfc-lp64f--d \
	rv64imafc-lp64f-rv64imafdc- \
	rv64ifd-lp64d--c \
	rv64imfd-lp64d--c \
	rv64iafd-lp64d-rv64imafd,rv64iafdc- \
	rv64imafdc-lp64d--

CFLAGS_FOR_TARGET := $(CFLAGS_FOR_TARGET_EXTRA) -mcmodel=$(WITH_CMODEL)
CXXFLAGS_FOR_TARGET := $(CXXFLAGS_FOR_TARGET_EXTRA) -mcmodel=$(WITH_CMODEL)
# --with-expat is required to enable XML support used by OpenOCD.
BINUTILS_TARGET_FLAGS := --with-expat=yes $(BINUTILS_TARGET_FLAGS_EXTRA) --with-mpc=no --with-mpfr=no --with-gmp=no
GDB_TARGET_FLAGS := --with-expat=yes $(GDB_TARGET_FLAGS_EXTRA) --with-mpc=no --with-mpfr=no --with-gmp=no
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
		$(OBJDIR)/%/build/riscv-gnu-toolchain/build-gdb-py-newlib/stamp \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/build-picolibc/stamp
	mkdir -p $(dir $@)
	date > $@

$(OBJDIR)/%/build/riscv-gnu-toolchain/stamp:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-toolchain/stamp,%,$@))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	mkdir -p $(dir $@)/python
	cd $(dir $@); curl -L -f -s -o $($($@_TARGET)-pyobj-tarball) https://github.com/sifive/freedom-tools-resources/releases/download/v0-test1/$($($@_TARGET)-pyobj-tarball)
	cd $(dir $@)/python; $(TAR) -xf ../$($($@_TARGET)-pyobj-tarball)
	cd $(dir $@); rm $($($@_TARGET)-pyobj-tarball)
	cp -a $(SRC_RBU) $(SRC_RGCC) $(SRC_RGDB) $(SRC_RNL) $(dir $@)
	$(SED) -E -i -f $(SCRIPTSDIR)/gdb-python.sed $(dir $@)/riscv-gdb/gdb/python/python.c
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
	$(MAKE) -C $(dir $@) install -j1 install-pdf install-html &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-gnu-toolchain/build-gdb-newlib/stamp: \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/build-binutils-newlib/stamp
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
		--with-python=no \
		--enable-gdb \
		--disable-gas \
		--disable-binutils \
		--disable-ld \
		--disable-gold \
		--disable-gprof \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install -j1 install-pdf install-html &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-gnu-toolchain/build-gdb-py-newlib/stamp: \
		$(OBJDIR)/%/build/riscv-gnu-toolchain/build-gdb-newlib/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-toolchain/build-gdb-py-newlib/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-gnu-toolchain/build-gdb-py-newlib/stamp,%/install/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-gnu-toolchain/build-gdb-py-newlib/stamp,%/build/riscv-gnu-toolchain,$@))
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
		$($($@_TARGET)-rgdb-configure) \
		--program-prefix="$(NEWLIB_TUPLE)-" \
		--program-suffix="-py" \
		--enable-gdb \
		--disable-gas \
		--disable-binutils \
		--disable-ld \
		--disable-gold \
		--disable-gprof \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install -j1 install-pdf install-html &>$(dir $@)/make-install.log
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
		--disable-tm-clone-registry \
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
		--enable-newlib-register-fini \
		CFLAGS_FOR_TARGET="-O2 -D_POSIX_MODE $(CFLAGS_FOR_TARGET)" \
		CXXFLAGS_FOR_TARGET="-O2 -D_POSIX_MODE $(CXXFLAGS_FOR_TARGET)" &>make-configure.log
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
	for bnls in `find $${bnl} -name crt0.0`; \
	do \
		inls=`echo $${bnls} | $(SED) -e "s:$${bnl}::"`; \
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
		--disable-tm-clone-registry \
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
	$(MAKE) -C $(dir $@) install -j1 install-pdf install-html &>$(dir $@)/make-install.log
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
	mkdir -p $(dir $@)/m4
	cd $(dir $@); ./buildconf.sh &>make-buildconf.log
	touch -c $@

# Builds riscv-gdb-only for various targets.
$(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-%.zip: \
		$(OBJDIR)/%/stamps/riscv-gnu-gdb-only/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-%.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/install; zip -rq $(abspath $@) riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$($@_TARGET)

$(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-%.src.zip: \
		$(OBJDIR)/%/stamps/riscv-gnu-gdb-only/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-%.src.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/build; zip -rq $(abspath $@) riscv-gnu-gdb-only expat-gdb

$(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-%.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-gnu-gdb-only/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-%.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/install -c riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$($@_TARGET) | gzip > $(abspath $@)

$(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-%.src.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-gnu-gdb-only/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-%.src.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/build -c riscv-gnu-gdb-only expat-gdb | gzip > $(abspath $@)

$(OBJDIR)/%/stamps/riscv-gnu-gdb-only/install.stamp: \
		$(OBJDIR)/%/build/riscv-gnu-gdb-only/build-gdb-py-newlib/stamp
	mkdir -p $(dir $@)
	date > $@

$(OBJDIR)/%/build/riscv-gnu-gdb-only/stamp:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-gdb-only/stamp,%,$@))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	mkdir -p $(dir $@)/python
	cd $(dir $@); curl -L -f -s -o $($($@_TARGET)-pyobj-tarball) https://github.com/sifive/freedom-tools-resources/releases/download/v0-test1/$($($@_TARGET)-pyobj-tarball)
	cd $(dir $@)/python; $(TAR) -xf ../$($($@_TARGET)-pyobj-tarball)
	cd $(dir $@); rm $($($@_TARGET)-pyobj-tarball)
	cp -a $(SRC_RBU) $(SRC_RGDB) $(dir $@)
	$(SED) -E -i -f $(SCRIPTSDIR)/gdb-python.sed $(dir $@)/riscv-gdb/gdb/python/python.c
	date > $@

$(OBJDIR)/%/build/riscv-gnu-gdb-only/build-binutils-newlib/stamp: \
		$(OBJDIR)/%/stamps/expat-gdb/install.stamp \
		$(OBJDIR)/%/build/riscv-gnu-gdb-only/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-gdb-only/build-binutils-newlib/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-gnu-gdb-only/build-binutils-newlib/stamp,%/install/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-gnu-gdb-only/build-binutils-newlib/stamp,%/build/riscv-gnu-gdb-only,$@))
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
	$(MAKE) -C $(dir $@) install -j1 install-pdf install-html &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-gnu-gdb-only/build-gdb-newlib/stamp: \
		$(OBJDIR)/%/build/riscv-gnu-gdb-only/build-binutils-newlib/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-gdb-only/build-gdb-newlib/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-gnu-gdb-only/build-gdb-newlib/stamp,%/install/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-gnu-gdb-only/build-gdb-newlib/stamp,%/build/riscv-gnu-gdb-only,$@))
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
		--with-python=no \
		--enable-gdb \
		--disable-gas \
		--disable-binutils \
		--disable-ld \
		--disable-gold \
		--disable-gprof \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install -j1 install-pdf install-html &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-gnu-gdb-only/build-gdb-py-newlib/stamp: \
		$(OBJDIR)/%/build/riscv-gnu-gdb-only/build-gdb-newlib/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-gdb-only/build-gdb-py-newlib/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-gnu-gdb-only/build-gdb-py-newlib/stamp,%/install/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-gnu-gdb-only/build-gdb-py-newlib/stamp,%/build/riscv-gnu-gdb-only,$@))
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
		$($($@_TARGET)-rgdb-configure) \
		--program-prefix="$(NEWLIB_TUPLE)-" \
		--program-suffix="-py" \
		--enable-gdb \
		--disable-gas \
		--disable-binutils \
		--disable-ld \
		--disable-gold \
		--disable-gprof \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install -j1 install-pdf install-html &>$(dir $@)/make-install.log
	date > $@

# OpenOCD requires a GDB that's been build with expat support so it can read
# the target XML files.
$(OBJDIR)/%/stamps/expat-gdb/install.stamp: \
		$(OBJDIR)/%/build/expat-gdb/configure
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/stamps/expat-gdb/install.stamp,%,$@))
	$(eval $@_BUILD := $(patsubst %/stamps/expat-gdb/install.stamp,%/build/expat-gdb,$@))
	$(eval $@_INSTALL := $(patsubst %/stamps/expat-gdb/install.stamp,%/install/riscv64-unknown-elf-gdb-$(RGDB_VERSION)-$($@_TARGET),$@))
	mkdir -p $($@_BUILD)
	cd $($@_BUILD); ./configure --prefix=$(abspath $($@_INSTALL)) $($($@_TARGET)-expat-configure) &>make-configure.log
	$(MAKE) -C $($@_BUILD) buildlib &>$($@_BUILD)/make-buildlib.log
	$(MAKE) -C $($@_BUILD) installlib &>$($@_BUILD)/make-installlib.log
	mkdir -p $(dir $@)
	date > $@

$(OBJDIR)/%/build/expat-gdb/configure:
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
	cd $(OBJDIR)/$($@_TARGET)/build; zip -rq $(abspath $@) riscv-openocd

$(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-openocd/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/install -c riscv-openocd-$(ROCD_VERSION)-$($@_TARGET) | gzip > $(abspath $@)

$(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.src.tar.gz: \
		$(OBJDIR)/%/stamps/riscv-openocd/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/riscv-openocd-$(ROCD_VERSION)-%.src.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/build -c riscv-openocd | gzip > $(abspath $@)

$(OBJDIR)/%/stamps/riscv-openocd/install.stamp: \
		$(OBJDIR)/%/build/riscv-openocd/riscv-openocd/stamp
	mkdir -p $(dir $@)
	date > $@

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

$(OBJDIR)/%/build/riscv-openocd/stamp:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-openocd/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-openocd/stamp,%/install/riscv-openocd-$(ROCD_VERSION)-$($@_TARGET),$@))
	rm -rf $($@_INSTALL)
	mkdir -p $($@_INSTALL)
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cd $(dir $@); curl -L -f -s -o libusb-1.0.22.tar.bz2 https://github.com/libusb/libusb/releases/download/v1.0.22/libusb-1.0.22.tar.bz2
	cd $(dir $@); $(TAR) -xf libusb-1.0.22.tar.bz2
	cd $(dir $@); mv libusb-1.0.22 libusb
	cd $(dir $@); curl -L -f -s -o libusb-compat-0.1.7.tar.bz2 https://github.com/libusb/libusb-compat-0.1/releases/download/v0.1.7/libusb-compat-0.1.7.tar.bz2
	cd $(dir $@); $(TAR) -xf libusb-compat-0.1.7.tar.bz2
	cd $(dir $@); mv libusb-compat-0.1.7 libusb-compat
	cd $(dir $@); curl -L -f -s -o libftdi1-1.4.tar.bz2 https://www.intra2net.com/en/developer/libftdi/download/libftdi1-1.4.tar.bz2
	cd $(dir $@); $(TAR) -xf libftdi1-1.4.tar.bz2
	cd $(dir $@); mv libftdi1-1.4 libftdi
	cp -a $(SRC_ROCD) $(dir $@)
	$(SED) -i -f $(SCRIPTSDIR)/openocd.sed -e "s/SIFIVE_PACKAGE_VERSION/SiFive OpenOCD $(ROCD_VERSION)/" $(dir $@)/riscv-openocd/src/openocd.c
	$(SED) -E -i -f $(SCRIPTSDIR)/openocd-rtos.sed $(dir $@)/riscv-openocd/src/rtos/rtos.c
	date > $@

$(OBJDIR)/%/build/riscv-openocd/libusb/stamp: \
		$(OBJDIR)/%/build/riscv-openocd/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-openocd/libusb/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-openocd/libusb/stamp,%/install/riscv-openocd-$(ROCD_VERSION)-$($@_TARGET),$@))
	cd $(dir $@) && $($($@_TARGET)-odeps-vars) ./configure \
		$($($@_TARGET)-rocd-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--disable-udev \
		--enable-static \
		$($($@_TARGET)-ousb-configure) &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-openocd/libusb-compat/stamp: \
		$(OBJDIR)/%/build/riscv-openocd/libusb/stamp \
		$(OBJDIR)/%/build/riscv-openocd/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-openocd/libusb-compat/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-openocd/libusb-compat/stamp,%/install/riscv-openocd-$(ROCD_VERSION)-$($@_TARGET),$@))
	cd $(dir $@) && $($($@_TARGET)-odeps-vars) ./configure \
		$($($@_TARGET)-rocd-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static \
		$($($@_TARGET)-ousb-configure) &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-openocd/libftdi/stamp: \
		$(OBJDIR)/%/build/riscv-openocd/libusb-compat/stamp \
		$(OBJDIR)/%/build/riscv-openocd/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-openocd/libftdi/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-openocd/libftdi/stamp,%/install/riscv-openocd-$(ROCD_VERSION)-$($@_TARGET),$@))
	cd $(dir $@) && $($($@_TARGET)-odeps-vars) cmake \
		-DCMAKE_INSTALL_PREFIX:PATH=$(abspath $($@_INSTALL)) \
		$($($@_TARGET)-oftdi-configure) . &>make-cmake.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/riscv-openocd/riscv-openocd/stamp: \
		$(OBJDIR)/%/build/riscv-openocd/libftdi/stamp \
		$(OBJDIR)/%/build/riscv-openocd/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-openocd/riscv-openocd/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-openocd/riscv-openocd/stamp,%/install/riscv-openocd-$(ROCD_VERSION)-$($@_TARGET),$@))
	rm -f $(abspath $($@_INSTALL))/lib/lib*.dylib*
	rm -f $(abspath $($@_INSTALL))/lib/lib*.so*
	rm -f $(abspath $($@_INSTALL))/lib64/lib*.so*
	find $(dir $@) -iname configure.ac | $(SED) s/configure.ac/m4/ | xargs mkdir -p
	cd $(dir $@); ./bootstrap nosubmodule &>make-bootstrap.log
	cd $(dir $@); $($($@_TARGET)-rocd-vars) ./configure \
		$($($@_TARGET)-rocd-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--disable-remote-bitbang \
		--disable-werror \
		--enable-ftdi \
		$($($@_TARGET)-rocd-configure) &>make-configure.log
	$(MAKE) $($($@_TARGET)-rocd-vars) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) $($($@_TARGET)-rocd-vars) -C $(dir $@) pdf html &>$(dir $@)/make-build-doc.log
	$(MAKE) $($($@_TARGET)-rocd-vars) -C $(dir $@) install -j1 install-pdf install-html &>$(dir $@)/make-install.log
	date > $@

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
	rm -rf $(dir $@)/riscv-qemu/hw/riscv/sifive_e.c
	cp -a $(SCRIPTSDIR)/qemu-sifive-e.c $(dir $@)/riscv-qemu/hw/riscv/sifive_e.c
	rm -rf $(dir $@)/riscv-qemu/hw/riscv/sifive_test.c
	cp -a $(SCRIPTSDIR)/qemu-sifive-test.c $(dir $@)/riscv-qemu/hw/riscv/sifive_test.c
	rm -rf $(dir $@)/riscv-qemu/hw/riscv/sifive_u.c
	cp -a $(SCRIPTSDIR)/qemu-sifive-u.c $(dir $@)/riscv-qemu/hw/riscv/sifive_u.c
	rm -rf $(dir $@)/riscv-qemu/include/hw/riscv/sifive_e.h
	cp -a $(SCRIPTSDIR)/qemu-sifive-e.h $(dir $@)/riscv-qemu/include/hw/riscv/sifive_e.h
	rm -rf $(dir $@)/riscv-qemu/include/hw/riscv/sifive_u.h
	cp -a $(SCRIPTSDIR)/qemu-sifive-u.h $(dir $@)/riscv-qemu/include/hw/riscv/sifive_u.h
	$(SED) -i -f $(SCRIPTSDIR)/qemu-configure.sed $(dir $@)/riscv-qemu/configure
	$(SED) -i -f $(SCRIPTSDIR)/qemu-common.sed $(dir $@)/riscv-qemu/include/qemu-common.h
	$(SED) -i -f $(SCRIPTSDIR)/qemu-vl.sed $(dir $@)/riscv-qemu/vl.c
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
	rm -rf $(abspath $($@_INSTALL))/share/gdb
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
	rm -f $(abspath $($@_INSTALL))/lib/lib*.dylib*
	rm -f $(abspath $($@_INSTALL))/lib/lib*.so*
	rm -f $(abspath $($@_INSTALL))/lib64/lib*.so*
	cd $(dir $@) && $($($@_TARGET)-rqemu-vars) ./configure \
		$($($@_TARGET)-rqemu-cross) \
		--prefix=$(abspath $($@_INSTALL))$($($@_TARGET)-rqemu-bindir) \
		--with-pkgversion="SiFive QEMU $(RQEMU_VERSION)" \
		--target-list=riscv32-softmmu,riscv64-softmmu \
		--interp-prefix=$(abspath $($@_INSTALL))/sysroot \
		--disable-libusb \
		--disable-vhost-user \
		--disable-vhost-kernel &>make-configure.log
	$($($@_TARGET)-rqemu-vars) $(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

# The XC3SPROG builds go here
$(BINDIR)/xc3sprog-$(XC3SP_VERSION)-%.zip: \
		$(OBJDIR)/%/stamps/xc3sprog/install.stamp \
		$(OBJDIR)/%/stamps/xc3sprog/libs.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-%.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/install; zip -rq $(abspath $@) xc3sprog-$(XC3SP_VERSION)-$($@_TARGET)

$(BINDIR)/xc3sprog-$(XC3SP_VERSION)-%.src.zip: \
		$(OBJDIR)/%/stamps/xc3sprog/install.stamp \
		$(OBJDIR)/%/stamps/xc3sprog/libs.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-%.src.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/build; zip -rq $(abspath $@) xc3sprog

$(BINDIR)/xc3sprog-$(XC3SP_VERSION)-%.tar.gz: \
		$(OBJDIR)/%/stamps/xc3sprog/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-%.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/install -c xc3sprog-$(XC3SP_VERSION)-$($@_TARGET) | gzip > $(abspath $@)

$(BINDIR)/xc3sprog-$(XC3SP_VERSION)-%.src.tar.gz: \
		$(OBJDIR)/%/stamps/xc3sprog/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/xc3sprog-$(XC3SP_VERSION)-%.src.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/build -c xc3sprog | gzip > $(abspath $@)

$(OBJDIR)/%/stamps/xc3sprog/install.stamp: \
		$(OBJDIR)/%/build/xc3sprog/xc3sprog/stamp
	mkdir -p $(dir $@)
	date > $@

# We might need some extra target libraries for XC3SPROG
$(OBJ_NATIVE)/stamps/xc3sprog/libs.stamp: \
		$(OBJ_NATIVE)/stamps/xc3sprog/install.stamp
	date > $@

$(OBJ_WIN64)/stamps/xc3sprog/libs.stamp: \
		$(OBJ_WIN64)/stamps/xc3sprog/install.stamp
	$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libgcc_s_seh*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64)/bin
	$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libssp*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64)/bin
	$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libwinpthread*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN64)/bin
	date > $@

$(OBJ_WIN32)/stamps/xc3sprog/libs.stamp: \
		$(OBJ_WIN32)/stamps/xc3sprog/install.stamp
	$(WIN32)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libgcc_s_seh*.dll" | xargs cp -t $(OBJDIR)/$(WIN32)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN32)/bin
	$(WIN32)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libssp*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN32)/bin
	$(WIN32)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libwinpthread*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/xc3sprog-$(XC3SP_VERSION)-$(WIN32)/bin
	date > $@

$(OBJDIR)/%/build/xc3sprog/stamp:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/xc3sprog/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/xc3sprog/stamp,%/install/xc3sprog-$(XC3SP_VERSION)-$($@_TARGET),$@))
	rm -rf $($@_INSTALL)
	mkdir -p $($@_INSTALL)
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cd $(dir $@); curl -L -f -s -o libusb-1.0.22.tar.bz2 https://github.com/libusb/libusb/releases/download/v1.0.22/libusb-1.0.22.tar.bz2
	cd $(dir $@); $(TAR) -xf libusb-1.0.22.tar.bz2
	cd $(dir $@); mv libusb-1.0.22 libusb
	cd $(dir $@); curl -L -f -s -o libusb-compat-0.1.7.tar.bz2 https://github.com/libusb/libusb-compat-0.1/releases/download/v0.1.7/libusb-compat-0.1.7.tar.bz2
	cd $(dir $@); $(TAR) -xf libusb-compat-0.1.7.tar.bz2
	cd $(dir $@); mv libusb-compat-0.1.7 libusb-compat
	cd $(dir $@); curl -L -f -s -o libftdi1-1.4.tar.bz2 https://www.intra2net.com/en/developer/libftdi/download/libftdi1-1.4.tar.bz2
	cd $(dir $@); $(TAR) -xf libftdi1-1.4.tar.bz2
	cd $(dir $@); mv libftdi1-1.4 libftdi
	cd $(dir $@); curl -L -f -s -o libiconv-1.15.tar.gz https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz
	cd $(dir $@); $(TAR) -xf libiconv-1.15.tar.gz
	cd $(dir $@); mv libiconv-1.15 libiconv
	cp -a $(SRC_XC3SP) $(dir $@)
	$(SED) -i -f $(SCRIPTSDIR)/xc3sprog.sed -e "s/SIFIVE_PACKAGE_VERSION/SiFive XC3SPROG $(XC3SP_VERSION)/" $(dir $@)/xc3sprog/xc3sprog.cpp
	$(SED) -i -f $(SCRIPTSDIR)/xc3sprog-cmake.sed $(dir $@)/xc3sprog/CMakeLists.txt
	$(SED) -i -f $(SCRIPTSDIR)/xc3sprog-cmake.sed $(dir $@)/xc3sprog/javr/CMakeLists.txt
	$(SED) -i -f $(SCRIPTSDIR)/xc3sprog-mingw32.sed $(dir $@)/xc3sprog/Toolchain-mingw32.cmake
	date > $@

$(OBJDIR)/%/build/xc3sprog/libusb/stamp: \
		$(OBJDIR)/%/build/xc3sprog/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/xc3sprog/libusb/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/xc3sprog/libusb/stamp,%/install/xc3sprog-$(XC3SP_VERSION)-$($@_TARGET),$@))
	cd $(dir $@) && ./configure \
		$($($@_TARGET)-xc3sp-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--disable-udev \
		--enable-static &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/xc3sprog/libusb-compat/stamp: \
		$(OBJDIR)/%/build/xc3sprog/libusb/stamp \
		$(OBJDIR)/%/build/xc3sprog/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/xc3sprog/libusb-compat/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/xc3sprog/libusb-compat/stamp,%/install/xc3sprog-$(XC3SP_VERSION)-$($@_TARGET),$@))
	cd $(dir $@) && $($($@_TARGET)-xdeps-vars) ./configure \
		$($($@_TARGET)-xc3sp-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/xc3sprog/libftdi/stamp: \
		$(OBJDIR)/%/build/xc3sprog/libusb-compat/stamp \
		$(OBJDIR)/%/build/xc3sprog/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/xc3sprog/libftdi/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/xc3sprog/libftdi/stamp,%/install/xc3sprog-$(XC3SP_VERSION)-$($@_TARGET),$@))
	cd $(dir $@) && $($($@_TARGET)-xdeps-vars) cmake \
		-DCMAKE_INSTALL_PREFIX:PATH=$(abspath $($@_INSTALL)) \
		$($($@_TARGET)-xftdi-configure) . &>make-cmake.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/xc3sprog/libiconv/stamp: \
		$(OBJDIR)/%/build/xc3sprog/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/xc3sprog/libiconv/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/xc3sprog/libiconv/stamp,%/install/xc3sprog-$(XC3SP_VERSION)-$($@_TARGET),$@))
	cd $(dir $@) && ./configure \
		$($($@_TARGET)-xc3sp-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/xc3sprog/xc3sprog/stamp: \
		$(OBJDIR)/%/build/xc3sprog/libftdi/stamp \
		$(OBJDIR)/%/build/xc3sprog/libiconv/stamp \
		$(OBJDIR)/%/build/xc3sprog/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/xc3sprog/xc3sprog/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/xc3sprog/xc3sprog/stamp,%/install/xc3sprog-$(XC3SP_VERSION)-$($@_TARGET),$@))
	rm -f $(abspath $($@_INSTALL))/lib/lib*.dylib*
	rm -f $(abspath $($@_INSTALL))/lib/lib*.so*
	rm -f $(abspath $($@_INSTALL))/lib64/lib*.so*
	cd $(dir $@) && $($($@_TARGET)-xc3sp-vars) cmake \
		-DCMAKE_INSTALL_PREFIX:PATH=$(abspath $($@_INSTALL)) \
		-DCMAKE_EXE_LINKER_FLAGS="-L$(abspath $($@_INSTALL))/lib -L$(abspath $($@_INSTALL))/lib64 -pthread $($($@_TARGET)-xc3sp-framework)" \
		-DLIBUSB_INCLUDE_DIRS=$(abspath $($@_INSTALL))/include \
		-DLIBFTDI_LIBRARIES=ftdi1 \
		$($($@_TARGET)-xc3sp-configure) \
		. &>make-cmake.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) install &>$(dir $@)/make-install.log
	rm -f $(abspath $($@_INSTALL))/bin/iconv
	rm -f $(abspath $($@_INSTALL))/bin/iconv.exe
	rm -rf $(abspath $($@_INSTALL))/share
	cp -R $(dir $@)/share $(abspath $($@_INSTALL))
	date > $@

# The Trace Decoder builds go here
$(BINDIR)/trace-decoder-$(TDC_VERSION)-%.zip: \
		$(OBJDIR)/%/stamps/trace-decoder/install.stamp \
		$(OBJDIR)/%/stamps/trace-decoder/libs.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/trace-decoder-$(TDC_VERSION)-%.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/install; zip -rq $(abspath $@) trace-decoder-$(TDC_VERSION)-$($@_TARGET)

$(BINDIR)/trace-decoder-$(TDC_VERSION)-%.src.zip: \
		$(OBJDIR)/%/stamps/trace-decoder/install.stamp \
		$(OBJDIR)/%/stamps/trace-decoder/libs.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/trace-decoder-$(TDC_VERSION)-%.src.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/build; zip -rq $(abspath $@) trace-decoder

$(BINDIR)/trace-decoder-$(TDC_VERSION)-%.tar.gz: \
		$(OBJDIR)/%/stamps/trace-decoder/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/trace-decoder-$(TDC_VERSION)-%.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/install -c trace-decoder-$(TDC_VERSION)-$($@_TARGET) | gzip > $(abspath $@)

$(BINDIR)/trace-decoder-$(TDC_VERSION)-%.src.tar.gz: \
		$(OBJDIR)/%/stamps/trace-decoder/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/trace-decoder-$(TDC_VERSION)-%.src.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/build -c trace-decoder | gzip > $(abspath $@)

$(OBJDIR)/%/stamps/trace-decoder/install.stamp: \
		$(OBJDIR)/%/build/trace-decoder/trace-decoder/stamp
	mkdir -p $(dir $@)
	date > $@

# We might need some extra target libraries for trace-decoder
$(OBJ_NATIVE)/stamps/trace-decoder/libs.stamp: \
		$(OBJ_NATIVE)/stamps/trace-decoder/install.stamp
	date > $@

$(OBJ_WIN64)/stamps/trace-decoder/libs.stamp: \
		$(OBJ_WIN64)/stamps/trace-decoder/install.stamp
	date > $@

$(OBJ_WIN32)/stamps/trace-decoder/libs.stamp: \
		$(OBJ_WIN32)/stamps/trace-decoder/install.stamp
	date > $@

$(OBJDIR)/%/build/trace-decoder/stamp:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/trace-decoder/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/trace-decoder/stamp,%/install/trace-decoder-$(TDC_VERSION)-$($@_TARGET),$@))
	rm -rf $($@_INSTALL)
	mkdir -p $($@_INSTALL)
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cp -a $(SRC_RBU) $(SRC_TDC) $(dir $@)
	date > $@

$(OBJDIR)/%/build/trace-decoder/build-binutils-newlib/stamp: \
		$(OBJDIR)/%/build/trace-decoder/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/trace-decoder/build-binutils-newlib/stamp,%,$@))
	$(eval $@_BUILD := $(patsubst %/build/trace-decoder/build-binutils-newlib/stamp,%/build/trace-decoder,$@))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
# CC_FOR_TARGET is required for the ld testsuite.
	cd $(dir $@) && CC_FOR_TARGET=$(NEWLIB_CC_FOR_TARGET) $(abspath $($@_BUILD))/riscv-binutils/configure \
		--target=$(NEWLIB_TUPLE) \
		$($($@_TARGET)-rgt-host) \
		--prefix=$(abspath $($@_BUILD))/riscv-binutils/install \
		--with-pkgversion="SiFive Binutils $(RGBU_VERSION)" \
		--with-bugurl="https://github.com/sifive/freedom-tools/issues" \
		--disable-werror \
		--with-expat=no --with-mpc=no --with-mpfr=no --with-gmp=no \
		--disable-gdb \
		--disable-sim \
		--disable-libdecnumber \
		--disable-libreadline \
		$($($@_TARGET)-trace-configure) \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" &>make-configure.log
	$(MAKE) -C $(dir $@) &>$(dir $@)/make-build.log
	date > $@

$(OBJDIR)/%/build/trace-decoder/trace-decoder/stamp: \
		$(OBJDIR)/%/build/trace-decoder/build-binutils-newlib/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/trace-decoder/trace-decoder/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/trace-decoder/trace-decoder/stamp,%/install/trace-decoder-$(TDC_VERSION)-$($@_TARGET),$@))
	$(eval $@_BINUTILS := $(patsubst %/build/trace-decoder/trace-decoder/stamp,%/build/trace-decoder/build-binutils-newlib,$@))
	$(MAKE) -C $(dir $@) BINUTILSPATH=$(abspath $($@_BINUTILS)) CROSSPREFIX=$($($@_TARGET)-tdc-cross) all &>$(dir $@)/make-build.log
	$(MAKE) -C $(dir $@) INSTALLPATH=$(abspath $($@_INSTALL)) CROSSPREFIX=$($($@_TARGET)-tdc-cross) install &>$(dir $@)/make-install.log
	date > $@

# The SDK Utilities builds go here
$(BINDIR)/sdk-utilities-$(SDKU_VERSION)-%.zip: \
		$(OBJDIR)/%/stamps/sdk-utilities/install.stamp \
		$(OBJDIR)/%/stamps/sdk-utilities/libs.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-%.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/install; zip -rq $(abspath $@) sdk-utilities-$(SDKU_VERSION)-$($@_TARGET)

$(BINDIR)/sdk-utilities-$(SDKU_VERSION)-%.src.zip: \
		$(OBJDIR)/%/stamps/sdk-utilities/install.stamp \
		$(OBJDIR)/%/stamps/sdk-utilities/libs.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-%.src.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/build; zip -rq $(abspath $@) sdk-utilities

$(BINDIR)/sdk-utilities-$(SDKU_VERSION)-%.tar.gz: \
		$(OBJDIR)/%/stamps/sdk-utilities/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-%.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/install -c sdk-utilities-$(SDKU_VERSION)-$($@_TARGET) | gzip > $(abspath $@)

$(BINDIR)/sdk-utilities-$(SDKU_VERSION)-%.src.tar.gz: \
		$(OBJDIR)/%/stamps/sdk-utilities/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/sdk-utilities-$(SDKU_VERSION)-%.src.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/build -c sdk-utilities | gzip > $(abspath $@)

$(OBJDIR)/%/stamps/sdk-utilities/install.stamp: \
		$(OBJDIR)/%/build/sdk-utilities/dtc/stamp \
		$(OBJDIR)/%/build/sdk-utilities/freedom-elf2hex/stamp \
		$(OBJDIR)/%/build/sdk-utilities/riscv-isa-sim/stamp
	mkdir -p $(dir $@)
	date > $@

# We might need some extra target libraries for sdk-utilities
$(OBJ_NATIVE)/stamps/sdk-utilities/libs.stamp: \
		$(OBJ_NATIVE)/stamps/sdk-utilities/install.stamp
	date > $@

$(OBJ_WIN64)/stamps/sdk-utilities/libs.stamp: \
		$(OBJ_WIN64)/stamps/sdk-utilities/install.stamp
	$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libgcc_s_seh*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/sdk-utilities-$(SDKU_VERSION)-$(WIN64)/bin
	$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libstdc*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/sdk-utilities-$(SDKU_VERSION)-$(WIN64)/bin
	date > $@

$(OBJ_WIN32)/stamps/sdk-utilities/libs.stamp: \
		$(OBJ_WIN32)/stamps/sdk-utilities/install.stamp
	$(WIN32)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libgcc_s_seh*.dll" | xargs cp -t $(OBJDIR)/$(WIN32)/install/sdk-utilities-$(SDKU_VERSION)-$(WIN32)/bin
	$(WIN32)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libstdc*.dll" | xargs cp -t $(OBJDIR)/$(WIN32)/install/sdk-utilities-$(SDKU_VERSION)-$(WIN32)/bin
	date > $@

$(OBJDIR)/%/build/sdk-utilities/stamp:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/sdk-utilities/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/sdk-utilities/stamp,%/install/sdk-utilities-$(SDKU_VERSION)-$($@_TARGET),$@))
	rm -rf $($@_INSTALL)
	mkdir -p $($@_INSTALL)
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cp -a $(SRC_DTC) $(SRC_FE2H) $(SRC_RIS) $(dir $@)
	rm -rf $(dir $@)/dtc/Makefile
	cp -a $(SCRIPTSDIR)/dtc.mk $(dir $@)/dtc/Makefile
	$(SED) -i -f $(SCRIPTSDIR)/dtc-fstree.sed $(dir $@)/dtc/fstree.c
	rm -rf $(dir $@)/riscv-isa-sim/Makefile
	cp $(SCRIPTSDIR)/spike-dasm.mk $(dir $@)/riscv-isa-sim/Makefile
	rm -rf $(dir $@)/riscv-isa-sim/config.h
	cp $(SCRIPTSDIR)/spike-dasm-config.h $(dir $@)/riscv-isa-sim/config.h
	rm -rf $(dir $@)/riscv-isa-sim/riscv/extension.h
	cp $(SCRIPTSDIR)/spike-dasm-extension.h $(dir $@)/riscv-isa-sim/riscv/extension.h
	rm -rf $(dir $@)/riscv-isa-sim/riscv/extensions.cc
	cp $(SCRIPTSDIR)/spike-dasm-extensions.cc $(dir $@)/riscv-isa-sim/riscv/extensions.cc
	date > $@

$(OBJDIR)/%/build/sdk-utilities/dtc/stamp: \
		$(OBJDIR)/%/build/sdk-utilities/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/sdk-utilities/dtc/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/sdk-utilities/dtc/stamp,%/install/sdk-utilities-$(SDKU_VERSION)-$($@_TARGET),$@))
	$(MAKE) -C $(dir $@) install PREFIX=$(abspath $($@_INSTALL)) $($($@_TARGET)-dtc-configure) \
		NO_PYTHON=1 NO_YAML=1 NO_VALGRIND=1 &>$(dir $@)/make-install.log
	rm -f $(abspath $($@_INSTALL))/lib/lib*.dylib*
	rm -f $(abspath $($@_INSTALL))/lib/lib*.so*
	rm -f $(abspath $($@_INSTALL))/lib64/lib*.so*
	date > $@

$(OBJDIR)/%/build/sdk-utilities/freedom-elf2hex/stamp: \
		$(OBJDIR)/%/build/sdk-utilities/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/sdk-utilities/freedom-elf2hex/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/sdk-utilities/freedom-elf2hex/stamp,%/install/sdk-utilities-$(SDKU_VERSION)-$($@_TARGET),$@))
	$(MAKE) -C $(dir $@) install INSTALL_PATH=$(abspath $($@_INSTALL)) $($($@_TARGET)-fe2h-configure) &>$(dir $@)/make-install.log
	date > $@

$(OBJDIR)/%/build/sdk-utilities/riscv-isa-sim/stamp:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/sdk-utilities/riscv-isa-sim/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/sdk-utilities/riscv-isa-sim/stamp,%/install/sdk-utilities-$(SDKU_VERSION)-$($@_TARGET),$@))
	$(MAKE) -C $(dir $@) install \
			EXEC_PREFIX=z \
			SOURCE_PATH=$(abspath $(dir $@)) \
			INSTALL_PATH=$(abspath $($@_INSTALL)) \
			$($($@_TARGET)-sdasm-configure) &>$(dir $@)/make-install.log
	date > $@

# The Python builds go here
$(BINDIR)/python-$(PY_VERSION)-%.zip: \
		$(OBJDIR)/%/stamps/python/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/python-$(PY_VERSION)-%.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/install; zip -rq $(abspath $@) python-$(PY_VERSION)-$($@_TARGET)

$(BINDIR)/python-$(PY_VERSION)-%.tar.gz: \
		$(OBJDIR)/%/stamps/python/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/python-$(PY_VERSION)-%.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/install -c python-$(PY_VERSION)-$($@_TARGET) | gzip > $(abspath $@)

$(OBJDIR)/%/stamps/python/install.stamp:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/stamps/python/install.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/stamps/python/install.stamp,%/install,$@))
	mkdir -p $(dir $@)
	mkdir -p $(abspath $($@_INSTALL)/python-$(PY_VERSION)-$($@_TARGET))
	cd $(abspath $($@_INSTALL)); curl -L -f -s -o $($($@_TARGET)-pyobj-tarball) https://github.com/sifive/freedom-tools-resources/releases/download/v0-test1/$($($@_TARGET)-pyobj-tarball)
	cd $(abspath $($@_INSTALL)/python-$(PY_VERSION)-$($@_TARGET)); $(TAR) -xf ../$($($@_TARGET)-pyobj-tarball)
	cd $(abspath $($@_INSTALL)); rm $($($@_TARGET)-pyobj-tarball)
	date > $@

# The Combo Package builds go here
$(BINDIR)/freedom-tools-$(FT_VERSION)-%.zip: \
		$(OBJDIR)/%/stamps/freedom-tools/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/freedom-tools-$(FT_VERSION)-%.zip,%,$@))
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$($@_TARGET)/install; zip -rq $(abspath $@) freedom-tools-$(FT_VERSION)-$($@_TARGET)

$(BINDIR)/freedom-tools-$(FT_VERSION)-%.tar.gz: \
		$(OBJDIR)/%/stamps/freedom-tools/install.stamp
	$(eval $@_TARGET := $(patsubst $(BINDIR)/freedom-tools-$(FT_VERSION)-%.tar.gz,%,$@))
	mkdir -p $(dir $@)
	$(TAR) --dereference --hard-dereference -C $(OBJDIR)/$($@_TARGET)/install -c freedom-tools-$(FT_VERSION)-$($@_TARGET) | gzip > $(abspath $@)

$(OBJDIR)/%/stamps/freedom-tools/install.stamp:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/stamps/freedom-tools/install.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/stamps/freedom-tools/install.stamp,%/install/freedom-tools-$(FT_VERSION)-$($@_TARGET),$@))
	mkdir -p $(dir $@)
	rm -rf $($@_INSTALL)
	mkdir -p $($@_INSTALL)
	$(TAR) -C $($@_INSTALL) -xf $(shell $(abspath $(SCRIPTSDIR)/find-package.sh) riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET).tar.gz)
	$(TAR) -C $($@_INSTALL) -xf $(shell $(abspath $(SCRIPTSDIR)/find-package.sh) riscv-openocd-$(ROCD_VERSION)-$($@_TARGET).tar.gz)
	$(TAR) -C $($@_INSTALL) -xf $(shell $(abspath $(SCRIPTSDIR)/find-package.sh) riscv-qemu-$(RQEMU_VERSION)-$($@_TARGET).tar.gz)
	$(TAR) -C $($@_INSTALL) -xf $(shell $(abspath $(SCRIPTSDIR)/find-package.sh) xc3sprog-$(XC3SP_VERSION)-$($@_TARGET).tar.gz)
	$(TAR) -C $($@_INSTALL) -xf $(shell $(abspath $(SCRIPTSDIR)/find-package.sh) trace-decoder-$(TDC_VERSION)-$($@_TARGET).tar.gz)
	$(TAR) -C $($@_INSTALL) -xf $(shell $(abspath $(SCRIPTSDIR)/find-package.sh) sdk-utilities-$(SDKU_VERSION)-$($@_TARGET).tar.gz)
	$(TAR) -C $($@_INSTALL) -xf $(shell $(abspath $(SCRIPTSDIR)/find-package.sh) python-$(PY_VERSION)-$($@_TARGET).tar.gz)
	date > $@

$(OBJDIR)/%/build/riscv-gnu-toolchain/build-picolibc/stamp: \
	$(OBJDIR)/%/build/riscv-gnu-toolchain/build-gcc-newlib-stage2/stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/riscv-gnu-toolchain/build-picolibc/stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/riscv-gnu-toolchain/build-picolibc/stamp,%/install/riscv64-unknown-elf-gcc-$(RGT_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/riscv-gnu-toolchain/build-picolibc/stamp,%/build/riscv-gnu-toolchain,$@))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	meson $(dir $@) \
	      $(SRC_PICOLIBC) \
	      -Dincludedir=picolibc/include \
	      -Dlibdir=picolibc/lib \
	      -Dsysroot-install=true \
	      --prefix $(abspath $($@_INSTALL))/$(NEWLIB_TUPLE) \
	      --cross-file $(SRC_PICOLIBC)/cross-riscv64-unknown-elf.txt
	$(NINJA) -C $(dir $@) install >& $(dir $@)/make-install.log
	date > $@

# Targets that don't build anything
.PHONY: clean
clean::
	rm -rf $(OBJDIR) $(BINDIR)
