.PHONY: toolchain-metal toolchain-metal-package toolchain-metal-native-package toolchain-metal-cross-package
.PHONY: toolchain-metal-regress
.PHONY: toolchain-metal-cleanup toolchain-metal-native-cleanup toolchain-metal-cross-cleanup
.PHONY: toolchain-metal-flushup toolchain-metal-native-flushup toolchain-metal-cross-flushup
toolchain-metal: toolchain-metal-package

.PHONY: toolchain toolchain-package  toolchain-native-package toolchain-cross-package toolchain-regress
toolchain-package: toolchain-metal-package
toolchain-native-package: toolchain-metal-native-package
toolchain-cross-package: toolchain-metal-cross-package
toolchain-regress: toolchain-metal-regress
toolchain: toolchain-metal

toolchain-metal-package:
	$(MAKE) -C modules/freedom-binutils-metal package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)
	$(MAKE) -C modules/freedom-gcc-metal package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)
	$(MAKE) -C modules/freedom-gdb-metal package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)
	$(MAKE) -C modules/freedom-toolchain-metal package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

toolchain-metal-native-package:
	$(MAKE) -C modules/freedom-binutils-metal native-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)
	$(MAKE) -C modules/freedom-gcc-metal native-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)
	$(MAKE) -C modules/freedom-gdb-metal native-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)
	$(MAKE) -C modules/freedom-toolchain-metal native-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

toolchain-metal-cross-package:
	$(MAKE) -C modules/freedom-binutils-metal cross-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)
	$(MAKE) -C modules/freedom-gcc-metal cross-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)
	$(MAKE) -C modules/freedom-gdb-metal cross-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)
	$(MAKE) -C modules/freedom-toolchain-metal cross-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

toolchain-metal-regress:
	$(MAKE) -C modules/freedom-binutils-metal regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)
	$(MAKE) -C modules/freedom-gcc-metal regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)
	$(MAKE) -C modules/freedom-gdb-metal regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)
	$(MAKE) -C modules/freedom-toolchain-metal regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

toolchain-metal-cleanup:
	$(MAKE) -C modules/freedom-binutils-metal cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-gcc-metal cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-gdb-metal cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-toolchain-metal cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

toolchain-metal-native-cleanup:
	$(MAKE) -C modules/freedom-binutils-metal native-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-gcc-metal native-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-gdb-metal native-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-toolchain-metal native-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

toolchain-metal-cross-cleanup:
	$(MAKE) -C modules/freedom-binutils-metal cross-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-gcc-metal cross-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-gdb-metal cross-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-toolchain-metal cross-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

toolchain-metal-flushup:
	$(MAKE) -C modules/freedom-binutils-metal flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-gcc-metal flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-gdb-metal flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-toolchain-metal flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

toolchain-metal-native-flushup:
	$(MAKE) -C modules/freedom-binutils-metal native-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-gcc-metal native-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-gdb-metal native-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-toolchain-metal native-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

toolchain-metal-cross-flushup:
	$(MAKE) -C modules/freedom-binutils-metal cross-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-gcc-metal cross-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-gdb-metal cross-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	$(MAKE) -C modules/freedom-toolchain-metal cross-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
