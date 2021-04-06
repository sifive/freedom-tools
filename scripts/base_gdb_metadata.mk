include ../../scripts/base_toolchain_metadata.mk

# Git repos, branches, commits and folders to get source code for the tool we are building
RISCV_GDB_GITURL := git@github.com:sifive/riscv-binutils-gdb.git
RISCV_GDB_BRANCH := sifive-gdb-rvv-1.0.x-zfh-rvb-with-sim
RISCV_GDB_COMMIT := 1ac8c2ffcb4a0a98d0597e71f9313352bda11ee3
RISCV_GDB_FOLDER := riscv-gdb

# Version number, which should match the official version of the tool we are building
RISCV_GDB_VERSION := 10.1.0

# Customization ID, which should identify the customization added to the original by SiFive
FREEDOM_GDB_ID := $(FREEDOM_TOOLCHAIN_ID)

# Characteristic tags, which should be usable for matching up providers and consumers
FREEDOM_GDB_RISCV_TAGS := $(FREEDOM_TOOLCHAIN_RISCV_TAGS)
FREEDOM_GDB_TAG_PREFIX := gdb
