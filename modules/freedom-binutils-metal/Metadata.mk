include ../../scripts/base_binutils_metadata.mk

# Customization ID, which should identify the customization added to the original by SiFive
FREEDOM_BINUTILS_METAL_ID := $(FREEDOM_BINUTILS_ID)

# Characteristic tags, which should be usable for matching up providers and consumers
FREEDOM_BINUTILS_METAL_RISCV_TAGS := $(FREEDOM_BINUTILS_RISCV_TAGS)
FREEDOM_BINUTILS_METAL_TOOLS_TAGS := $(FREEDOM_BINUTILS_TAG_PREFIX)-metal
