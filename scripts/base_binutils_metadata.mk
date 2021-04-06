include ../../scripts/base_toolchain_metadata.mk

# Git repos, branches, commits and folders to get source code for the tool we are building
RISCV_BINUTILS_GITURL := git@github.com:sifive/riscv-binutils-gdb.git
RISCV_BINUTILS_BRANCH := sifive-rvv-1.0.x-zfh-rvb
RISCV_BINUTILS_COMMIT := 75d2236ce26a3048f52bbd5186602e27bd635e2b
RISCV_BINUTILS_FOLDER := riscv-binutils

# Version number, which should match the official version of the tool we are building
RISCV_BINUTILS_VERSION := 2.35.0

# Customization ID, which should identify the customization added to the original by SiFive
FREEDOM_BINUTILS_ID := $(FREEDOM_TOOLCHAIN_ID)

# Characteristic tags, which should be usable for matching up providers and consumers
FREEDOM_BINUTILS_RISCV_TAGS := $(FREEDOM_TOOLCHAIN_RISCV_TAGS)
FREEDOM_BINUTILS_TAG_PREFIX := binutils
