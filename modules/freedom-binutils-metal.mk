
FREEDOM_BINUTILS_METAL_GITURL := https://github.com/sifive/freedom-binutils-metal.git
FREEDOM_BINUTILS_METAL_COMMIT := 06104120025f13a4bd42ed78ebb36aa07469af4d

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_BINUTILS_METAL_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_BINUTILS_METAL := freedom-binutils-metal
SRCPATH_FREEDOM_BINUTILS_METAL := $(SRCDIR)/$(SRCNAME_FREEDOM_BINUTILS_METAL)

.PHONY: binutils-metal binutils-metal-package binutils-metal-cleanup
binutils-metal: binutils-metal-package
binutils-only: binutils-metal-package

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
	$(MAKE) -C $(SRCPATH_FREEDOM_BINUTILS_METAL) package POSTFIXPATH=$(abspath .)/

binutils-metal-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_BINUTILS_METAL) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_BINUTILS_METAL).*
	rm -rf $(SRCPATH_FREEDOM_BINUTILS_METAL)
