
FREEDOM_QEMU_HOST_GITURL := https://github.com/sifive/freedom-qemu-host.git
FREEDOM_QEMU_HOST_COMMIT := e079389277cd1e74c382ea85d2dfac52c210d3f7

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_QEMU_HOST_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_QEMU_HOST := freedom-qemu-host
SRCPATH_FREEDOM_QEMU_HOST := $(SRCDIR)/$(SRCNAME_FREEDOM_QEMU_HOST)

.PHONY: qemu-host qemu-host-package qemu-host-regress qemu-host-cleanup qemu-host-flushup
qemu-host: qemu-host-package

$(SRCPATH_FREEDOM_QEMU_HOST).$(FREEDOM_QEMU_HOST_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_QEMU_HOST)
	rm -rf $(SRCPATH_FREEDOM_QEMU_HOST).*
	git clone $(FREEDOM_QEMU_HOST_GITURL) $(SRCPATH_FREEDOM_QEMU_HOST)
	cd $(SRCPATH_FREEDOM_QEMU_HOST) && git checkout --detach $(FREEDOM_QEMU_HOST_COMMIT)
	cd $(SRCPATH_FREEDOM_QEMU_HOST) && git submodule update --init --recursive
	date > $@

qemu-host-package: \
		$(SRCPATH_FREEDOM_QEMU_HOST).$(FREEDOM_QEMU_HOST_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_QEMU_HOST) package POSTFIXPATH=$(abspath .)/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

qemu-host-regress: \
		$(SRCPATH_FREEDOM_QEMU_HOST).$(FREEDOM_QEMU_HOST_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_QEMU_HOST) regress POSTFIXPATH=$(abspath .)/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

qemu-host-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_QEMU_HOST) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_QEMU_HOST).*
	rm -rf $(SRCPATH_FREEDOM_QEMU_HOST)

qemu-host-flushup:
	$(MAKE) -C $(SRCPATH_FREEDOM_QEMU_HOST) flushup POSTFIXPATH=$(abspath .)/
