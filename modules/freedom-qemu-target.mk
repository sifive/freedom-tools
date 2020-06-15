
FREEDOM_QEMU_TARGET_GITURL := https://github.com/sifive/freedom-qemu-target.git
FREEDOM_QEMU_TARGET_COMMIT := 30cd763486fd39c7fd58b18b6a7b5bee0b516335

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_QEMU_TARGET_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_QEMU_TARGET := freedom-qemu-target
SRCPATH_FREEDOM_QEMU_TARGET := $(SRCDIR)/$(SRCNAME_FREEDOM_QEMU_TARGET)

.PHONY: qemu qemu-target qemu-target-package qemu-target-cleanup
qemu-target: qemu-target-package
qemu: qemu-target-package

$(SRCPATH_FREEDOM_QEMU_TARGET).$(FREEDOM_QEMU_TARGET_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_QEMU_TARGET)
	rm -rf $(SRCPATH_FREEDOM_QEMU_TARGET).*
	git clone $(FREEDOM_QEMU_TARGET_GITURL) $(SRCPATH_FREEDOM_QEMU_TARGET)
	cd $(SRCPATH_FREEDOM_QEMU_TARGET) && git checkout --detach $(FREEDOM_QEMU_TARGET_COMMIT)
	cd $(SRCPATH_FREEDOM_QEMU_TARGET) && git submodule update --init --recursive
	date > $@

qemu-target-package: \
		$(SRCPATH_FREEDOM_QEMU_TARGET).$(FREEDOM_QEMU_TARGET_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_QEMU_TARGET) package POSTFIXPATH=$(abspath .)/

qemu-target-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_QEMU_TARGET) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_QEMU_TARGET).*
	rm -rf $(SRCPATH_FREEDOM_QEMU_TARGET)
