
FREEDOM_SPIKE_DASM_GITURL := https://github.com/sifive/freedom-spike-dasm.git
FREEDOM_SPIKE_DASM_COMMIT := 2ef2c24fe30454682b927be13d6da7c48a824f15

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_SPIKE_DASM_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_SPIKE_DASM := freedom-spike-dasm
SRCPATH_FREEDOM_SPIKE_DASM := $(SRCDIR)/$(SRCNAME_FREEDOM_SPIKE_DASM)

.PHONY: spike-dasm spike-dasm-package spike-dasm-regress spike-dasm-cleanup
spike-dasm: spike-dasm-package

.PHONY: sdk-utilities sdk-utilities-package sdk-utilities-regress
sdk-utilities-package: spike-dasm-package
sdk-utilities-regress: spike-dasm-regress
sdk-utilities: spike-dasm

$(SRCPATH_FREEDOM_SPIKE_DASM).$(FREEDOM_SPIKE_DASM_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_SPIKE_DASM)
	rm -rf $(SRCPATH_FREEDOM_SPIKE_DASM).*
	git clone $(FREEDOM_SPIKE_DASM_GITURL) $(SRCPATH_FREEDOM_SPIKE_DASM)
	cd $(SRCPATH_FREEDOM_SPIKE_DASM) && git checkout --detach $(FREEDOM_SPIKE_DASM_COMMIT)
	cd $(SRCPATH_FREEDOM_SPIKE_DASM) && git submodule update --init --recursive
	date > $@

spike-dasm-package: \
		$(SRCPATH_FREEDOM_SPIKE_DASM).$(FREEDOM_SPIKE_DASM_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_SPIKE_DASM) package POSTFIXPATH=$(abspath .)/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

spike-dasm-regress: \
		$(SRCPATH_FREEDOM_SPIKE_DASM).$(FREEDOM_SPIKE_DASM_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_SPIKE_DASM) regress POSTFIXPATH=$(abspath .)/ EXTRA_OPTION=$(EXTRA_OPTION) EXTRA_SUFFIX=$(EXTRA_SUFFIX)

spike-dasm-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_SPIKE_DASM) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_SPIKE_DASM).*
	rm -rf $(SRCPATH_FREEDOM_SPIKE_DASM)
