.PHONY: qemu qemu-package qemu-native-package qemu-cross-package
.PHONY: qemu-regress
.PHONY: qemu-cleanup qemu-native-cleanup qemu-cross-cleanup
.PHONY: qemu-flushup qemu-native-flushup qemu-cross-flushup
qemu: qemu-package

qemu-package:
	$(MAKE) -C modules/freedom-qemu package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

qemu-native-package:
	$(MAKE) -C modules/freedom-qemu native-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

qemu-cross-package:
	$(MAKE) -C modules/freedom-qemu cross-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

qemu-regress:
	$(MAKE) -C modules/freedom-qemu regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

qemu-cleanup:
	$(MAKE) -C modules/freedom-qemu cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

qemu-native-cleanup:
	$(MAKE) -C modules/freedom-qemu native-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

qemu-cross-cleanup:
	$(MAKE) -C modules/freedom-qemu cross-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

qemu-flushup:
	$(MAKE) -C modules/freedom-qemu flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

qemu-native-flushup:
	$(MAKE) -C modules/freedom-qemu native-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

qemu-cross-flushup:
	$(MAKE) -C modules/freedom-qemu cross-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
