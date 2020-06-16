
FREEDOM_SPIKE_DASM_GITURL := https://github.com/sifive/freedom-spike-dasm.git
FREEDOM_SPIKE_DASM_COMMIT := aa714feb26b7c0390534fa830b793ead06e42196

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_SPIKE_DASM_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_SPIKE_DASM := freedom-spike-dasm
SRCPATH_FREEDOM_SPIKE_DASM := $(SRCDIR)/$(SRCNAME_FREEDOM_SPIKE_DASM)

.PHONY: spike-dasm spike-dasm-package spike-dasm-regress spike-dasm-cleanup spike-dasm-flushup
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

spike-dasm-flushup:
	$(MAKE) -C $(SRCPATH_FREEDOM_SPIKE_DASM) flushup POSTFIXPATH=$(abspath .)/
