# Setup the Freedom build script environment
include ../../scripts/Freedom.mk

# Include version identifiers to build up the full version string
include Metadata.mk
PACKAGE_WORDING := OpenOCD
PACKAGE_HEADING := riscv-openocd
PACKAGE_VERSION := $(RISCV_OPENOCD_VERSION)-$(FREEDOM_OPENOCD_ID)$(EXTRA_SUFFIX)
PACKAGE_COMMENT := \# SiFive Freedom Package Properties File

# Some special package configure flags for specific targets
$(WIN64)-rocd-host         := --host=$(WIN64)
$(WIN64)-oftdi-configure   := -DCMAKE_TOOLCHAIN_FILE="$(abspath $(OBJ_WIN64)/build/$(PACKAGE_HEADING)/libftdi/cmake/Toolchain-x86_64-w64-mingw32.cmake)" -DLIBUSB_LIBRARIES="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/bin/libusb-1.0.dll)" -DLIBUSB_INCLUDE_DIR="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/include/libusb-1.0)"
$(WIN64)-odeps-vars        := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include"
$(WIN64)-rocd-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include"
$(UBUNTU64)-ousb-configure := --disable-shared
$(UBUNTU64)-rocd-host      := --host=x86_64-linux-gnu
$(UBUNTU64)-odeps-vars     := PKG_CONFIG_PATH="$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/include -fPIC" LDFLAGS="-L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib -pthread"
$(UBUNTU64)-rocd-vars      := PKG_CONFIG_PATH="$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/include" CPPFLAGS="-I$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/include" LIBUSB_INCLUDE_DIRS="$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/include" LDFLAGS="-L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib"
$(DARWIN)-ousb-configure   := --disable-shared
$(DARWIN)-odeps-vars       := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/include" CPPFLAGS="-I$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/include" LDFLAGS="-L$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib -framework CoreFoundation -framework IOKit"
$(DARWIN)-rocd-vars        := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/include -O2" CPPFLAGS="-I$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/include" LDFLAGS="-L$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib -framework CoreFoundation -framework IOKit"
$(REDHAT)-ousb-configure   := --disable-shared
$(REDHAT)-odeps-vars       := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib/pkgconfig:$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64/pkgconfig" CFLAGS="-I$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/include -fPIC" LDFLAGS="-L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64 -lrt"
$(REDHAT)-rocd-vars        := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib/pkgconfig:$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64/pkgconfig" CFLAGS="-I$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/include -O2" CPPFLAGS="-I$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/include" LIBUSB_INCLUDE_DIRS="$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/include" LDFLAGS="-L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64 -lrt"

# Setup the package targets and switch into secondary makefile targets
# Targets $(PACKAGE_HEADING)/install.stamp and $(PACKAGE_HEADING)/libs.stamp
include ../../scripts/Package.mk

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/install.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/$(RISCV_OPENOCD_FOLDER)/build.stamp
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
	echo "PACKAGE_BUILD_ID = $(FREEDOM_OPENOCD_ID)$(EXTRA_SUFFIX)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_CORE_VER = $(RISCV_OPENOCD_VERSION)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_TARGET = $($@_TARGET)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_VENDOR = SiFive" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_RIGHTS = sifive-v00 eclipse-v20" >> $(abspath $($@_PROPERTIES))
	echo "RISCV_TAGS = $(FREEDOM_OPENOCD_RISCV_TAGS)" >> $(abspath $($@_PROPERTIES))
	echo "TOOLS_TAGS = $(FREEDOM_OPENOCD_TOOLS_TAGS)" >> $(abspath $($@_PROPERTIES))
	cp $(abspath $($@_PROPERTIES)) $(abspath $($@_INSTALL))/
	tclsh ../../scripts/check-maximum-path-length.tcl $(abspath $($@_INSTALL)) "$(PACKAGE_HEADING)" "$(RISCV_OPENOCD_VERSION)" "$(FREEDOM_OPENOCD_ID)$(EXTRA_SUFFIX)"
	tclsh ../../scripts/check-same-name-different-case.tcl $(abspath $($@_INSTALL))
	date > $@

