
FREEDOM_CUSTOM_GITURL := https://github.com/sifive/freedom-sdk-utilities.git
FREEDOM_CUSTOM_BRANCH := main
FREEDOM_CUSTOM_MODULE := freedom-custom

ifneq ($(TARGET_GITURL),)
FREEDOM_CUSTOM_GITURL := $(TARGET_GITURL)
endif
ifneq ($(TARGET_BRANCH),)
FREEDOM_CUSTOM_BRANCH := $(TARGET_BRANCH)
endif

.PHONY: custom custom-package custom-regress custom-cleanup custom-flushup
custom: custom-package

$(FREEDOM_CUSTOM_MODULE).$(FREEDOM_CUSTOM_BRANCH):
	mkdir -p $(dir $@)
	rm -rf $(FREEDOM_CUSTOM_MODULE)
	rm -rf $(FREEDOM_CUSTOM_MODULE).*
	git clone $(FREEDOM_CUSTOM_GITURL) $(FREEDOM_CUSTOM_MODULE) --single-branch -b $(FREEDOM_CUSTOM_BRANCH)
	cd $(FREEDOM_CUSTOM_MODULE) && git submodule update --init --recursive
	date > $@

custom-package: \
		$(FREEDOM_CUSTOM_MODULE).$(FREEDOM_CUSTOM_BRANCH)
	$(MAKE) -C $(FREEDOM_CUSTOM_MODULE) package POSTFIXPATH=$(abspath $(POSTFIXPATH))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

custom-regress: \
		$(FREEDOM_CUSTOM_MODULE).$(FREEDOM_CUSTOM_BRANCH)
	$(MAKE) -C $(FREEDOM_CUSTOM_MODULE) regress POSTFIXPATH=$(abspath $(POSTFIXPATH))/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

custom-cleanup:
	$(MAKE) -C $(FREEDOM_CUSTOM_MODULE) cleanup POSTFIXPATH=$(abspath $(POSTFIXPATH))/
	rm -rf $(FREEDOM_CUSTOM_MODULE).*
	rm -rf $(FREEDOM_CUSTOM_MODULE)

custom-flushup:
	$(MAKE) -C $(FREEDOM_CUSTOM_MODULE) flushup POSTFIXPATH=$(abspath $(POSTFIXPATH))/
