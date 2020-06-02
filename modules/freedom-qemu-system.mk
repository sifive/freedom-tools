
FREEDOM_QEMU_SYSTEM_GITURL=https://github.com/sifive/freedom-qemu-system.git
FREEDOM_QEMU_SYSTEM_COMMIT=7072db6728c3f712c596694fede576bfa3be17df

SRCNAME_FREEDOM_QEMU_SYSTEM := freedom-qemu-system
SRCPATH_FREEDOM_QEMU_SYSTEM := $(SRCDIR)/$(SRCNAME_FREEDOM_QEMU_SYSTEM)

.PHONY: qemu qemu-system qemu-system-package qemu-system-cleanup
qemu-system: qemu-system-package
qemu: qemu-system-package

$(SRCPATH_FREEDOM_QEMU_SYSTEM).$(FREEDOM_QEMU_SYSTEM_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_QEMU_SYSTEM)
	rm -rf $(SRCPATH_FREEDOM_QEMU_SYSTEM).*
	git clone $(FREEDOM_QEMU_SYSTEM_GITURL) $(SRCPATH_FREEDOM_QEMU_SYSTEM)
	cd $(SRCPATH_FREEDOM_QEMU_SYSTEM) && git checkout --detach $(FREEDOM_QEMU_SYSTEM_COMMIT)
	cd $(SRCPATH_FREEDOM_QEMU_SYSTEM) && git submodule update --init --recursive
	date > $@

qemu-system-package: \
		$(SRCPATH_FREEDOM_QEMU_SYSTEM).$(FREEDOM_QEMU_SYSTEM_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_QEMU_SYSTEM) package POSTFIXPATH=$(abspath .)/

qemu-system-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_QEMU_SYSTEM) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_QEMU_SYSTEM).*
	rm -rf $(SRCPATH_FREEDOM_QEMU_SYSTEM)
