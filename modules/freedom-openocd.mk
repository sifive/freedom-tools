
FREEDOM_OPENOCD_GITURL := https://github.com/sifive/freedom-openocd.git
FREEDOM_OPENOCD_COMMIT := 563b31f629fd79c3e5dde689be6e731a60adb308

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_OPENOCD_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_OPENOCD := freedom-openocd
SRCPATH_FREEDOM_OPENOCD := $(SRCDIR)/$(SRCNAME_FREEDOM_OPENOCD)

.PHONY: openocd openocd-package openocd-regress openocd-cleanup openocd-flushup
openocd: openocd-package

$(SRCPATH_FREEDOM_OPENOCD).$(FREEDOM_OPENOCD_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_OPENOCD)
	rm -rf $(SRCPATH_FREEDOM_OPENOCD).*
	git clone $(FREEDOM_OPENOCD_GITURL) $(SRCPATH_FREEDOM_OPENOCD)
	cd $(SRCPATH_FREEDOM_OPENOCD) && git checkout --detach $(FREEDOM_OPENOCD_COMMIT)
	cd $(SRCPATH_FREEDOM_OPENOCD) && git submodule update --init --recursive
	date > $@

openocd-package: \
		$(SRCPATH_FREEDOM_OPENOCD).$(FREEDOM_OPENOCD_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_OPENOCD) package POSTFIXPATH=$(abspath .)/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

openocd-regress: \
		$(SRCPATH_FREEDOM_OPENOCD).$(FREEDOM_OPENOCD_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_OPENOCD) regress POSTFIXPATH=$(abspath .)/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

openocd-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_OPENOCD) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_OPENOCD).*
	rm -rf $(SRCPATH_FREEDOM_OPENOCD)

openocd-flushup:
	$(MAKE) -C $(SRCPATH_FREEDOM_OPENOCD) flushup POSTFIXPATH=$(abspath .)/
