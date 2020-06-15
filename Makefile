# Setup the Freedom build script environment
include scripts/Freedom.mk
include scripts/Package.mk

# The default target
.PHONY: all
all:
	@echo " Makefile targets: *-package *-regress *-cleanup clean help all"

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
	@echo " clean"
	@echo "   Remove the src, obj and bin directories."
	@echo ""
	@echo " help"
	@echo "   Show this help."
	@echo ""
	@echo " all"
	@echo "   Show Makefile targets."
	@echo ""
	@echo " * refers to an item from the package list"
	@echo "   binutils-metal  \\"
	@echo "   gcc-metal        > (aka toolchain)"
	@echo "   gdb-metal       /"
	@echo "   openocd"
	@echo "   qemu-system        (aka qemu)"
	@echo "   spike-dasm         (aka sdk-utilities)"
	@echo "   trace-decoder"
	@echo "   xc3sprog"
	@echo "   custom"
	@echo "     Requires that CUSTOM_GITURL is set."
	@echo ""
	@echo " CUSTOM_COMMIT can be set for a package to"
	@echo " override the one in freedom-*.mk files."
	@echo ""

# Include Makefiles for all modules (alphabetically)
include modules/freedom-binutils-metal.mk
include modules/freedom-gcc-metal.mk
include modules/freedom-gdb-metal.mk
include modules/freedom-openocd.mk
include modules/freedom-qemu-system.mk
include modules/freedom-spike-dasm.mk
include modules/freedom-trace-decoder.mk
include modules/freedom-xc3sprog.mk

.PHONY: toolchain toolchain-package toolchain-cleanup
toolchain: toolchain-package
toolchain-package: binutils-metal-package
toolchain-cleanup: binutils-metal-cleanup
toolchain-package: gcc-metal-package
toolchain-cleanup: gcc-metal-cleanup
toolchain-package: gdb-metal-package
toolchain-cleanup: gdb-metal-cleanup

.PHONY: non-toolchain non-toolchain-package non-toolchain-cleanup
non-toolchain: non-toolchain-package
non-toolchain-package: openocd-package
non-toolchain-cleanup: openocd-cleanup
non-toolchain-package: qemu-system-package
non-toolchain-cleanup: qemu-system-cleanup
non-toolchain-package: spike-dasm-package
non-toolchain-cleanup: spike-dasm-cleanup
non-toolchain-package: trace-decoder-package
non-toolchain-cleanup: trace-decoder-cleanup
non-toolchain-package: xc3sprog-package
non-toolchain-cleanup: xc3sprog-cleanup
