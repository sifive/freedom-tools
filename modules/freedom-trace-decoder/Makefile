# Setup the Freedom build script environment
include ../../scripts/Freedom.mk

# Include version identifiers to build up the full version string
include Metadata.mk
PACKAGE_WORDING := Trace Decoder
PACKAGE_HEADING := trace-decoder
PACKAGE_VERSION := $(TRACE_DECODER_VERSION)-$(FREEDOM_TRACE_DECODER_ID)$(EXTRA_SUFFIX)
PACKAGE_COMMENT := \# SiFive Freedom Package Properties File

# Source code directory references
BARE_METAL_TUPLE := riscv64-unknown-elf
BARE_METAL_CC_FOR_TARGET ?= $(BARE_METAL_TUPLE)-gcc
BARE_METAL_CXX_FOR_TARGET ?= $(BARE_METAL_TUPLE)-g++

# Some special package configure flags for specific targets
$(WIN64)-binutils-host          := --host=$(WIN64)
$(WIN64)-tdc-cross              := x86_64-w64-mingw32-
$(WIN64)-tdc-binext             := .exe
$(UBUNTU64)-binutils-host       := --host=x86_64-linux-gnu
$(UBUNTU64)-binutils-configure  := --enable-shared --enable-static
$(DARWIN)-binutils-configure    := --with-included-gettext
$(REDHAT)-binutils-configure    := --enable-shared --enable-static

# Setup the package targets and switch into secondary makefile targets
# Targets $(PACKAGE_HEADING)/install.stamp and $(PACKAGE_HEADING)/libs.stamp
include ../../scripts/Package.mk

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/install.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/$(TRACE_DECODER_FOLDER)/build.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/install.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/install.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_PROPERTIES := $(patsubst %/build/$(PACKAGE_HEADING)/install.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET).properties,$@))
	mkdir -p $(dir $@)
	git log --format="[%ad] %s" > $(abspath $($@_INSTALL))/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET).changelog
	rm -f $(abspath $($@_PROPERTIES))
	echo "$(PACKAGE_COMMENT)" > $(abspath $($@_PROPERTIES))
	echo "PACKAGE_TYPE = freedom-tools" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_DESC_SEG = $(PACKAGE_WORDING)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_FIXED_ID = $(PACKAGE_HEADING)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_BUILD_ID = $(FREEDOM_TRACE_DECODER_ID)$(EXTRA_SUFFIX)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_CORE_VER = $(TRACE_DECODER_VERSION)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_TARGET = $($@_TARGET)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_VENDOR = SiFive" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_RIGHTS = sifive-v00 eclipse-v20" >> $(abspath $($@_PROPERTIES))
	echo "RISCV_TAGS = $(FREEDOM_TRACE_DECODER_RISCV_TAGS)" >> $(abspath $($@_PROPERTIES))
	echo "TOOLS_TAGS = $(FREEDOM_TRACE_DECODER_TOOLS_TAGS)" >> $(abspath $($@_PROPERTIES))
	cp $(abspath $($@_PROPERTIES)) $(abspath $($@_INSTALL))/
	tclsh ../../scripts/check-maximum-path-length.tcl $(abspath $($@_INSTALL)) "$(PACKAGE_HEADING)" "$(TRACE_DECODER_VERSION)" "$(FREEDOM_TRACE_DECODER_ID)$(EXTRA_SUFFIX)"
	tclsh ../../scripts/check-same-name-different-case.tcl $(abspath $($@_INSTALL))
	date > $@

# We might need some extra target libraries for this package
$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/libs.stamp: \
		$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/install.stamp
	date > $@

$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/libs.stamp: \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/install.stamp
	-$(WIN64)-gcc -print-search-dirs | grep ^programs | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libwinpthread*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/bin
	-$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libgcc_s_seh*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/bin
	-$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libstdc*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/bin
	-$(WIN64)-gcc -print-search-dirs | grep ^libraries | cut -d= -f2- | tr : "\n" | xargs -I {} find {} -iname "libssp*.dll" | xargs cp -t $(OBJDIR)/$(WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/bin
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/source.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/source.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	$(eval $@_SRCBALL := $(abspath $(BINDIR)/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET).src.tar.gz))
	tclsh ../../scripts/check-naming-and-version-syntax.tcl "$(PACKAGE_WORDING)" "$(PACKAGE_HEADING)" "$(TRACE_DECODER_VERSION)" "$(FREEDOM_TRACE_DECODER_ID)$(EXTRA_SUFFIX)"
	rm -rf $($@_INSTALL)
	mkdir -p $($@_INSTALL)
	rm -rf $($@_BUILDLOG)
	mkdir -p $($@_BUILDLOG)
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	git log > $($@_BUILDLOG)/$(PACKAGE_HEADING)-git-commit.log
	git remote -v > $($@_BUILDLOG)/$(PACKAGE_HEADING)-git-remote.log
	git clone --single-branch --branch $(RISCV_BINUTILS_BRANCH) $(RISCV_BINUTILS_GITURL) $(dir $@)/$(RISCV_BINUTILS_FOLDER)
	cd $(dir $@)/$(RISCV_BINUTILS_FOLDER) && git checkout --detach $(RISCV_BINUTILS_COMMIT)
	cd $(dir $@)/$(RISCV_BINUTILS_FOLDER) && git submodule update --init --recursive
	git clone --single-branch --branch $(TRACE_DECODER_BRANCH) $(TRACE_DECODER_GITURL) $(dir $@)/$(TRACE_DECODER_FOLDER)
	cd $(dir $@)/$(TRACE_DECODER_FOLDER) && git checkout --detach $(TRACE_DECODER_COMMIT)
	cd $(dir $@)/$(TRACE_DECODER_FOLDER) && git submodule update --init --recursive
	mkdir -p $(dir $($@_SRCBALL))
	cd $(dir $@); $(TAR) --dereference --hard-dereference -c $(RISCV_BINUTILS_FOLDER) $(TRACE_DECODER_FOLDER) | gzip > $($@_SRCBALL)
	date > $@

# Reusing binutils build script across binutils-metal, gcc-metal and trace-decoder
include ../freedom-binutils-metal/scripts/build_binutils_target.mk

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-binutils/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-binutils/support.stamp
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/$(TRACE_DECODER_FOLDER)/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-binutils/build.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/$(TRACE_DECODER_FOLDER)/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/$(TRACE_DECODER_FOLDER)/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BINUTILS := $(patsubst %/build/$(PACKAGE_HEADING)/$(TRACE_DECODER_FOLDER)/build.stamp,%/build/$(PACKAGE_HEADING)/build-binutils,$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/$(TRACE_DECODER_FOLDER)/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	$(MAKE) -C $(dir $@) BINUTILSPATH=$(abspath $($@_BINUTILS)) CROSSPREFIX=$($($@_TARGET)-tdc-cross) all &>$($@_BUILDLOG)/$(TRACE_DECODER_FOLDER)-make-build.log
	$(MAKE) -j1 -C $(dir $@) INSTALLPATH=$(abspath $($@_INSTALL)) CROSSPREFIX=$($($@_TARGET)-tdc-cross) install &>$($@_BUILDLOG)/$(TRACE_DECODER_FOLDER)-make-install.log
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/dqr
	date > $@

$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/test.stamp: \
		$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/launch.stamp
	mkdir -p $(dir $@)
	PATH=$(abspath $(OBJDIR)/$(NATIVE)/launch/$(PACKAGE_TARNAME)/bin):$(PATH) dqr -v
	@echo "Finished testing $(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).tar.gz tarball"
	date > $@
