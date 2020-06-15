
FREEDOM_GCC_METAL_GITURL := https://github.com/sifive/freedom-gcc-metal.git
FREEDOM_GCC_METAL_COMMIT := f367201c787730a7a60db3bd04d7daa6db404c17

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_GCC_METAL_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_GCC_METAL := freedom-gcc-metal
SRCPATH_FREEDOM_GCC_METAL := $(SRCDIR)/$(SRCNAME_FREEDOM_GCC_METAL)

.PHONY: gcc-metal gcc-metal-package gcc-metal-cleanup
gcc-metal: gcc-metal-package
gcc-only: gcc-metal-package

$(SRCPATH_FREEDOM_GCC_METAL).$(FREEDOM_GCC_METAL_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_GCC_METAL)
	rm -rf $(SRCPATH_FREEDOM_GCC_METAL).*
	git clone $(FREEDOM_GCC_METAL_GITURL) $(SRCPATH_FREEDOM_GCC_METAL)
	cd $(SRCPATH_FREEDOM_GCC_METAL) && git checkout --detach $(FREEDOM_GCC_METAL_COMMIT)
	cd $(SRCPATH_FREEDOM_GCC_METAL) && git submodule update --init --recursive
	date > $@

gcc-metal-package: \
		$(SRCPATH_FREEDOM_GCC_METAL).$(FREEDOM_GCC_METAL_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_GCC_METAL) package POSTFIXPATH=$(abspath .)/

gcc-metal-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_GCC_METAL) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_GCC_METAL).*
	rm -rf $(SRCPATH_FREEDOM_GCC_METAL)