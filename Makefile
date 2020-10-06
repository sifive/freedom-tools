# Setup the Freedom build script environment
include scripts/Freedom.mk
include scripts/Package.mk

# The default target
.PHONY: all
all:
	@echo " Makefile targets: *-package *-regress *-cleanup *-flushup clean flush help all"

.PHONY: help
help:
	@echo ""
	@echo " SiFive Freedom Tools - Makefile targets:"
	@echo ""
	@echo " *-package"
	@echo "   Build the binary packages for * repo."
	@echo ""
	@echo " *-regress"
	@echo "   Test the prebuilt packages for * repo."
	@echo ""
	@echo " *-cleanup"
	@echo "   Clean the build artifacts for * repo."
	@echo ""
	@echo " *-flushup"
	@echo "   Flush the build artifacts for * repo."
	@echo ""
	@echo " clean"
	@echo "   Remove the src, obj and bin directories."
	@echo ""
	@echo " flush"
	@echo "   Remove the obj directory."
	@echo ""
	@echo " help"
	@echo "   Show this help."
	@echo ""
	@echo " all"
	@echo "   Show Makefile targets."
	@echo ""
	@echo " * refers to an item from the package list"
	@echo "   toolchain-metal"
	@echo "   binutils-metal"
	@echo "   gcc-metal"
	@echo "   gdb-metal"
	@echo "   llvm-linux"
	@echo "   qemu"
	@echo "   sdk-utilities"
	@echo "   openocd"
	@echo "   trace-decoder"
	@echo "   xc3sprog"
	@echo "   devtool-machine"
	@echo "   devtool-image"
	@echo "   custom"
	@echo "     Requires that CUSTOM_GITURL is set."
	@echo ""
	@echo " CUSTOM_COMMIT can be set for a package to"
	@echo " override the one in freedom-*.mk files."
	@echo ""

# Include Makefiles for all modules (alphabetically)
include modules/freedom-toolchain-metal.mk
include modules/freedom-binutils-metal.mk
include modules/freedom-gcc-metal.mk
include modules/freedom-gdb-metal.mk
include modules/freedom-qemu.mk
include modules/freedom-llvm-linux.mk
include modules/freedom-sdk-utilities.mk
include modules/freedom-openocd.mk
include modules/freedom-trace-decoder.mk
include modules/freedom-xc3sprog.mk
include modules/freedom-devtool-machine.mk
include modules/freedom-devtool-image.mk
