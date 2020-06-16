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
	@echo "   binutils-metal  \\"
	@echo "   gcc-metal        > (aka toolchain)"
	@echo "   gdb-metal       /"
	@echo "   openocd"
	@echo "   qemu-target        (aka qemu)"
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
include modules/freedom-qemu-target.mk
include modules/freedom-spike-dasm.mk
include modules/freedom-trace-decoder.mk
include modules/freedom-xc3sprog.mk

.PHONY: toolchain toolchain-package toolchain-regress toolchain-cleanup toolchain-flushup
toolchain: toolchain-package
toolchain-package: binutils-metal-package
toolchain-regress: binutils-metal-regress
toolchain-cleanup: binutils-metal-cleanup
toolchain-flushup: binutils-metal-flushup
toolchain-package: gcc-metal-package
toolchain-regress: gcc-metal-regress
toolchain-cleanup: gcc-metal-cleanup
toolchain-flushup: gcc-metal-flushup
toolchain-package: gdb-metal-package
toolchain-regress: gdb-metal-regress
toolchain-cleanup: gdb-metal-cleanup
toolchain-flushup: gdb-metal-flushup

.PHONY: non-toolchain non-toolchain-package non-toolchain-regress non-toolchain-cleanup non-toolchain-flushup
non-toolchain: non-toolchain-package
non-toolchain-package: openocd-package
non-toolchain-regress: openocd-regress
non-toolchain-cleanup: openocd-cleanup
non-toolchain-flushup: openocd-flushup
non-toolchain-package: qemu-target-package
non-toolchain-regress: qemu-target-regress
non-toolchain-cleanup: qemu-target-cleanup
non-toolchain-flushup: qemu-target-flushup
non-toolchain-package: spike-dasm-package
non-toolchain-regress: spike-dasm-regress
non-toolchain-cleanup: spike-dasm-cleanup
non-toolchain-flushup: spike-dasm-flushup
non-toolchain-package: trace-decoder-package
non-toolchain-regress: trace-decoder-regress
non-toolchain-cleanup: trace-decoder-cleanup
non-toolchain-flushup: trace-decoder-flushup
non-toolchain-package: xc3sprog-package
non-toolchain-regress: xc3sprog-regress
non-toolchain-cleanup: xc3sprog-cleanup
non-toolchain-flushup: xc3sprog-flushup
