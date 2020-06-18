
FREEDOM_BINUTILS_METAL_GITURL := https://github.com/sifive/freedom-binutils-metal.git
FREEDOM_BINUTILS_METAL_COMMIT := 619cb471f6afcdd671a5f2fcf919a6d208863656

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_BINUTILS_METAL_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_BINUTILS_METAL := freedom-binutils-metal
SRCPATH_FREEDOM_BINUTILS_METAL := $(SRCDIR)/$(SRCNAME_FREEDOM_BINUTILS_METAL)

.PHONY: binutils-metal binutils-metal-package binutils-metal-regress binutils-metal-cleanup binutils-metal-flushup
binutils-metal: binutils-metal-package

.PHONY: binutils-only binutils-only-package binutils-only-regress
binutils-only-package: binutils-metal-package
binutils-only-regress: binutils-metal-regress
binutils-only: binutils-metal

$(SRCPATH_FREEDOM_BINUTILS_METAL).$(FREEDOM_BINUTILS_METAL_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_BINUTILS_METAL)
	rm -rf $(SRCPATH_FREEDOM_BINUTILS_METAL).*
	git clone $(FREEDOM_BINUTILS_METAL_GITURL) $(SRCPATH_FREEDOM_BINUTILS_METAL)
	cd $(SRCPATH_FREEDOM_BINUTILS_METAL) && git checkout --detach $(FREEDOM_BINUTILS_METAL_COMMIT)
	cd $(SRCPATH_FREEDOM_BINUTILS_METAL) && git submodule update --init --recursive
	date > $@

binutils-metal-package: \
		$(SRCPATH_FREEDOM_BINUTILS_METAL).$(FREEDOM_BINUTILS_METAL_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_BINUTILS_METAL) package POSTFIXPATH=$(abspath .)/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

binutils-metal-regress: \
		$(SRCPATH_FREEDOM_BINUTILS_METAL).$(FREEDOM_BINUTILS_METAL_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_BINUTILS_METAL) regress POSTFIXPATH=$(abspath .)/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

binutils-metal-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_BINUTILS_METAL) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_BINUTILS_METAL).*
	rm -rf $(SRCPATH_FREEDOM_BINUTILS_METAL)

binutils-metal-flushup:
	$(MAKE) -C $(SRCPATH_FREEDOM_BINUTILS_METAL) flushup POSTFIXPATH=$(abspath .)/
