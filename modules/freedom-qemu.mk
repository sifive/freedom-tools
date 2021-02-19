
FREEDOM_QEMU_GITURL := git@github.com:sifive/freedom-qemu.git
FREEDOM_QEMU_BRANCH := main
FREEDOM_QEMU_MODULE := $(SRCDIR)/freedom-qemu

ifneq ($(TARGET_GITURL),)
FREEDOM_QEMU_GITURL := $(TARGET_GITURL)
endif
ifneq ($(TARGET_BRANCH),)
FREEDOM_QEMU_BRANCH := $(TARGET_BRANCH)
endif

.PHONY: qemu qemu-package qemu-regress qemu-cleanup qemu-flushup
qemu: qemu-package

$(FREEDOM_QEMU_MODULE).$(FREEDOM_QEMU_BRANCH):
	mkdir -p $(dir $@)
	rm -rf $(FREEDOM_QEMU_MODULE)
	rm -rf $(FREEDOM_QEMU_MODULE).*
	git clone $(FREEDOM_QEMU_GITURL) $(FREEDOM_QEMU_MODULE) --single-branch -b $(FREEDOM_QEMU_BRANCH)
	cd $(FREEDOM_QEMU_MODULE) && git submodule update --init --recursive
	date > $@

qemu-package: \
		$(FREEDOM_QEMU_MODULE).$(FREEDOM_QEMU_BRANCH)
	$(MAKE) -C $(FREEDOM_QEMU_MODULE) package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

qemu-regress: \
		$(FREEDOM_QEMU_MODULE).$(FREEDOM_QEMU_BRANCH)
	$(MAKE) -C $(FREEDOM_QEMU_MODULE) regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

qemu-cleanup:
	$(MAKE) -C $(FREEDOM_QEMU_MODULE) cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	rm -rf $(FREEDOM_QEMU_MODULE).*
	rm -rf $(FREEDOM_QEMU_MODULE)

qemu-flushup:
	$(MAKE) -C $(FREEDOM_QEMU_MODULE) flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
