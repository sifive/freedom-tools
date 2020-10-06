
FREEDOM_LLVM_LINUX_GITURL := https://github.com/sifive/freedom-llvm-linux.git
FREEDOM_LLVM_LINUX_COMMIT := 450de694d4fb94d94d45241e3f2d90e8f161aca8

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_LLVM_LINUX_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_LLVM_LINUX := freedom-llvm-linux
SRCPATH_FREEDOM_LLVM_LINUX := $(SRCDIR)/$(SRCNAME_FREEDOM_LLVM_LINUX)

.PHONY: llvm-linux llvm-linux-package llvm-linux-regress llvm-linux-cleanup llvm-linux-flushup
llvm-linux: llvm-linux-package

$(SRCPATH_FREEDOM_LLVM_LINUX).$(FREEDOM_LLVM_LINUX_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_LLVM_LINUX)
	rm -rf $(SRCPATH_FREEDOM_LLVM_LINUX).*
	git clone $(FREEDOM_LLVM_LINUX_GITURL) $(SRCPATH_FREEDOM_LLVM_LINUX)
	cd $(SRCPATH_FREEDOM_LLVM_LINUX) && git checkout --detach $(FREEDOM_LLVM_LINUX_COMMIT)
	cd $(SRCPATH_FREEDOM_LLVM_LINUX) && git submodule update --init --recursive
	date > $@

llvm-linux-package: \
		$(SRCPATH_FREEDOM_LLVM_LINUX).$(FREEDOM_LLVM_LINUX_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_LLVM_LINUX) package POSTFIXPATH=$(abspath .)/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

llvm-linux-regress: \
		$(SRCPATH_FREEDOM_LLVM_LINUX).$(FREEDOM_LLVM_LINUX_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_LLVM_LINUX) regress POSTFIXPATH=$(abspath .)/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

llvm-linux-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_LLVM_LINUX) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_LLVM_LINUX).*
	rm -rf $(SRCPATH_FREEDOM_LLVM_LINUX)

llvm-linux-flushup:
	$(MAKE) -C $(SRCPATH_FREEDOM_LLVM_LINUX) flushup POSTFIXPATH=$(abspath .)/
