include ../../scripts/base_toolchain_metadata.mk

# Git repos, branches, commits and folders to get source code for the tool we are building
RISCV_GCC_GITURL := git@github.com:sifive/riscv-gcc.git
RISCV_GCC_BRANCH := sifive-gcc-10.2.0
RISCV_GCC_COMMIT := 37e9e5efeda593e0ff594105c83da67d2d2832e5
RISCV_GCC_FOLDER := riscv-gcc

# Version number, which should match the official version of the tool we are building
RISCV_GCC_VERSION := 10.2.0

# Customization ID, which should identify the customization added to the original by SiFive
FREEDOM_GCC_ID := $(FREEDOM_TOOLCHAIN_ID)

# Characteristic tags, which should be usable for matching up providers and consumers
FREEDOM_GCC_RISCV_TAGS := $(FREEDOM_TOOLCHAIN_RISCV_TAGS)
FREEDOM_GCC_TAG_PREFIX := gcc10
