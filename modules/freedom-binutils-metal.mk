
FREEDOM_BINUTILS_METAL_GITURL := git@github.com:sifive/freedom-binutils-metal.git
FREEDOM_BINUTILS_METAL_BRANCH := main
FREEDOM_BINUTILS_METAL_MODULE := $(SRCDIR)/freedom-binutils-metal

ifneq ($(TARGET_GITURL),)
FREEDOM_BINUTILS_METAL_GITURL := $(TARGET_GITURL)
endif
ifneq ($(TARGET_BRANCH),)
FREEDOM_BINUTILS_METAL_BRANCH := $(TARGET_BRANCH)
endif

ifneq ($(TOOLCHAIN_BINUTILS_GITURL),)
FREEDOM_BINUTILS_METAL_GITURL := $(TOOLCHAIN_BINUTILS_GITURL)
endif
ifneq ($(TOOLCHAIN_BINUTILS_BRANCH),)
FREEDOM_BINUTILS_METAL_BRANCH := $(TOOLCHAIN_BINUTILS_BRANCH)
endif

.PHONY: binutils-metal binutils-metal-package binutils-metal-regress binutils-metal-cleanup binutils-metal-flushup
binutils-metal: binutils-metal-package

.PHONY: binutils-only binutils-only-package binutils-only-regress
binutils-only-package: binutils-metal-package
binutils-only-regress: binutils-metal-regress
binutils-only: binutils-metal

$(FREEDOM_BINUTILS_METAL_MODULE).$(FREEDOM_BINUTILS_METAL_BRANCH):
	mkdir -p $(dir $@)
	rm -rf $(FREEDOM_BINUTILS_METAL_MODULE)
	rm -rf $(FREEDOM_BINUTILS_METAL_MODULE).*
	git clone $(FREEDOM_BINUTILS_METAL_GITURL) $(FREEDOM_BINUTILS_METAL_MODULE) --single-branch -b $(FREEDOM_BINUTILS_METAL_BRANCH)
	cd $(FREEDOM_BINUTILS_METAL_MODULE) && git submodule update --init --recursive
	date > $@

binutils-metal-package: \
		$(FREEDOM_BINUTILS_METAL_MODULE).$(FREEDOM_BINUTILS_METAL_BRANCH)
	$(MAKE) -C $(FREEDOM_BINUTILS_METAL_MODULE) package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

binutils-metal-regress: \
		$(FREEDOM_BINUTILS_METAL_MODULE).$(FREEDOM_BINUTILS_METAL_BRANCH)
	$(MAKE) -C $(FREEDOM_BINUTILS_METAL_MODULE) regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

binutils-metal-cleanup:
	$(MAKE) -C $(FREEDOM_BINUTILS_METAL_MODULE) cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	rm -rf $(FREEDOM_BINUTILS_METAL_MODULE).*
	rm -rf $(FREEDOM_BINUTILS_METAL_MODULE)

binutils-metal-flushup:
	$(MAKE) -C $(FREEDOM_BINUTILS_METAL_MODULE) flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
