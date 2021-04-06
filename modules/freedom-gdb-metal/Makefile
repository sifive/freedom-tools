# Setup the Freedom build script environment
include ../../scripts/Freedom.mk

# Include version identifiers to build up the full version string
include Metadata.mk
PACKAGE_WORDING := Bare Metal GDB
PACKAGE_HEADING := riscv64-unknown-elf-gdb
PACKAGE_VERSION := $(RISCV_GDB_VERSION)-$(FREEDOM_GDB_METAL_ID)$(EXTRA_SUFFIX)
PACKAGE_COMMENT := \# SiFive Freedom Package Properties File

# Source code directory references
BARE_METAL_TUPLE := riscv64-unknown-elf
BARE_METAL_CC_FOR_TARGET ?= $(BARE_METAL_TUPLE)-gcc
BARE_METAL_CXX_FOR_TARGET ?= $(BARE_METAL_TUPLE)-g++

# Some special package configure flags for specific targets
$(WIN64)-gdb-host            := --host=$(WIN64)
$(WIN64)-expat-configure     := --host=$(WIN64)
$(UBUNTU64)-gdb-host         := --host=x86_64-linux-gnu
$(UBUNTU64)-expat-configure  := --host=x86_64-linux-gnu
$(DARWIN)-gdb-host           := --with-liblzma-prefix=/usr
$(DARWIN)-expat-configure    := --disable-shared --enable-static

# Setup the package targets and switch into secondary makefile targets
# Targets $(PACKAGE_HEADING)/install.stamp and $(PACKAGE_HEADING)/libs.stamp
include ../../scripts/Package.mk

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/install.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gdb-py/build.stamp
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
	echo "PACKAGE_BUILD_ID = $(FREEDOM_GDB_METAL_ID)$(EXTRA_SUFFIX)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_CORE_VER = $(RISCV_GDB_VERSION)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_TARGET = $($@_TARGET)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_VENDOR = SiFive" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_RIGHTS = sifive-v00 eclipse-v20" >> $(abspath $($@_PROPERTIES))
	echo "RISCV_TAGS = $(FREEDOM_GDB_METAL_RISCV_TAGS)" >> $(abspath $($@_PROPERTIES))
	echo "TOOLS_TAGS = $(FREEDOM_GDB_METAL_TOOLS_TAGS)" >> $(abspath $($@_PROPERTIES))
	cp $(abspath $($@_PROPERTIES)) $(abspath $($@_INSTALL))/
	tclsh ../../scripts/check-maximum-path-length.tcl $(abspath $($@_INSTALL)) "$(PACKAGE_HEADING)" "$(RISCV_GDB_VERSION)" "$(FREEDOM_GDB_METAL_ID)$(EXTRA_SUFFIX)"
	tclsh ../../scripts/check-same-name-different-case.tcl $(abspath $($@_INSTALL))
	echo $(PATH)
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
	tclsh ../../scripts/check-naming-and-version-syntax.tcl "$(PACKAGE_WORDING)" "$(PACKAGE_HEADING)" "$(RISCV_GDB_VERSION)" "$(FREEDOM_GDB_METAL_ID)$(EXTRA_SUFFIX)"
	rm -rf $($@_INSTALL)
	mkdir -p $($@_INSTALL)
	rm -rf $($@_BUILDLOG)
	mkdir -p $($@_BUILDLOG)
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	git log > $($@_BUILDLOG)/$(PACKAGE_HEADING)-git-commit.log
	git remote -v > $($@_BUILDLOG)/$(PACKAGE_HEADING)-git-remote.log
	cd $(dir $@); curl -L -f -s -o expat-2.2.0.tar.bz2 https://github.com/libexpat/libexpat/releases/download/R_2_2_0/expat-2.2.0.tar.bz2
	cd $(dir $@); $(TAR) -xf expat-2.2.0.tar.bz2
	cd $(dir $@); mv expat-2.2.0 expat
	mkdir -p $($@_INSTALL)/python
	cd $(dir $@); curl -L -f -s -o python-3.7.7-$($@_TARGET).tar.gz https://github.com/sifive/freedom-tools-resources/releases/download/v0-test1/python-3.7.7-$($@_TARGET).tar.gz
	cd $($@_INSTALL)/python; $(TAR) -xf $(abspath $(dir $@))/python-3.7.7-$($@_TARGET).tar.gz
	cd $(dir $@); rm python-3.7.7-$($@_TARGET).tar.gz
	cp patches/pyconfig-x86_64-apple-darwin.sh $($@_INSTALL)/python
	cp patches/pyconfig-x86_64-linux-centos6.sh $($@_INSTALL)/python
	cp patches/pyconfig-x86_64-linux-ubuntu14.sh $($@_INSTALL)/python
	cp patches/pyconfig-x86_64-w64-mingw32.sh $($@_INSTALL)/python
	git clone --single-branch --branch $(RISCV_GDB_BRANCH) $(RISCV_GDB_GITURL) $(dir $@)/$(RISCV_GDB_FOLDER)
	cd $(dir $@)/$(RISCV_GDB_FOLDER) && git checkout --detach $(RISCV_GDB_COMMIT)
	cd $(dir $@)/$(RISCV_GDB_FOLDER) && git submodule update --init --recursive
	$(SED) -E -i -f patches/python-c-gdb.sed $(dir $@)/$(RISCV_GDB_FOLDER)/gdb/python/python.c
	mkdir -p $(dir $($@_SRCBALL))
	cd $(dir $@); $(TAR) --dereference --hard-dereference -c $(RISCV_GDB_FOLDER) | gzip > $($@_SRCBALL)
	date > $@

