
FREEDOM_TRACE_DECODER_GITURL=https://github.com/sifive/freedom-trace-decoder.git
FREEDOM_TRACE_DECODER_COMMIT=d194875ccf1d48ba0dbf03900f0815074fbd2625

SRCNAME_FREEDOM_TRACE_DECODER := freedom-trace-decoder
SRCPATH_FREEDOM_TRACE_DECODER := $(SRCDIR)/$(SRCNAME_FREEDOM_TRACE_DECODER)

.PHONY: trace-decoder trace-decoder-package trace-decoder-cleanup
trace-decoder: trace-decoder-package

$(SRCPATH_FREEDOM_TRACE_DECODER).$(FREEDOM_TRACE_DECODER_COMMIT):
	mkdir -p $(dir $@)
	rm -rf $(SRCPATH_FREEDOM_TRACE_DECODER)
	rm -rf $(SRCPATH_FREEDOM_TRACE_DECODER).*
	git clone $(FREEDOM_TRACE_DECODER_GITURL) $(SRCPATH_FREEDOM_TRACE_DECODER)
	cd $(SRCPATH_FREEDOM_TRACE_DECODER) && git checkout --detach $(FREEDOM_TRACE_DECODER_COMMIT)
	cd $(SRCPATH_FREEDOM_TRACE_DECODER) && git submodule update --init --recursive
	date > $@

trace-decoder-package: \
		$(SRCPATH_FREEDOM_TRACE_DECODER).$(FREEDOM_TRACE_DECODER_COMMIT)
	$(MAKE) -C $(SRCPATH_FREEDOM_TRACE_DECODER) package POSTFIXPATH=$(abspath .)/

trace-decoder-cleanup:
	$(MAKE) -C $(SRCPATH_FREEDOM_TRACE_DECODER) cleanup POSTFIXPATH=$(abspath .)/
	rm -rf $(SRCPATH_FREEDOM_TRACE_DECODER).*
	rm -rf $(SRCPATH_FREEDOM_TRACE_DECODER)
