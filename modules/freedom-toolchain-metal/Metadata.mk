include ../freedom-binutils-metal/Metadata.mk
include ../freedom-gcc-metal/Metadata.mk
include ../freedom-gdb-metal/Metadata.mk
include ../../scripts/base_toolchain_metadata.mk

# Version number, which should match the official version of the tool we are building
RISCV_TOOLCHAIN_VERSION := $(RISCV_GCC_VERSION)

# Customization ID, which should identify the customization added to the original by SiFive
FREEDOM_TOOLCHAIN_METAL_ID := $(FREEDOM_TOOLCHAIN_ID)

# Characteristic tags, which should be usable for matching up providers and consumers
FREEDOM_TOOLCHAIN_METAL_RISCV_TAGS := $(FREEDOM_TOOLCHAIN_RISCV_TAGS)
FREEDOM_TOOLCHAIN_METAL_TOOLS_TAGS := $(FREEDOM_BINUTILS_METAL_TOOLS_TAGS) $(FREEDOM_GCC_METAL_TOOLS_TAGS) $(FREEDOM_GDB_METAL_TOOLS_TAGS)