# OpenOCD requires a GDB that's been build with expat support so it can read
# the target XML files.
$(OBJDIR)/%/build/$(PACKAGE_HEADING)/expat/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/expat/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/expat/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/expat/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	cd $(dir $@); ./configure --prefix=$(abspath $($@_INSTALL)) $($($@_TARGET)-expat-configure) &>$($@_BUILDLOG)/expat-make-configure.log
	$(MAKE) -C $(dir $@) buildlib &>$($@_BUILDLOG)/expat-make-buildlib.log
	$(MAKE) -C $(dir $@) -j1 installlib &>$($@_BUILDLOG)/expat-make-installlib.log
	rm -f $(abspath $($@_INSTALL))/lib/libexpat*.dylib*
	rm -f $(abspath $($@_INSTALL))/lib/libexpat*.so*
	rm -f $(abspath $($@_INSTALL))/lib64/libexpat*.so*
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gdb/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/expat/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gdb/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/build-gdb/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/build-gdb/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/build-gdb/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	# Workaround for CentOS random build fail issue
	#
	# Corresponding bugzilla entry on upstream:
	# https://sourceware.org/bugzilla/show_bug.cgi?id=22941
	touch $(abspath $($@_BUILD))/$(RISCV_GDB_FOLDER)/intl/plural.c
# CC_FOR_TARGET is required for the ld testsuite.
	cd $(dir $@) && CC_FOR_TARGET=$(BARE_METAL_CC_FOR_TARGET) $(abspath $($@_BUILD))/$(RISCV_GDB_FOLDER)/configure \
		--target=$(BARE_METAL_TUPLE) \
		$($($@_TARGET)-gdb-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--with-pkgversion="SiFive GDB-Metal $(PACKAGE_VERSION)" \
		--with-bugurl="https://github.com/sifive/freedom-tools/issues" \
		--disable-werror \
		--with-python=no \
		--enable-gdb \
		--disable-gas \
		--disable-binutils \
		--disable-ld \
		--disable-gold \
		--disable-gprof \
		--with-included-gettext \
		--with-mpc=no \
		--with-mpfr=no \
		--with-gmp=no \
		--with-expat=yes \
		--with-guile=no \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" &>$($@_BUILDLOG)/build-gdb-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/build-gdb-make-build.log
	$(MAKE) -C $(dir $@) -j1 install install-pdf install-html &>$($@_BUILDLOG)/build-gdb-make-install.log
	rm -f $(abspath $($@_INSTALL))/share/doc/gdb/frame-apply.html
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/riscv64-unknown-elf-gdb
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gdb-py/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gdb/build.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gdb-py/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/build-gdb-py/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/build-gdb-py/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/build-gdb-py/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	# Workaround for CentOS random build fail issue
	#
	# Corresponding bugzilla entry on upstream:
	# https://sourceware.org/bugzilla/show_bug.cgi?id=22941
	touch $(abspath $($@_BUILD))/$(RISCV_GDB_FOLDER)/intl/plural.c
# CC_FOR_TARGET is required for the ld testsuite.
	cd $(dir $@) && CC_FOR_TARGET=$(BARE_METAL_CC_FOR_TARGET) $(abspath $($@_BUILD))/$(RISCV_GDB_FOLDER)/configure \
		--target=$(BARE_METAL_TUPLE) \
		$($($@_TARGET)-gdb-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--with-pkgversion="SiFive GDB-Metal $(PACKAGE_VERSION)" \
		--with-bugurl="https://github.com/sifive/freedom-tools/issues" \
		--disable-werror \
		--with-python="$(abspath $($@_INSTALL))/python/pyconfig-$($@_TARGET).sh" \
		--program-prefix="$(BARE_METAL_TUPLE)-" \
		--program-suffix="-py" \
		--enable-gdb \
		--disable-gas \
		--disable-binutils \
		--disable-ld \
		--disable-gold \
		--disable-gprof \
		--with-included-gettext \
		--with-mpc=no \
		--with-mpfr=no \
		--with-gmp=no \
		--with-expat=yes \
		--with-guile=no \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" &>$($@_BUILDLOG)/build-gdb-py-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/build-gdb-py-make-build.log
	$(MAKE) -C $(dir $@) -j1 install install-pdf install-html &>$($@_BUILDLOG)/build-gdb-py-make-install.log
	rm -f $(abspath $($@_INSTALL))/share/doc/gdb/frame-apply.html
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/riscv64-unknown-elf-gdb-py
	date > $@

$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/test.stamp: \
		$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/launch.stamp
	mkdir -p $(dir $@)
	PATH=$(abspath $(OBJDIR)/$(NATIVE)/launch/$(PACKAGE_TARNAME)/bin):$(PATH) riscv64-unknown-elf-gdb -v
	PATH=$(abspath $(OBJDIR)/$(NATIVE)/launch/$(PACKAGE_TARNAME)/bin):$(PATH) riscv64-unknown-elf-gdb-py -v
	@echo "Finished testing $(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).tar.gz tarball"
	date > $@
