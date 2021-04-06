.PHONY: binutils-metal binutils-metal-package binutils-metal-native-package binutils-metal-cross-package
.PHONY: binutils-metal-regress
.PHONY: binutils-metal-cleanup binutils-metal-native-cleanup binutils-metal-cross-cleanup
.PHONY: binutils-metal-flushup binutils-metal-native-flushup binutils-metal-cross-flushup
binutils-metal: binutils-metal-package

.PHONY: binutils-only binutils-only-package  binutils-only-native-package binutils-only-cross-package binutils-only-regress
binutils-only-package: binutils-metal-package
binutils-only-native-package: binutils-metal-native-package
binutils-only-cross-package: binutils-metal-cross-package
binutils-only-regress: binutils-metal-regress
binutils-only: binutils-metal

binutils-metal-package:
	$(MAKE) -C modules/freedom-binutils-metal package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

binutils-metal-native-package:
	$(MAKE) -C modules/freedom-binutils-metal native-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

binutils-metal-cross-package:
	$(MAKE) -C modules/freedom-binutils-metal cross-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

binutils-metal-regress:
	$(MAKE) -C modules/freedom-binutils-metal regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

binutils-metal-cleanup:
	$(MAKE) -C modules/freedom-binutils-metal cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

binutils-metal-native-cleanup:
	$(MAKE) -C modules/freedom-binutils-metal native-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

binutils-metal-cross-cleanup:
	$(MAKE) -C modules/freedom-binutils-metal cross-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

binutils-metal-flushup:
	$(MAKE) -C modules/freedom-binutils-metal flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

binutils-metal-native-flushup:
	$(MAKE) -C modules/freedom-binutils-metal native-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

binutils-metal-cross-flushup:
	$(MAKE) -C modules/freedom-binutils-metal cross-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
