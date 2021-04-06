.PHONY: gcc-metal gcc-metal-package gcc-metal-native-package gcc-metal-cross-package
.PHONY: gcc-metal-regress
.PHONY: gcc-metal-cleanup gcc-metal-native-cleanup gcc-metal-cross-cleanup
.PHONY: gcc-metal-flushup gcc-metal-native-flushup gcc-metal-cross-flushup
gcc-metal: gcc-metal-package

.PHONY: gcc-only gcc-only-package  gcc-only-native-package gcc-only-cross-package gcc-only-regress
gcc-only-package: gcc-metal-package
gcc-only-native-package: gcc-metal-native-package
gcc-only-cross-package: gcc-metal-cross-package
gcc-only-regress: gcc-metal-regress
gcc-only: gcc-metal

gcc-metal-package:
	$(MAKE) -C modules/freedom-gcc-metal package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gcc-metal-native-package:
	$(MAKE) -C modules/freedom-gcc-metal native-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gcc-metal-cross-package:
	$(MAKE) -C modules/freedom-gcc-metal cross-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gcc-metal-regress:
	$(MAKE) -C modules/freedom-gcc-metal regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gcc-metal-cleanup:
	$(MAKE) -C modules/freedom-gcc-metal cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

gcc-metal-native-cleanup:
	$(MAKE) -C modules/freedom-gcc-metal native-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

gcc-metal-cross-cleanup:
	$(MAKE) -C modules/freedom-gcc-metal cross-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

gcc-metal-flushup:
	$(MAKE) -C modules/freedom-gcc-metal flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

gcc-metal-native-flushup:
	$(MAKE) -C modules/freedom-gcc-metal native-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

gcc-metal-cross-flushup:
	$(MAKE) -C modules/freedom-gcc-metal cross-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
