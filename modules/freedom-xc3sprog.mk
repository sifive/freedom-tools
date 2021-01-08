
FREEDOM_XC3SPROG_GITURL := https://github.com/sifive/freedom-xc3sprog.git
FREEDOM_XC3SPROG_COMMIT := main

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_XC3SPROG_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_XC3SPROG := freedom-xc3sprog
SRCPATH_FREEDOM_XC3SPROG := $(SRCDIR)/$(SRCNAME_FREEDOM_XC3SPROG)

.PHONY: xc3sprog xc3sprog-package xc3sprog-regress xc3sprog-cleanup xc3sprog-flushup
xc3sprog: xc3sprog-package

$(SRCPATH_FREEDOM_XC3SPROG).$(FREEDOM_XC3SPROG_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_XC3SPROG)
	rm -rf $(SRCPATH_FREEDOM_XC3SPROG).*
	git clone $(FREEDOM_XC3SPROG_GITURL) $(SRCPATH_FREEDOM_XC3SPROG) --single-branch -b $(FREEDOM_XC3SPROG_COMMIT)
	cd $(SRCPATH_FREEDOM_XC3SPROG) && git submodule update --init --recursive
	date > $@

xc3sprog-package: \
		$(SRCPATH_FREEDOM_XC3SPROG).$(FREEDOM_XC3SPROG_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_XC3SPROG) package POSTFIXPATH=$(abspath $(POSTFIXPATH))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

xc3sprog-regress: \
		$(SRCPATH_FREEDOM_XC3SPROG).$(FREEDOM_XC3SPROG_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_XC3SPROG) regress POSTFIXPATH=$(abspath $(POSTFIXPATH))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

xc3sprog-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_XC3SPROG) cleanup POSTFIXPATH=$(abspath $(POSTFIXPATH))/
	rm -rf $(SRCPATH_FREEDOM_XC3SPROG).*
	rm -rf $(SRCPATH_FREEDOM_XC3SPROG)

xc3sprog-flushup:
	$(MAKE) -C $(SRCPATH_FREEDOM_XC3SPROG) flushup POSTFIXPATH=$(abspath $(POSTFIXPATH))/