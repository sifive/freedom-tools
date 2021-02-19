
FREEDOM_GCC_METAL_GITURL := git@github.com:sifive/freedom-gcc-metal.git
FREEDOM_GCC_METAL_BRANCH := main
FREEDOM_GCC_METAL_MODULE := $(SRCDIR)/freedom-gcc-metal

ifneq ($(TARGET_GITURL),)
FREEDOM_GCC_METAL_GITURL := $(TARGET_GITURL)
endif
ifneq ($(TARGET_BRANCH),)
FREEDOM_GCC_METAL_BRANCH := $(TARGET_BRANCH)
endif

ifneq ($(TOOLCHAIN_GCC_GITURL),)
FREEDOM_GCC_METAL_GITURL := $(TOOLCHAIN_GCC_GITURL)
endif
ifneq ($(TOOLCHAIN_GCC_BRANCH),)
FREEDOM_GCC_METAL_BRANCH := $(TOOLCHAIN_GCC_BRANCH)
endif

.PHONY: gcc-metal gcc-metal-package gcc-metal-regress gcc-metal-cleanup gcc-metal-flushup
gcc-metal: gcc-metal-package

.PHONY: gcc-only gcc-only-package gcc-only-regress
gcc-only-package: gcc-metal-package
gcc-only-regress: gcc-metal-regress
gcc-only: gcc-metal

$(FREEDOM_GCC_METAL_MODULE).$(FREEDOM_GCC_METAL_BRANCH):
	mkdir -p $(dir $@)
	rm -rf $(FREEDOM_GCC_METAL_MODULE)
	rm -rf $(FREEDOM_GCC_METAL_MODULE).*
	git clone $(FREEDOM_GCC_METAL_GITURL) $(FREEDOM_GCC_METAL_MODULE) --single-branch -b $(FREEDOM_GCC_METAL_BRANCH)
	cd $(FREEDOM_GCC_METAL_MODULE) && git submodule update --init --recursive
	date > $@

gcc-metal-package: \
		$(FREEDOM_GCC_METAL_MODULE).$(FREEDOM_GCC_METAL_BRANCH)
	$(MAKE) -C $(FREEDOM_GCC_METAL_MODULE) package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gcc-metal-regress: \
		$(FREEDOM_GCC_METAL_MODULE).$(FREEDOM_GCC_METAL_BRANCH)
	$(MAKE) -C $(FREEDOM_GCC_METAL_MODULE) regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gcc-metal-cleanup:
	$(MAKE) -C $(FREEDOM_GCC_METAL_MODULE) cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	rm -rf $(FREEDOM_GCC_METAL_MODULE).*
	rm -rf $(FREEDOM_GCC_METAL_MODULE)

gcc-metal-flushup:
	$(MAKE) -C $(FREEDOM_GCC_METAL_MODULE) flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
