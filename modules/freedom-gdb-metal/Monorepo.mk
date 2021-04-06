.PHONY: gdb-metal gdb-metal-package gdb-metal-native-package gdb-metal-cross-package
.PHONY: gdb-metal-regress
.PHONY: gdb-metal-cleanup gdb-metal-native-cleanup gdb-metal-cross-cleanup
.PHONY: gdb-metal-flushup gdb-metal-native-flushup gdb-metal-cross-flushup
gdb-metal: gdb-metal-package

.PHONY: gdb-only gdb-only-package  gdb-only-native-package gdb-only-cross-package gdb-only-regress
gdb-only-package: gdb-metal-package
gdb-only-native-package: gdb-metal-native-package
gdb-only-cross-package: gdb-metal-cross-package
gdb-only-regress: gdb-metal-regress
gdb-only: gdb-metal

gdb-metal-package:
	$(MAKE) -C modules/freedom-gdb-metal package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gdb-metal-native-package:
	$(MAKE) -C modules/freedom-gdb-metal native-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gdb-metal-cross-package:
	$(MAKE) -C modules/freedom-gdb-metal cross-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gdb-metal-regress:
	$(MAKE) -C modules/freedom-gdb-metal regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gdb-metal-cleanup:
	$(MAKE) -C modules/freedom-gdb-metal cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

gdb-metal-native-cleanup:
	$(MAKE) -C modules/freedom-gdb-metal native-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

gdb-metal-cross-cleanup:
	$(MAKE) -C modules/freedom-gdb-metal cross-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

gdb-metal-flushup:
	$(MAKE) -C modules/freedom-gdb-metal flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

gdb-metal-native-flushup:
	$(MAKE) -C modules/freedom-gdb-metal native-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

gdb-metal-cross-flushup:
	$(MAKE) -C modules/freedom-gdb-metal cross-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
