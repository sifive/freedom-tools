
FREEDOM_SPIKE_DASM_GITURL=https://github.com/sifive/freedom-spike-dasm.git
FREEDOM_SPIKE_DASM_COMMIT=000653b67b2ad088d2cb472b8fc4cdeae39032f0

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
