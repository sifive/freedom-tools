
# The package build needs the tools in the PATH, and the windows build might use the ubuntu (native)
PATH := $(abspath $(OBJ_NATIVE)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE)/bin):$(PATH)
export PATH

# The actual output of this repository is a set of tarballs.
.PHONY: win64-package
win64-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).zip
win64-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).tar.gz
win64-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).log.tar.gz
win64-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).cfg.tar.gz
win64-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).properties
.PHONY: ubuntu64-package
ubuntu64-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64).tar.gz
ubuntu64-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64).log.tar.gz
ubuntu64-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64).cfg.tar.gz
ubuntu64-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64).properties
.PHONY: redhat-package
redhat-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT).tar.gz
redhat-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT).log.tar.gz
redhat-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT).cfg.tar.gz
redhat-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT).properties
.PHONY: darwin-package
darwin-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN).tar.gz
darwin-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN).log.tar.gz
darwin-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN).cfg.tar.gz
darwin-package: $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN).properties

# There's enough % rules that make starts blowing intermediate files away.
.SECONDARY:

$(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).zip: \
		$(OBJDIR)/$(WIN64)/build/$(PACKAGE_HEADING)/install.stamp \
		$(OBJDIR)/$(WIN64)/build/$(PACKAGE_HEADING)/libs.stamp
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$(WIN64)/install; zip -rq $(abspath $@) $(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)

$(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).tar.gz: \
		$(OBJDIR)/$(WIN64)/build/$(PACKAGE_HEADING)/install.stamp \
		$(OBJDIR)/$(WIN64)/build/$(PACKAGE_HEADING)/libs.stamp
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$(WIN64)/install; $(TAR) --dereference --hard-dereference -c $(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64) | gzip > $(abspath $@)

$(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).log.tar.gz: \
		$(OBJDIR)/$(WIN64)/build/$(PACKAGE_HEADING)/install.stamp \
		$(OBJDIR)/$(WIN64)/build/$(PACKAGE_HEADING)/libs.stamp
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$(WIN64)/buildlog/$(PACKAGE_HEADING); $(TAR) --dereference --hard-dereference -c * | gzip > $(abspath $@)

$(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).cfg.tar.gz: \
		$(OBJDIR)/$(WIN64)/build/$(PACKAGE_HEADING)/install.stamp \
		$(OBJDIR)/$(WIN64)/build/$(PACKAGE_HEADING)/libs.stamp
	mkdir -p $(dir $@)
	cd $(abspath ../../); $(TAR) --dereference --hard-dereference --exclude bin --exclude obj -c * | gzip > $(abspath $@)

$(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).properties: \
		$(OBJDIR)/$(WIN64)/build/$(PACKAGE_HEADING)/install.stamp \
		$(OBJDIR)/$(WIN64)/build/$(PACKAGE_HEADING)/libs.stamp
	mkdir -p $(dir $@)
	cp $(OBJDIR)/$(WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).properties $(abspath $@)

$(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).tar.gz: \
		$(OBJDIR)/$(NATIVE)/build/$(PACKAGE_HEADING)/install.stamp
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$(NATIVE)/install; $(TAR) --dereference --hard-dereference -c $(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE) | gzip > $(abspath $@)

$(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).log.tar.gz: \
		$(OBJDIR)/$(NATIVE)/build/$(PACKAGE_HEADING)/install.stamp
	mkdir -p $(dir $@)
	cd $(OBJDIR)/$(NATIVE)/buildlog/$(PACKAGE_HEADING); $(TAR) --dereference --hard-dereference -c * | gzip > $(abspath $@)

$(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).cfg.tar.gz: \
		$(OBJDIR)/$(NATIVE)/build/$(PACKAGE_HEADING)/install.stamp
	mkdir -p $(dir $@)
	cd $(abspath ../../); $(TAR) --dereference --hard-dereference --exclude bin --exclude obj -c * | gzip > $(abspath $@)

$(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).properties: \
		$(OBJDIR)/$(NATIVE)/build/$(PACKAGE_HEADING)/install.stamp
	mkdir -p $(dir $@)
	cp $(OBJDIR)/$(NATIVE)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).properties $(abspath $@)

# Installs native package.
PACKAGE_TARBALL = $(wildcard $(BINDIR)/$(PACKAGE_HEADING)-*-$(NATIVE).tar.gz)
ifneq ($(PACKAGE_TARBALL),)
PACKAGE_TARNAME = $(basename $(basename $(notdir $(PACKAGE_TARBALL))))

$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/launch.stamp: \
		$(PACKAGE_TARBALL)
	mkdir -p $(dir $@)
	rm -rf $(OBJDIR)/$(NATIVE)/launch/$(PACKAGE_TARNAME)
	mkdir -p $(OBJDIR)/$(NATIVE)/launch
	$(TAR) -xz -C $(OBJDIR)/$(NATIVE)/launch -f $(PACKAGE_TARBALL)
	date > $@
else
$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/launch.stamp:
	$(error No $(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).tar.gz tarball available for testing!)
endif

.PHONY: native-regress
native-regress: $(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/test.stamp

.PHONY: cleanup native-cleanup cross-cleanup
cleanup: native-cleanup cross-cleanup

native-cleanup:
	rm -rf $(OBJ_NATIVE)/test/$(PACKAGE_HEADING)
	rm -rf $(OBJ_NATIVE)/build/$(PACKAGE_HEADING)
	rm -rf $(OBJ_NATIVE)/launch/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE)
	rm -rf $(OBJ_NATIVE)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE)
	rm -rf $(OBJ_NATIVE)/testlog/$(PACKAGE_HEADING)
	rm -rf $(OBJ_NATIVE)/buildlog/$(PACKAGE_HEADING)
	rm -rf $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).tar.gz
	rm -rf $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).log.tar.gz
	rm -rf $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).cfg.tar.gz
	rm -rf $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).properties

cross-cleanup:
	rm -rf $(OBJ_WIN64)/test/$(PACKAGE_HEADING)
	rm -rf $(OBJ_WIN64)/build/$(PACKAGE_HEADING)
	rm -rf $(OBJ_WIN64)/launch/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)
	rm -rf $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)
	rm -rf $(OBJ_WIN64)/testlog/$(PACKAGE_HEADING)
	rm -rf $(OBJ_WIN64)/buildlog/$(PACKAGE_HEADING)
	rm -rf $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).zip
	rm -rf $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).tar.gz
	rm -rf $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).log.tar.gz
	rm -rf $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).cfg.tar.gz
	rm -rf $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64).properties

.PHONY: flushup native-flushup cross-flushup
flushup: native-flushup cross-flushup

native-flushup:
	rm -rf $(OBJ_NATIVE)/test/$(PACKAGE_HEADING)
	rm -rf $(OBJ_NATIVE)/build/$(PACKAGE_HEADING)
	rm -rf $(OBJ_NATIVE)/launch/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE)
	rm -rf $(OBJ_NATIVE)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE)
	rm -rf $(OBJ_NATIVE)/testlog/$(PACKAGE_HEADING)
	rm -rf $(OBJ_NATIVE)/buildlog/$(PACKAGE_HEADING)

cross-flushup:
	rm -rf $(OBJ_WIN64)/test/$(PACKAGE_HEADING)
	rm -rf $(OBJ_WIN64)/build/$(PACKAGE_HEADING)
	rm -rf $(OBJ_WIN64)/launch/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)
	rm -rf $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)
	rm -rf $(OBJ_WIN64)/testlog/$(PACKAGE_HEADING)
	rm -rf $(OBJ_WIN64)/buildlog/$(PACKAGE_HEADING)