# We might need some extra target libraries for this package
$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libs.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/install.stamp
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
	tclsh ../../scripts/check-naming-and-version-syntax.tcl "$(PACKAGE_WORDING)" "$(PACKAGE_HEADING)" "$(RISCV_OPENOCD_VERSION)" "$(FREEDOM_OPENOCD_ID)$(EXTRA_SUFFIX)"
	rm -rf $($@_INSTALL)
	mkdir -p $($@_INSTALL)
	rm -rf $($@_BUILDLOG)
	mkdir -p $($@_BUILDLOG)
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	git log > $($@_BUILDLOG)/$(PACKAGE_HEADING)-git-commit.log
	git remote -v > $($@_BUILDLOG)/$(PACKAGE_HEADING)-git-remote.log
	cd $(dir $@); curl -L -f -s -o libusb-1.0.22.tar.bz2 https://github.com/libusb/libusb/releases/download/v1.0.22/libusb-1.0.22.tar.bz2
	cd $(dir $@); $(TAR) -xf libusb-1.0.22.tar.bz2
	cd $(dir $@); mv libusb-1.0.22 libusb
	cd $(dir $@); curl -L -f -s -o libusb-compat-0.1.7.tar.bz2 https://github.com/libusb/libusb-compat-0.1/releases/download/v0.1.7/libusb-compat-0.1.7.tar.bz2
	cd $(dir $@); $(TAR) -xf libusb-compat-0.1.7.tar.bz2
	cd $(dir $@); mv libusb-compat-0.1.7 libusb-compat
	cd $(dir $@); curl -L -f -s -o libftdi1-1.4.tar.bz2 https://www.intra2net.com/en/developer/libftdi/download/libftdi1-1.4.tar.bz2
	cd $(dir $@); $(TAR) -xf libftdi1-1.4.tar.bz2
	cd $(dir $@); mv libftdi1-1.4 libftdi
	git clone --single-branch --branch $(RISCV_OPENOCD_BRANCH) $(RISCV_OPENOCD_GITURL) $(dir $@)/$(RISCV_OPENOCD_FOLDER)
	cd $(dir $@)/$(RISCV_OPENOCD_FOLDER) && git checkout --detach $(RISCV_OPENOCD_COMMIT)
	cd $(dir $@)/$(RISCV_OPENOCD_FOLDER) && git submodule update --init --recursive
	$(SED) -i -f patches/openocd.sed -e "s/SIFIVE_PACKAGE_VERSION/SiFive OpenOCD $(PACKAGE_VERSION)/" $(dir $@)/$(RISCV_OPENOCD_FOLDER)/src/openocd.c
	$(SED) -E -i -f patches/openocd-rtos.sed $(dir $@)/$(RISCV_OPENOCD_FOLDER)/src/rtos/rtos.c
	mkdir -p $(dir $($@_SRCBALL))
	cd $(dir $@); $(TAR) --dereference --hard-dereference -c libusb libusb-compat libftdi $(RISCV_OPENOCD_FOLDER) | gzip > $($@_SRCBALL)
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libusb/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/libusb/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/libusb/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/libusb/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	cd $(dir $@) && $($($@_TARGET)-odeps-vars) ./configure \
		$($($@_TARGET)-rocd-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--disable-udev \
		--enable-static \
		$($($@_TARGET)-ousb-configure) &>$($@_BUILDLOG)/libusb-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/libusb-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/libusb-make-install.log
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libusb-compat/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libusb/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/libusb-compat/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/libusb-compat/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/libusb-compat/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	cd $(dir $@) && $($($@_TARGET)-odeps-vars) ./configure \
		$($($@_TARGET)-rocd-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static \
		$($($@_TARGET)-ousb-configure) &>$($@_BUILDLOG)/libusb-compat-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/libusb-compat-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/libusb-compat-make-install.log
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libftdi/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libusb-compat/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/libftdi/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/libftdi/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/libftdi/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	cd $(dir $@) && $($($@_TARGET)-odeps-vars) cmake \
		-DCMAKE_INSTALL_PREFIX:PATH=$(abspath $($@_INSTALL)) \
		$($($@_TARGET)-oftdi-configure) . &>$($@_BUILDLOG)/libftdi-make-cmake.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/libftdi-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/libftdi-make-install.log
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/$(RISCV_OPENOCD_FOLDER)/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libftdi/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/$(RISCV_OPENOCD_FOLDER)/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/$(RISCV_OPENOCD_FOLDER)/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/$(RISCV_OPENOCD_FOLDER)/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	rm -f $(abspath $($@_INSTALL))/lib/lib*.dylib*
	rm -f $(abspath $($@_INSTALL))/lib/lib*.so*
	rm -f $(abspath $($@_INSTALL))/lib64/lib*.so*
	find $(dir $@) -iname configure.ac | $(SED) s/configure.ac/m4/ | xargs mkdir -p
	cd $(dir $@); ./bootstrap nosubmodule &>$($@_BUILDLOG)/$(RISCV_OPENOCD_FOLDER)-make-bootstrap.log
	cd $(dir $@); $($($@_TARGET)-rocd-vars) ./configure \
		$($($@_TARGET)-rocd-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-remote-bitbang \
		--disable-werror \
		--enable-ftdi \
		--enable-jtag_vpi \
		$($($@_TARGET)-rocd-configure) &>$($@_BUILDLOG)/$(RISCV_OPENOCD_FOLDER)-make-configure.log
	$(MAKE) $($($@_TARGET)-rocd-vars) -C $(dir $@) &>$($@_BUILDLOG)/$(RISCV_OPENOCD_FOLDER)-make-build.log
	$(MAKE) $($($@_TARGET)-rocd-vars) -C $(dir $@) pdf html &>$($@_BUILDLOG)/$(RISCV_OPENOCD_FOLDER)-make-build-doc.log
	$(MAKE) $($($@_TARGET)-rocd-vars) -C $(dir $@) -j1 install install-pdf install-html &>$($@_BUILDLOG)/$(RISCV_OPENOCD_FOLDER)-make-install.log
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/openocd
	date > $@

$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/test.stamp: \
		$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/launch.stamp
	mkdir -p $(dir $@)
	PATH=$(abspath $(OBJDIR)/$(NATIVE)/launch/$(PACKAGE_TARNAME)/bin):$(PATH) openocd -v
	@echo "Finished testing $(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).tar.gz tarball"
	date > $@
