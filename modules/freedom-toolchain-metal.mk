
FREEDOM_TOOLCHAIN_METAL_GITURL := https://github.com/sifive/freedom-toolchain-metal.git
FREEDOM_TOOLCHAIN_METAL_COMMIT := main

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_TOOLCHAIN_METAL_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_TOOLCHAIN_METAL := freedom-toolchain-metal
SRCPATH_FREEDOM_TOOLCHAIN_METAL := $(SRCDIR)/$(SRCNAME_FREEDOM_TOOLCHAIN_METAL)

.PHONY: toolchain-metal toolchain-metal-package toolchain-metal-regress toolchain-metal-cleanup toolchain-metal-flushup
toolchain-metal: toolchain-metal-package

.PHONY: toolchain toolchain-package toolchain-regress
toolchain-package: toolchain-package
toolchain-regress: toolchain-regress
toolchain: toolchain

$(SRCPATH_FREEDOM_TOOLCHAIN_METAL).$(FREEDOM_TOOLCHAIN_METAL_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_TOOLCHAIN_METAL)
	rm -rf $(SRCPATH_FREEDOM_TOOLCHAIN_METAL).*
	git clone $(FREEDOM_TOOLCHAIN_METAL_GITURL) $(SRCPATH_FREEDOM_TOOLCHAIN_METAL)
	cd $(SRCPATH_FREEDOM_TOOLCHAIN_METAL) && git checkout --detach $(FREEDOM_TOOLCHAIN_METAL_COMMIT)
	cd $(SRCPATH_FREEDOM_TOOLCHAIN_METAL) && git submodule update --init --recursive
	date > $@

toolchain-metal-package: \
		$(SRCPATH_FREEDOM_TOOLCHAIN_METAL).$(FREEDOM_TOOLCHAIN_METAL_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_TOOLCHAIN_METAL) package POSTFIXPATH=$(abspath $(POSTFIXPATH))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

toolchain-metal-regress: \
		$(SRCPATH_FREEDOM_TOOLCHAIN_METAL).$(FREEDOM_TOOLCHAIN_METAL_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_TOOLCHAIN_METAL) regress POSTFIXPATH=$(abspath $(POSTFIXPATH))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

toolchain-metal-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_TOOLCHAIN_METAL) cleanup POSTFIXPATH=$(abspath $(POSTFIXPATH))/
	rm -rf $(SRCPATH_FREEDOM_TOOLCHAIN_METAL).*
	rm -rf $(SRCPATH_FREEDOM_TOOLCHAIN_METAL)

toolchain-metal-flushup:
	$(MAKE) -C $(SRCPATH_FREEDOM_TOOLCHAIN_METAL) flushup POSTFIXPATH=$(abspath $(POSTFIXPATH))/
