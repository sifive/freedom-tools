
FREEDOM_GCC_METAL_GITURL := https://github.com/sifive/freedom-gcc-metal.git
FREEDOM_GCC_METAL_COMMIT := main

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_GCC_METAL_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_GCC_METAL := freedom-gcc-metal
SRCPATH_FREEDOM_GCC_METAL := $(SRCDIR)/$(SRCNAME_FREEDOM_GCC_METAL)

.PHONY: gcc-metal gcc-metal-package gcc-metal-regress gcc-metal-cleanup gcc-metal-flushup
gcc-metal: gcc-metal-package

.PHONY: gcc-only gcc-only-package gcc-only-regress
gcc-only-package: gcc-metal-package
gcc-only-regress: gcc-metal-regress
gcc-only: gcc-metal

$(SRCPATH_FREEDOM_GCC_METAL).$(FREEDOM_GCC_METAL_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_GCC_METAL)
	rm -rf $(SRCPATH_FREEDOM_GCC_METAL).*
	git clone $(FREEDOM_GCC_METAL_GITURL) $(SRCPATH_FREEDOM_GCC_METAL) --single-branch -b $(FREEDOM_GCC_METAL_COMMIT)
	cd $(SRCPATH_FREEDOM_GCC_METAL) && git submodule update --init --recursive
	date > $@

gcc-metal-package: \
		$(SRCPATH_FREEDOM_GCC_METAL).$(FREEDOM_GCC_METAL_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_GCC_METAL) package POSTFIXPATH=$(abspath $(POSTFIXPATH))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gcc-metal-regress: \
		$(SRCPATH_FREEDOM_GCC_METAL).$(FREEDOM_GCC_METAL_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_GCC_METAL) regress POSTFIXPATH=$(abspath $(POSTFIXPATH))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gcc-metal-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_GCC_METAL) cleanup POSTFIXPATH=$(abspath $(POSTFIXPATH))/
	rm -rf $(SRCPATH_FREEDOM_GCC_METAL).*
	rm -rf $(SRCPATH_FREEDOM_GCC_METAL)

gcc-metal-flushup:
	$(MAKE) -C $(SRCPATH_FREEDOM_GCC_METAL) flushup POSTFIXPATH=$(abspath $(POSTFIXPATH))/
