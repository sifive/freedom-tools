
FREEDOM_OPENOCD_GITURL := https://github.com/sifive/freedom-openocd.git
FREEDOM_OPENOCD_COMMIT := 2d443c07e26607c00fee8dab63f06b1a51de1fdd

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_OPENOCD_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_OPENOCD := freedom-openocd
SRCPATH_FREEDOM_OPENOCD := $(SRCDIR)/$(SRCNAME_FREEDOM_OPENOCD)

.PHONY: openocd openocd-package openocd-cleanup
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
	$(MAKE) -C $(SRCPATH_FREEDOM_OPENOCD) package POSTFIXPATH=$(abspath .)/

openocd-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_OPENOCD) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_OPENOCD).*
	rm -rf $(SRCPATH_FREEDOM_OPENOCD)
