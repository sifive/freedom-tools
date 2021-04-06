.PHONY: xc3sprog xc3sprog-package xc3sprog-native-package xc3sprog-cross-package
.PHONY: xc3sprog-regress
.PHONY: xc3sprog-cleanup xc3sprog-native-cleanup xc3sprog-cross-cleanup
.PHONY: xc3sprog-flushup xc3sprog-native-flushup xc3sprog-cross-flushup
xc3sprog: xc3sprog-package

xc3sprog-package:
	$(MAKE) -C modules/freedom-xc3sprog package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

xc3sprog-native-package:
	$(MAKE) -C modules/freedom-xc3sprog native-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

xc3sprog-cross-package:
	$(MAKE) -C modules/freedom-xc3sprog cross-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

xc3sprog-regress:
	$(MAKE) -C modules/freedom-xc3sprog regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

xc3sprog-cleanup:
	$(MAKE) -C modules/freedom-xc3sprog cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

xc3sprog-native-cleanup:
	$(MAKE) -C modules/freedom-xc3sprog native-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

xc3sprog-cross-cleanup:
	$(MAKE) -C modules/freedom-xc3sprog cross-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

xc3sprog-flushup:
	$(MAKE) -C modules/freedom-xc3sprog flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

xc3sprog-native-flushup:
	$(MAKE) -C modules/freedom-xc3sprog native-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

xc3sprog-cross-flushup:
	$(MAKE) -C modules/freedom-xc3sprog cross-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
