
FREEDOM_SPIKE_DASM_GITURL := https://github.com/sifive/freedom-spike-dasm.git
FREEDOM_SPIKE_DASM_COMMIT := a6f253ed1386b72239ef1321aa5f96865229dc05

ifneq ($(CUSTOM_COMMIT),)
FREEDOM_SPIKE_DASM_COMMIT := $(CUSTOM_COMMIT)
endif

SRCNAME_FREEDOM_SPIKE_DASM := freedom-spike-dasm
SRCPATH_FREEDOM_SPIKE_DASM := $(SRCDIR)/$(SRCNAME_FREEDOM_SPIKE_DASM)

.PHONY: sdk-utilities spike-dasm spike-dasm-package spike-dasm-cleanup
spike-dasm: spike-dasm-package
sdk-utilities: spike-dasm-package

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
	$(MAKE) -C $(SRCPATH_FREEDOM_SPIKE_DASM) package POSTFIXPATH=$(abspath .)/

spike-dasm-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_SPIKE_DASM) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_SPIKE_DASM).*
	rm -rf $(SRCPATH_FREEDOM_SPIKE_DASM)
