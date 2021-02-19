
FREEDOM_GDB_METAL_GITURL := git@github.com:sifive/freedom-gdb-metal.git
FREEDOM_GDB_METAL_BRANCH := main
FREEDOM_GDB_METAL_MODULE := $(SRCDIR)/freedom-gdb-metal

ifneq ($(TARGET_GITURL),)
FREEDOM_GDB_METAL_GITURL := $(TARGET_GITURL)
endif
ifneq ($(TARGET_BRANCH),)
FREEDOM_GDB_METAL_BRANCH := $(TARGET_BRANCH)
endif

ifneq ($(TOOLCHAIN_GDB_GITURL),)
FREEDOM_GDB_METAL_GITURL := $(TOOLCHAIN_GDB_GITURL)
endif
ifneq ($(TOOLCHAIN_GDB_BRANCH),)
FREEDOM_GDB_METAL_BRANCH := $(TOOLCHAIN_GDB_BRANCH)
endif

.PHONY: gdb-metal gdb-metal-package gdb-metal-regress gdb-metal-cleanup gdb-metal-flushup
gdb-metal: gdb-metal-package

.PHONY: gdb-only gdb-only-package gdb-only-regress
gdb-only-package: gdb-metal-package
gdb-only-regress: gdb-metal-regress
gdb-only: gdb-metal

$(FREEDOM_GDB_METAL_MODULE).$(FREEDOM_GDB_METAL_BRANCH):
	mkdir -p $(dir $@)
	rm -rf $(FREEDOM_GDB_METAL_MODULE)
	rm -rf $(FREEDOM_GDB_METAL_MODULE).*
	git clone $(FREEDOM_GDB_METAL_GITURL) $(FREEDOM_GDB_METAL_MODULE) --single-branch -b $(FREEDOM_GDB_METAL_BRANCH)
	cd $(FREEDOM_GDB_METAL_MODULE) && git submodule update --init --recursive
	date > $@

gdb-metal-package: \
		$(FREEDOM_GDB_METAL_MODULE).$(FREEDOM_GDB_METAL_BRANCH)
	$(MAKE) -C $(FREEDOM_GDB_METAL_MODULE) package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gdb-metal-regress: \
		$(FREEDOM_GDB_METAL_MODULE).$(FREEDOM_GDB_METAL_BRANCH)
	$(MAKE) -C $(FREEDOM_GDB_METAL_MODULE) regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

gdb-metal-cleanup:
	$(MAKE) -C $(FREEDOM_GDB_METAL_MODULE) cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	rm -rf $(FREEDOM_GDB_METAL_MODULE).*
	rm -rf $(FREEDOM_GDB_METAL_MODULE)

gdb-metal-flushup:
	$(MAKE) -C $(FREEDOM_GDB_METAL_MODULE) flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
