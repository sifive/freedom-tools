.PHONY: trace-decoder trace-decoder-package trace-decoder-native-package trace-decoder-cross-package
.PHONY: trace-decoder-regress
.PHONY: trace-decoder-cleanup trace-decoder-native-cleanup trace-decoder-cross-cleanup
.PHONY: trace-decoder-flushup trace-decoder-native-flushup trace-decoder-cross-flushup
trace-decoder: trace-decoder-package

trace-decoder-package:
	$(MAKE) -C modules/freedom-trace-decoder package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

trace-decoder-native-package:
	$(MAKE) -C modules/freedom-trace-decoder native-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

trace-decoder-cross-package:
	$(MAKE) -C modules/freedom-trace-decoder cross-package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

trace-decoder-regress:
	$(MAKE) -C modules/freedom-trace-decoder regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

trace-decoder-cleanup:
	$(MAKE) -C modules/freedom-trace-decoder cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

trace-decoder-native-cleanup:
	$(MAKE) -C modules/freedom-trace-decoder native-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

trace-decoder-cross-cleanup:
	$(MAKE) -C modules/freedom-trace-decoder cross-cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

trace-decoder-flushup:
	$(MAKE) -C modules/freedom-trace-decoder flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

trace-decoder-native-flushup:
	$(MAKE) -C modules/freedom-trace-decoder native-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/

trace-decoder-cross-flushup:
	$(MAKE) -C modules/freedom-trace-decoder cross-flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
