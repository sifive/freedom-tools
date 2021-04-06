include ../freedom-binutils-metal/Metadata.mk
include ../../scripts/base_gcc_metadata.mk
include ../../scripts/base_newlib_metadata.mk

# Customization ID, which should identify the customization added to the original by SiFive
FREEDOM_GCC_METAL_ID := $(FREEDOM_GCC_ID)

# Characteristic tags, which should be usable for matching up providers and consumers
FREEDOM_GCC_METAL_RISCV_TAGS := $(FREEDOM_GCC_RISCV_TAGS)
FREEDOM_GCC_METAL_TOOLS_TAGS := $(FREEDOM_GCC_TAG_PREFIX)-metal
