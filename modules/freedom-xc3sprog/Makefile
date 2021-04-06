# Setup the Freedom build script environment
include ../../scripts/Freedom.mk

# Include version identifiers to build up the full version string
include Metadata.mk
PACKAGE_WORDING := XC3SPROG
PACKAGE_HEADING := xc3sprog
PACKAGE_VERSION := $(XC3SPROG_VERSION)-$(FREEDOM_XC3SPROG_ID)$(EXTRA_SUFFIX)
PACKAGE_COMMENT := \# SiFive Freedom Package Properties File

# Some special package configure flags for specific targets
$(WIN64)-xc3sp-host          := --host=$(WIN64)
$(WIN64)-xftdi-configure     := -DCMAKE_TOOLCHAIN_FILE="$(abspath $(OBJ_WIN64)/build/$(PACKAGE_HEADING)/libftdi/cmake/Toolchain-x86_64-w64-mingw32.cmake)" -DLIBUSB_LIBRARIES="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/bin/libusb-1.0.dll)" -DLIBUSB_INCLUDE_DIR="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/include/libusb-1.0)"
$(WIN64)-xdeps-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include"
$(WIN64)-xc3sp-configure     := -DCMAKE_TOOLCHAIN_FILE="$(abspath $(OBJ_WIN64)/build/$(PACKAGE_HEADING)/xc3sprog/Toolchain-mingw32.cmake)" -DLIBUSB_LIBRARIES="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/bin/libusb-1.0.dll)" -DLIBUSB_INCLUDE_DIR="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/include/libusb-1.0)"
$(WIN64)-xc3sp-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include"
$(UBUNTU64)-xc3sp-host       := --host=x86_64-linux-gnu
$(UBUNTU64)-xdeps-vars       := PKG_CONFIG_PATH="$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/include" LDFLAGS="-L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib"
$(UBUNTU64)-xc3sp-vars       := PKG_CONFIG_PATH="$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/include" CPPFLAGS="-I$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/include" LIBUSB_INCLUDE_DIRS="$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/include" LDFLAGS="-L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib"
$(DARWIN)-xdeps-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/include" CPPFLAGS="-I$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/include" LDFLAGS="-L$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib -framework CoreFoundation -framework IOKit"
$(DARWIN)-xc3sp-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/include" CPPFLAGS="-I$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/include" LDFLAGS="-L$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib -liconv -framework CoreFoundation -framework IOKit"
$(DARWIN)-xc3sp-framework    := -framework CoreFoundation -framework IOKit
$(REDHAT)-xdeps-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib/pkgconfig:$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64/pkgconfig" CFLAGS="-I$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/include" LDFLAGS="-L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64 -lrt"
$(REDHAT)-xc3sp-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib/pkgconfig:$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64/pkgconfig" CFLAGS="-I$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/include" CPPFLAGS="-I$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/include" LIBUSB_INCLUDE_DIRS="$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/include" LDFLAGS="-L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64 -lrt"
$(REDHAT)-xc3sp-configure    := -DLIBRT_LIBRARIES="rt"

