
FREEDOM_QEMU_GITURL := https://github.com/sifive/freedom-qemu.git
FREEDOM_QEMU_COMMIT := main

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_QEMU_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_QEMU := freedom-qemu
SRCPATH_FREEDOM_QEMU := $(SRCDIR)/$(SRCNAME_FREEDOM_QEMU)

.PHONY: qemu qemu-package qemu-regress qemu-cleanup qemu-flushup
qemu: qemu-package

$(SRCPATH_FREEDOM_QEMU).$(FREEDOM_QEMU_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_QEMU)
	rm -rf $(SRCPATH_FREEDOM_QEMU).*
	git clone $(FREEDOM_QEMU_GITURL) $(SRCPATH_FREEDOM_QEMU) --single-branch -b $(FREEDOM_QEMU_COMMIT)
	cd $(SRCPATH_FREEDOM_QEMU) && git submodule update --init --recursive
	date > $@

qemu-package: \
		$(SRCPATH_FREEDOM_QEMU).$(FREEDOM_QEMU_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_QEMU) package POSTFIXPATH=$(abspath $(POSTFIXPATH))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

qemu-regress: \
		$(SRCPATH_FREEDOM_QEMU).$(FREEDOM_QEMU_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_QEMU) regress POSTFIXPATH=$(abspath $(POSTFIXPATH))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

qemu-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_QEMU) cleanup POSTFIXPATH=$(abspath $(POSTFIXPATH))/
	rm -rf $(SRCPATH_FREEDOM_QEMU).*
	rm -rf $(SRCPATH_FREEDOM_QEMU)

qemu-flushup:
	$(MAKE) -C $(SRCPATH_FREEDOM_QEMU) flushup POSTFIXPATH=$(abspath $(POSTFIXPATH))/
