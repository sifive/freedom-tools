# Setup the Freedom build script environment
include scripts/Freedom.mk
include scripts/Package.mk

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