# Setup the package targets and switch into secondary makefile targets
# Targets $(PACKAGE_HEADING)/install.stamp and $(PACKAGE_HEADING)/libs.stamp
include ../../scripts/Package.mk

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/install.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/$(XC3SPROG_FOLDER)/build.stamp
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
	echo "PACKAGE_BUILD_ID = $(FREEDOM_XC3SPROG_ID)$(EXTRA_SUFFIX)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_CORE_VER = $(XC3SPROG_VERSION)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_TARGET = $($@_TARGET)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_VENDOR = SiFive" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_RIGHTS = sifive-v00 eclipse-v20" >> $(abspath $($@_PROPERTIES))
	echo "RISCV_TAGS = $(FREEDOM_XC3SPROG_RISCV_TAGS)" >> $(abspath $($@_PROPERTIES))
	echo "TOOLS_TAGS = $(FREEDOM_XC3SPROG_TOOLS_TAGS)" >> $(abspath $($@_PROPERTIES))
	cp $(abspath $($@_PROPERTIES)) $(abspath $($@_INSTALL))/
	tclsh ../../scripts/check-maximum-path-length.tcl $(abspath $($@_INSTALL)) "$(PACKAGE_HEADING)" "$(XC3SPROG_VERSION)" "$(FREEDOM_XC3SPROG_ID)$(EXTRA_SUFFIX)"
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
	tclsh ../../scripts/check-naming-and-version-syntax.tcl "$(PACKAGE_WORDING)" "$(PACKAGE_HEADING)" "$(XC3SPROG_VERSION)" "$(FREEDOM_XC3SPROG_ID)$(EXTRA_SUFFIX)"
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
	cd $(dir $@); curl -L -f -s -o libiconv-1.15.tar.gz https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz
	cd $(dir $@); $(TAR) -xf libiconv-1.15.tar.gz
	cd $(dir $@); mv libiconv-1.15 libiconv
	git clone --single-branch --branch $(XC3SPROG_BRANCH) $(XC3SPROG_GITURL) $(dir $@)/$(XC3SPROG_FOLDER)
	cd $(dir $@)/$(XC3SPROG_FOLDER) && git checkout --detach $(XC3SPROG_COMMIT)
	cd $(dir $@)/$(XC3SPROG_FOLDER) && git submodule update --init --recursive
	$(SED) -i -f patches/xc3sprog.sed -e "s/SIFIVE_PACKAGE_VERSION/SiFive XC3SPROG $(PACKAGE_VERSION)/" $(dir $@)/$(XC3SPROG_FOLDER)/xc3sprog.cpp
	$(SED) -i -f patches/xc3sprog-cmake.sed $(dir $@)/$(XC3SPROG_FOLDER)/CMakeLists.txt
	$(SED) -i -f patches/xc3sprog-cmake.sed $(dir $@)/$(XC3SPROG_FOLDER)/javr/CMakeLists.txt
	$(SED) -i -f patches/xc3sprog-mingw32.sed $(dir $@)/$(XC3SPROG_FOLDER)/Toolchain-mingw32.cmake
	mkdir -p $(dir $($@_SRCBALL))
	cd $(dir $@); $(TAR) --dereference --hard-dereference -c libusb libusb-compat libftdi libiconv $(XC3SPROG_FOLDER) | gzip > $($@_SRCBALL)
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libusb/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/libusb/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/libusb/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/libusb/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	cd $(dir $@) && ./configure \
		$($($@_TARGET)-xc3sp-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--disable-udev \
		--enable-static &>$($@_BUILDLOG)/libusb-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/libusb-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/libusb-make-install.log
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libusb-compat/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libusb/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/libusb-compat/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/libusb-compat/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/libusb-compat/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	cd $(dir $@) && $($($@_TARGET)-xdeps-vars) ./configure \
		$($($@_TARGET)-xc3sp-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static &>$($@_BUILDLOG)/libusb-compat-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/libusb-compat-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/libusb-compat-make-install.log
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libftdi/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libusb-compat/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/libftdi/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/libftdi/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/libftdi/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	cd $(dir $@) && $($($@_TARGET)-xdeps-vars) cmake \
		-DCMAKE_INSTALL_PREFIX:PATH=$(abspath $($@_INSTALL)) \
		$($($@_TARGET)-xftdi-configure) . &>$($@_BUILDLOG)/libftdi-make-cmake.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/libftdi-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/libftdi-make-install.log
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libiconv/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/libiconv/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/libiconv/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/libiconv/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	cd $(dir $@) && ./configure \
		$($($@_TARGET)-xc3sp-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static &>$($@_BUILDLOG)/libiconv-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/libiconv-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/libiconv-make-install.log
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/$(XC3SPROG_FOLDER)/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libftdi/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libiconv/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/$(XC3SPROG_FOLDER)/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/$(XC3SPROG_FOLDER)/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/$(XC3SPROG_FOLDER)/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	rm -f $(abspath $($@_INSTALL))/lib/lib*.dylib*
	rm -f $(abspath $($@_INSTALL))/lib/lib*.so*
	rm -f $(abspath $($@_INSTALL))/lib64/lib*.so*
	cd $(dir $@) && $($($@_TARGET)-xc3sp-vars) cmake \
		-DCMAKE_INSTALL_PREFIX:PATH=$(abspath $($@_INSTALL)) \
		-DCMAKE_EXE_LINKER_FLAGS="-L$(abspath $($@_INSTALL))/lib -L$(abspath $($@_INSTALL))/lib64 -pthread $($($@_TARGET)-xc3sp-framework)" \
		-DLIBUSB_INCLUDE_DIRS=$(abspath $($@_INSTALL))/include \
		-DLIBFTDI_LIBRARIES=ftdi1 \
		$($($@_TARGET)-xc3sp-configure) \
		. &>$($@_BUILDLOG)/$(XC3SPROG_FOLDER)-make-cmake.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/$(XC3SPROG_FOLDER)-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/$(XC3SPROG_FOLDER)-make-install.log
	rm -f $(abspath $($@_INSTALL))/bin/iconv
	rm -f $(abspath $($@_INSTALL))/bin/iconv.exe
	rm -rf $(abspath $($@_INSTALL))/share
	cp -R $(dir $@)/share $(abspath $($@_INSTALL))
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/xc3sprog
	date > $@

$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/test.stamp: \
		$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/launch.stamp
	mkdir -p $(dir $@)
#	PATH=$(abspath $(OBJDIR)/$(NATIVE)/launch/$(PACKAGE_TARNAME)/bin):$(PATH) xc3sprog -h
	@echo "xc3sprog executable cannot be run with a -v option without failing!"
	@echo "Finished testing $(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).tar.gz tarball"
	date > $@
