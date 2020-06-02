#CUSTOM_GITURL=
#CUSTOM_COMMIT=

SRCNAME_CUSTOM := custom
SRCPATH_CUSTOM := $(SRCDIR)/$(SRCNAME_CUSTOM)

.PHONY: custom custom-package custom-cleanup
custom: custom-package

$(SRCPATH_CUSTOM).$(CUSTOM_CHECKOUT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_CUSTOM)
	rm -rf $(SRCPATH_CUSTOM).*
	git clone $(CUSTOM_GITURL) $(SRCPATH_CUSTOM)
	cd $(SRCPATH_CUSTOM) && git checkout --detach $(CUSTOM_COMMIT)
	cd $(SRCPATH_CUSTOM) && git submodule update --init --recursive
	date > $@

custom-package: \
		$(SRCPATH_CUSTOM).$(CUSTOM_CHECKOUT)
	$(MAKE) -C $(SRCPATH_CUSTOM) package POSTFIXPATH=$(abspath .)/

custom-cleanup:
	rm -rf $(SRCPATH_CUSTOM)
	rm -rf $(SRCPATH_CUSTOM).*
	$(MAKE) -C $(SRCPATH_CUSTOM) cleanup POSTFIXPATH=$(abspath .)/
