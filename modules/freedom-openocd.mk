
FREEDOM_OPENOCD_GITURL := git@github.com:sifive/freedom-openocd.git
FREEDOM_OPENOCD_BRANCH := main
FREEDOM_OPENOCD_MODULE := $(SRCDIR)/freedom-openocd

ifneq ($(TARGET_GITURL),)
FREEDOM_OPENOCD_GITURL := $(TARGET_GITURL)
endif
ifneq ($(TARGET_BRANCH),)
FREEDOM_OPENOCD_BRANCH := $(TARGET_BRANCH)
endif

.PHONY: openocd openocd-package openocd-regress openocd-cleanup openocd-flushup
openocd: openocd-package

$(FREEDOM_OPENOCD_MODULE).$(FREEDOM_OPENOCD_BRANCH):
	mkdir -p $(dir $@)
	rm -rf $(FREEDOM_OPENOCD_MODULE)
	rm -rf $(FREEDOM_OPENOCD_MODULE).*
	git clone $(FREEDOM_OPENOCD_GITURL) $(FREEDOM_OPENOCD_MODULE) --single-branch -b $(FREEDOM_OPENOCD_BRANCH)
	cd $(FREEDOM_OPENOCD_MODULE) && git submodule update --init --recursive
	date > $@

openocd-package: \
		$(FREEDOM_OPENOCD_MODULE).$(FREEDOM_OPENOCD_BRANCH)
	$(MAKE) -C $(FREEDOM_OPENOCD_MODULE) package BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

openocd-regress: \
		$(FREEDOM_OPENOCD_MODULE).$(FREEDOM_OPENOCD_BRANCH)
	$(MAKE) -C $(FREEDOM_OPENOCD_MODULE) regress BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

openocd-cleanup:
	$(MAKE) -C $(FREEDOM_OPENOCD_MODULE) cleanup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
	rm -rf $(FREEDOM_OPENOCD_MODULE).*
	rm -rf $(FREEDOM_OPENOCD_MODULE)

openocd-flushup:
	$(MAKE) -C $(FREEDOM_OPENOCD_MODULE) flushup BINDIR_PREFIX=$(abspath $(BINDIR_PREFIX))/ OBJDIR_PREFIX=$(abspath $(OBJDIR_PREFIX))/
