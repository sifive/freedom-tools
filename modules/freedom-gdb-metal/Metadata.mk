include ../../scripts/base_gdb_metadata.mk

# Customization ID, which should identify the customization added to the original by SiFive
FREEDOM_GDB_METAL_ID := $(FREEDOM_GDB_ID)

# Characteristic tags, which should be usable for matching up providers and consumers
FREEDOM_GDB_METAL_RISCV_TAGS := $(FREEDOM_GDB_RISCV_TAGS)
FREEDOM_GDB_METAL_TOOLS_TAGS := $(FREEDOM_GDB_TAG_PREFIX)-metal
