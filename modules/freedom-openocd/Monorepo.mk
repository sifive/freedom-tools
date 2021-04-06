.PHONY: openocd openocd-package openocd-native-package openocd-cross-package
.PHONY: openocd-regress
.PHONY: openocd-cleanup openocd-native-cleanup openocd-cross-cleanup
.PHONY: openocd-flushup openocd-native-flushup openocd-cross-flushup
openocd: openocd-package

openocd-package:
	$(MAKE) -C modules/freedom-openocd package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

openocd-native-package:
	$(MAKE) -C modules/freedom-openocd native-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

openocd-cross-package:
	$(MAKE) -C modules/freedom-openocd cross-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

openocd-regress:
	$(MAKE) -C modules/freedom-openocd regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

openocd-cleanup:
	$(MAKE) -C modules/freedom-openocd cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

openocd-native-cleanup:
	$(MAKE) -C modules/freedom-openocd native-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

openocd-cross-cleanup:
	$(MAKE) -C modules/freedom-openocd cross-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

openocd-flushup:
	$(MAKE) -C modules/freedom-openocd flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

openocd-native-flushup:
	$(MAKE) -C modules/freedom-openocd native-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

openocd-cross-flushup:
	$(MAKE) -C modules/freedom-openocd cross-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
