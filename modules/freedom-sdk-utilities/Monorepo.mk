.PHONY: sdk-utilities sdk-utilities-package sdk-utilities-native-package sdk-utilities-cross-package
.PHONY: sdk-utilities-regress
.PHONY: sdk-utilities-cleanup sdk-utilities-native-cleanup sdk-utilities-cross-cleanup
.PHONY: sdk-utilities-flushup sdk-utilities-native-flushup sdk-utilities-cross-flushup
sdk-utilities: sdk-utilities-package

sdk-utilities-package:
	$(MAKE) -C modules/freedom-sdk-utilities package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

sdk-utilities-native-package:
	$(MAKE) -C modules/freedom-sdk-utilities native-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

sdk-utilities-cross-package:
	$(MAKE) -C modules/freedom-sdk-utilities cross-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

sdk-utilities-regress:
	$(MAKE) -C modules/freedom-sdk-utilities regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

sdk-utilities-cleanup:
	$(MAKE) -C modules/freedom-sdk-utilities cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

sdk-utilities-native-cleanup:
	$(MAKE) -C modules/freedom-sdk-utilities native-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

sdk-utilities-cross-cleanup:
	$(MAKE) -C modules/freedom-sdk-utilities cross-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

sdk-utilities-flushup:
	$(MAKE) -C modules/freedom-sdk-utilities flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

sdk-utilities-native-flushup:
	$(MAKE) -C modules/freedom-sdk-utilities native-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

sdk-utilities-cross-flushup:
	$(MAKE) -C modules/freedom-sdk-utilities cross-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
