# Setup the Freedom build script environment
include ../../scripts/Freedom.mk

# Include version identifiers to build up the full version string
include Metadata.mk
PACKAGE_WORDING := QEMU
PACKAGE_HEADING := riscv-qemu
PACKAGE_VERSION := $(RISCV_QEMU_VERSION)-$(FREEDOM_QEMU_ID)$(EXTRA_SUFFIX)
PACKAGE_COMMENT := \# SiFive Freedom Package Properties File

# Some special package configure flags for specific targets
$(WIN64)-rqemu-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include"
$(WIN64)-rqemu-vars-ext      := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include"
$(WIN64)-rqemu-host          := --host=$(WIN64)
$(WIN64)-rqemu-cross         := --cross-prefix=x86_64-w64-mingw32-
$(WIN64)-rqemu-bindir        := /bin
$(WIN64)-gettext-configure   := --enable-threads=windows
$(WIN64)-glib-configure      := --enable-static --disable-shared
$(WIN64)-glib-vars           := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include"
$(WIN64)-pixman-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include" CPPFLAGS="-L$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/lib -I$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/include"
$(UBUNTU64)-rqemu-vars       := PKG_CONFIG_LIBDIR="$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib/pkgconfig" CFLAGS="-fPIC -I$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/include -Wno-unused-result" CPPFLAGS="-fPIC -I$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/include" QEMU_LDFLAGS="-L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib -L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib64" LIBS="-L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib -L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib64 -liconv" SIFIVE_LIBS_QGA="-L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib -L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib64 -liconv"
$(UBUNTU64)-rqemu-vars-ext   := PKG_CONFIG_LIBDIR="$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib/pkgconfig" CFLAGS="-fPIC -I$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/include -Wno-unused-result" CPPFLAGS="-fPIC -I$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/include" QEMU_LDFLAGS="-L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib -L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib64" LIBS="-L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib -L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib64 -lgmodule-2.0 -lffi -liconv -lresolv -ldl" SIFIVE_LIBS_QGA="-L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib -L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib64 -liconv"
$(UBUNTU64)-rqemu-host       := --host=x86_64-linux-gnu
$(UBUNTU64)-zlib-configure   := -static
$(UBUNTU64)-gettext-configure:= --enable-threads=posix
$(UBUNTU64)-glib-configure   := --enable-static
$(UBUNTU64)-glib-vars        := PKG_CONFIG_PATH="$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib/pkgconfig" CFLAGS="-fPIC -L$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/lib -I$(abspath $(OBJ_UBUNTU64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(UBUNTU64))/include"
$(UBUNTU64)-pixman-vars      := CFLAGS="-fPIC" CPPFLAGS="-fPIC"
$(UBUNTU64)-deps-vars        := CFLAGS="-fPIC"
$(DARWIN)-rqemu-vars         := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/include" CPPFLAGS="-I$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/include" QEMU_LDFLAGS="-L$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib" LIBS="-liconv -framework CoreFoundation -framework Carbon" SIFIVE_LIBS_QGA="-L$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib -liconv -framework CoreFoundation -framework Carbon" PATH=/usr/local/opt/gettext/bin:$(PATH)
$(DARWIN)-rqemu-vars-ext     := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-I$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/include" CPPFLAGS="-I$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/include" QEMU_LDFLAGS="-L$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib" LIBS="-lgmodule-2.0 -lffi -liconv -lresolv -framework CoreFoundation -framework Carbon" SIFIVE_LIBS_QGA="-L$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib -liconv -framework CoreFoundation -framework Carbon" PATH=/usr/local/opt/gettext/bin:$(PATH)
$(DARWIN)-gettext-configure  := --enable-threads=posix
$(DARWIN)-glib-configure     := --enable-static
$(DARWIN)-glib-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib/pkgconfig" CFLAGS="-L$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/lib -I$(abspath $(OBJ_DARWIN)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(DARWIN))/include" PATH=/usr/local/opt/gettext/bin:$(PATH)
$(REDHAT)-rqemu-vars         := PKG_CONFIG_LIBDIR="$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib/pkgconfig" CFLAGS="-fPIC -I$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/include -Wno-unused-result" CPPFLAGS="-fPIC -I$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/include" QEMU_LDFLAGS="-L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64" LIBS="-L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64 -liconv" SIFIVE_LIBS_QGA="-L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64 -liconv"
$(REDHAT)-rqemu-vars-ext     := PKG_CONFIG_LIBDIR="$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib/pkgconfig" CFLAGS="-fPIC -I$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/include -Wno-unused-result" CPPFLAGS="-fPIC -I$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/include" QEMU_LDFLAGS="-L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64" LIBS="-L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64 -lgmodule-2.0 -lffi -liconv -lresolv -ldl" SIFIVE_LIBS_QGA="-L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib -L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib64 -liconv"
$(REDHAT)-zlib-configure     := -static
$(REDHAT)-gettext-configure  := --enable-threads=posix
$(REDHAT)-glib-configure     := --enable-static
$(REDHAT)-glib-vars          := PKG_CONFIG_PATH="$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib/pkgconfig" CFLAGS="-fPIC -L$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/lib -I$(abspath $(OBJ_REDHAT)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(REDHAT))/include"
$(REDHAT)-pixman-vars        := CFLAGS="-fPIC" CPPFLAGS="-fPIC"
$(REDHAT)-deps-vars          := CFLAGS="-fPIC"

# Setup the package targets and switch into secondary makefile targets
# Targets $(PACKAGE_HEADING)/install.stamp and $(PACKAGE_HEADING)/libs.stamp
include ../../scripts/Package.mk

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/install.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/$(RISCV_QEMU_FOLDER)/build.stamp
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
	echo "PACKAGE_BUILD_ID = $(FREEDOM_QEMU_ID)$(EXTRA_SUFFIX)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_CORE_VER = $(RISCV_QEMU_VERSION)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_TARGET = $($@_TARGET)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_VENDOR = SiFive" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_RIGHTS = sifive-v00 eclipse-v20" >> $(abspath $($@_PROPERTIES))
	echo "RISCV_TAGS = $(FREEDOM_QEMU_RISCV_TAGS)" >> $(abspath $($@_PROPERTIES))
	echo "TOOLS_TAGS = $(FREEDOM_QEMU_TOOLS_TAGS)" >> $(abspath $($@_PROPERTIES))
	cp $(abspath $($@_PROPERTIES)) $(abspath $($@_INSTALL))/
	tclsh ../../scripts/check-maximum-path-length.tcl $(abspath $($@_INSTALL)) "$(PACKAGE_HEADING)" "$(RISCV_QEMU_VERSION)" "$(FREEDOM_QEMU_ID)$(EXTRA_SUFFIX)"
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
	tclsh ../../scripts/check-naming-and-version-syntax.tcl "$(PACKAGE_WORDING)" "$(PACKAGE_HEADING)" "$(RISCV_QEMU_VERSION)" "$(FREEDOM_QEMU_ID)$(EXTRA_SUFFIX)"
	rm -rf $($@_INSTALL)
	mkdir -p $($@_INSTALL)
	rm -rf $($@_BUILDLOG)
	mkdir -p $($@_BUILDLOG)
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	git log > $($@_BUILDLOG)/$(PACKAGE_HEADING)-git-commit.log
	git remote -v > $($@_BUILDLOG)/$(PACKAGE_HEADING)-git-remote.log
	cd $(dir $@); curl -L -f -s -o zlib-1.2.11.tar.gz http://zlib.net/fossils/zlib-1.2.11.tar.gz
	cd $(dir $@); $(TAR) -xf zlib-1.2.11.tar.gz
	cd $(dir $@); mv zlib-1.2.11 zlib
	cd $(dir $@); curl -L -f -s -o libffi-3.2.1.tar.gz http://mirrors.kernel.org/sourceware/libffi/libffi-3.2.1.tar.gz
	cd $(dir $@); $(TAR) -xf libffi-3.2.1.tar.gz
	cd $(dir $@); mv libffi-3.2.1 libffi
	cd $(dir $@); curl -L -f -s -o libiconv-1.15.tar.gz https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.15.tar.gz
	cd $(dir $@); $(TAR) -xf libiconv-1.15.tar.gz
	cd $(dir $@); mv libiconv-1.15 libiconv
	cd $(dir $@); curl -L -f -s -o gettext-0.19.8.1.tar.gz https://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.8.1.tar.gz
	cd $(dir $@); $(TAR) -xf gettext-0.19.8.1.tar.gz
	cd $(dir $@); mv gettext-0.19.8.1 gettext
	cd $(dir $@); curl -L -f -s -o glib-2.56.4.tar.xz http://ftp.acc.umu.se/pub/GNOME/sources/glib/2.56/glib-2.56.4.tar.xz
	cd $(dir $@); $(TAR) -xf glib-2.56.4.tar.xz
	cd $(dir $@); mv glib-2.56.4 glib
	cd $(dir $@); curl -L -f -s -o pixman-0.38.0.tar.gz https://cairographics.org/releases/pixman-0.38.0.tar.gz
	cd $(dir $@); $(TAR) -xf pixman-0.38.0.tar.gz
	cd $(dir $@); mv pixman-0.38.0 pixman
	git clone --single-branch --branch $(RISCV_QEMU_BRANCH) $(RISCV_QEMU_GITURL) $(dir $@)/$(RISCV_QEMU_FOLDER)
	cd $(dir $@)/$(RISCV_QEMU_FOLDER) && git checkout --detach $(RISCV_QEMU_COMMIT)
	cd $(dir $@)/$(RISCV_QEMU_FOLDER) && git submodule update --init --recursive
	rm -rf $(dir $@)/$(RISCV_QEMU_FOLDER)/target/riscv/cpu.c
	cp -a patches/qemu-riscv-cpu.c $(dir $@)/$(RISCV_QEMU_FOLDER)/target/riscv/cpu.c
	rm -rf $(dir $@)/$(RISCV_QEMU_FOLDER)/target/riscv/cpu.h
	cp -a patches/qemu-riscv-cpu.h $(dir $@)/$(RISCV_QEMU_FOLDER)/target/riscv/cpu.h
	rm -rf $(dir $@)/$(RISCV_QEMU_FOLDER)/hw/riscv/sifive_e.c
	cp -a patches/qemu-sifive-e.c $(dir $@)/$(RISCV_QEMU_FOLDER)/hw/riscv/sifive_e.c
	rm -rf $(dir $@)/$(RISCV_QEMU_FOLDER)/hw/riscv/sifive_test.c
	cp -a patches/qemu-sifive-test.c $(dir $@)/$(RISCV_QEMU_FOLDER)/hw/misc/sifive_test.c
	rm -rf $(dir $@)/$(RISCV_QEMU_FOLDER)/hw/riscv/sifive_u.c
	cp -a patches/qemu-sifive-u.c $(dir $@)/$(RISCV_QEMU_FOLDER)/hw/riscv/sifive_u.c
	rm -rf $(dir $@)/$(RISCV_QEMU_FOLDER)/include/hw/riscv/sifive_e.h
	cp -a patches/qemu-sifive-e.h $(dir $@)/$(RISCV_QEMU_FOLDER)/include/hw/riscv/sifive_e.h
	rm -rf $(dir $@)/$(RISCV_QEMU_FOLDER)/include/hw/riscv/sifive_u.h
	cp -a patches/qemu-sifive-u.h $(dir $@)/$(RISCV_QEMU_FOLDER)/include/hw/riscv/sifive_u.h
	rm -rf $(dir $@)/$(RISCV_QEMU_FOLDER)/util/meson.build
	cp -a patches/qemu-util-meson.build $(dir $@)/$(RISCV_QEMU_FOLDER)/util/meson.build
	rm -rf $(dir $@)/$(RISCV_QEMU_FOLDER)/net/can/meson.build
	cp -a patches/qemu-net-can-meson.build $(dir $@)/$(RISCV_QEMU_FOLDER)/net/can/meson.build
	$(SED) -i -f patches/qemu-configure.sed $(dir $@)/$(RISCV_QEMU_FOLDER)/configure
	$(SED) -i -f patches/qemu-common.sed $(dir $@)/$(RISCV_QEMU_FOLDER)/include/qemu-common.h
	$(SED) -i -f patches/qemu-vl.sed $(dir $@)/$(RISCV_QEMU_FOLDER)/softmmu/vl.c
	mkdir -p $(dir $($@_SRCBALL))
	cd $(dir $@); $(TAR) --dereference --hard-dereference -c zlib libffi libiconv gettext glib pixman $(RISCV_QEMU_FOLDER) | gzip > $($@_SRCBALL)
	date > $@

$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/zlib/build.stamp: \
		$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/zlib/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	cd $(dir $@) && $($(NATIVE)-deps-vars) ./configure \
		--prefix=$(abspath $(OBJ_NATIVE)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE)) \
		$($(NATIVE)-zlib-configure) &>$($@_BUILDLOG)/zlib-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/zlib-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/zlib-make-install.log
	date > $@

$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/zlib/build.stamp: \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/zlib/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	$(MAKE) -C $(dir $@) -f win32/Makefile.gcc PREFIX=$(WIN64)- prefix=$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/ &>$($@_BUILDLOG)/zlib-make-build.log
	$(MAKE) -j1 -C $(dir $@) -f win32/Makefile.gcc SHARED_MODE=1 install DESTDIR=$(abspath $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64))/ INCLUDE_PATH=include LIBRARY_PATH=lib BINARY_PATH=bin &>$($@_BUILDLOG)/zlib-make-install.log
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libffi/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/zlib/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/libffi/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/libffi/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/libffi/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/libffi/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	cd $(dir $@) && $($($@_TARGET)-deps-vars) ./configure \
		$($($@_TARGET)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static &>$($@_BUILDLOG)/libffi-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/libffi-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/libffi-make-install.log
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libiconv/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libffi/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/libiconv/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/libiconv/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/libiconv/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/libiconv/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	cd $(dir $@) && $($($@_TARGET)-deps-vars) ./configure \
		$($($@_TARGET)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static &>$($@_BUILDLOG)/libiconv-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/libiconv-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/libiconv-make-install.log
	date > $@

$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/gettext/build.stamp: \
		$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/libiconv/build.stamp \
		$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/gettext/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/gettext/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/gettext/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	cd $(dir $@) && $($(NATIVE)-deps-vars) ./configure \
		$($(NATIVE)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static \
		$($(NATIVE)-gettext-configure) &>$($@_BUILDLOG)/gettext-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/gettext-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/gettext-make-install.log
	date > $@

$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/gettext/build.stamp: \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/libiconv/build.stamp \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/gettext/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/gettext/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/gettext/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	# https://spacegit.unibe.ch/open-source/crosstool-ng/blob/a1b4ec3b176683817ba128ebb87117725cfa5d20/patches/gettext/0.19.6/110-Fix-linker-error-redefinition-of-vasprintf.patch
	$(SED) -i -f patches/gettext-gnu-source.sed $(dir $@)/gettext-runtime/libasprintf/autosprintf.cc
	$(SED) -i -f patches/gettext-gnu-source.sed $(dir $@)/gettext-runtime/libasprintf/vasnprintf.c
	cd $(dir $@) && $($(WIN64)-deps-vars) ./configure \
		$($(WIN64)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static \
		$($(WIN64)-gettext-configure) &>$($@_BUILDLOG)/gettext-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/gettext-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/gettext-make-install.log
	date > $@

$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/glib/build.stamp: \
		$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/gettext/build.stamp \
		$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/glib/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/glib/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/glib/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	mkdir -p $(dir $@)/gio/lib
	cd $(dir $@) && $($(NATIVE)-glib-vars) ./configure \
		$($(NATIVE)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		$($(NATIVE)-glib-configure) \
		--with-libiconv=gnu \
		--without-pcre \
		--disable-selinux \
		--disable-fam \
		--disable-xattr \
		--disable-libelf \
		--disable-libmount \
		--disable-dtrace \
		--disable-systemtap \
		--disable-coverage \
		--disable-Bsymbolic \
		--disable-znodelete \
		--disable-compile-warnings \
		--disable-installed-tests \
		--disable-always-build-tests &>$($@_BUILDLOG)/glib-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/glib-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/glib-make-install.log
	rm -rf $(abspath $($@_INSTALL))/share/gdb
	date > $@

$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/glib/build.stamp: \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/gettext/build.stamp \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/glib/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/glib/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/glib/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	mkdir -p $(dir $@)/gio/lib
	$(SED) -i -f patches/glib-var-extern.sed $(dir $@)/glib/gtypes.h
	# https://github.com/msys2/MINGW-packages/blob/master/mingw-w64-glib2/0001-win32-Make-the-static-build-work-with-MinGW-when-pos.patch
	$(SED) -i -f patches/glib-dllmain-off.sed $(dir $@)/glib/glib-init.c
	$(SED) -i -f patches/glib-dllmain-off.sed $(dir $@)/gobject/gtype.c
	cd $(dir $@) && $($(WIN64)-glib-vars) ./configure \
		$($(WIN64)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		$($(WIN64)-glib-configure) \
		--with-libiconv=gnu \
		--without-pcre \
		--disable-selinux \
		--disable-fam \
		--disable-xattr \
		--disable-libelf \
		--disable-libmount \
		--disable-dtrace \
		--disable-systemtap \
		--disable-coverage \
		--disable-Bsymbolic \
		--disable-znodelete \
		--disable-compile-warnings \
		--disable-installed-tests \
		--disable-always-build-tests &>$($@_BUILDLOG)/glib-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/glib-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/glib-make-install.log
	rm -rf $(abspath $($@_INSTALL))/share/gdb
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/pixman/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/libffi/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/pixman/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/pixman/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/pixman/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/pixman/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	mkdir -p $(dir $@)/test/lib
	cd $(dir $@) && $($($@_TARGET)-pixman-vars) ./configure \
		$($($@_TARGET)-rqemu-host) \
		--prefix=$(abspath $($@_INSTALL)) \
		--enable-static \
		--with-gnu-ld \
		--disable-static-testprogs &>$($@_BUILDLOG)/pixman-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/pixman-make-build.log
	$(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/pixman-make-install.log
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/$(RISCV_QEMU_FOLDER)/build.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/glib/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/pixman/build.stamp \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/$(RISCV_QEMU_FOLDER)/build.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/$(RISCV_QEMU_FOLDER)/build.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/$(RISCV_QEMU_FOLDER)/build.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/$(RISCV_QEMU_FOLDER)/build.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	rm -f $(abspath $($@_INSTALL))/lib/lib*.dylib*
	rm -f $(abspath $($@_INSTALL))/lib/lib*.so*
	rm -f $(abspath $($@_INSTALL))/lib64/lib*.so*
	cd $(dir $@) && $($($@_TARGET)-rqemu-vars) ./configure \
		$($($@_TARGET)-rqemu-cross) \
		--prefix=$(abspath $($@_INSTALL))$($($@_TARGET)-rqemu-bindir) \
		--with-pkgversion="SiFive QEMU $(PACKAGE_VERSION)" \
		--target-list=riscv32-softmmu,riscv64-softmmu \
		--interp-prefix=$(abspath $($@_INSTALL))/sysroot \
		--disable-docs \
		--disable-modules \
		--disable-module-upgrades \
		--disable-sparse \
		--disable-safe-stack \
		--disable-gnutls \
		--disable-nettle \
		--disable-gcrypt \
		--disable-auth-pam \
		--disable-sdl \
		--disable-sdl-image \
		--disable-gtk \
		--disable-vte \
		--disable-vnc-sasl \
		--disable-vnc-jpeg \
		--disable-vnc-png \
		--disable-virtfs \
		--disable-mpath \
		--disable-xen \
		--disable-xen-pci-passthrough \
		--disable-brlapi \
		--disable-curl \
		--disable-membarrier \
		--disable-rdma \
		--disable-pvrdma \
		--disable-vde \
		--disable-netmap \
		--disable-linux-aio \
		--disable-linux-io-uring \
		--disable-cap-ng \
		--disable-vhost-kernel \
		--disable-vhost-user \
		--disable-vhost-user-blk-server \
		--disable-vhost-vdpa \
		--disable-spice \
		--disable-rbd \
		--disable-libiscsi \
		--disable-libnfs \
		--disable-smartcard \
		--disable-libusb \
		--disable-usb-redir \
		--disable-lzo \
		--disable-snappy \
		--disable-bzip2 \
		--disable-lzfse \
		--disable-zstd \
		--disable-seccomp \
		--disable-glusterfs \
		--disable-tpm \
		--disable-libssh \
		--disable-numa \
		--disable-libxml2 \
		--disable-tcmalloc \
		--disable-jemalloc \
		--disable-avx2 \
		--disable-avx512f \
		--disable-opengl \
		--disable-virglrenderer \
		--disable-xfsctl \
		--disable-crypto-afalg \
		--disable-debug-mutex \
		--disable-libpmem \
		--disable-libdaxctl \
		--disable-curses \
		--disable-iconv \
		--enable-vnc \
		--enable-bochs \
		--enable-cloop \
		--enable-dmg \
		--enable-qcow1 \
		--enable-vdi \
		--enable-vvfat \
		--enable-qed \
		--enable-parallels \
		--enable-sheepdog \
		--enable-rng-none \
		--enable-fdt=git \
		&>$($@_BUILDLOG)/$(RISCV_QEMU_FOLDER)-make-configure.log
	$($($@_TARGET)-rqemu-vars-ext) $(MAKE) -C $(dir $@) -j1 install &>$($@_BUILDLOG)/$(RISCV_QEMU_FOLDER)-make-install.log
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/qemu-edid
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/qemu-ga
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/qemu-img
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/qemu-io
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/qemu-nbd
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/qemu-storage-daemon
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/qemu-system-riscv32
	tclsh ../../scripts/dyn-lib-check-$($@_TARGET).tcl $(abspath $($@_INSTALL))/bin/qemu-system-riscv64
	date > $@

$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/test.stamp: \
		$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/launch.stamp
	mkdir -p $(dir $@)
	PATH=$(abspath $(OBJDIR)/$(NATIVE)/launch/$(PACKAGE_TARNAME)/bin):$(PATH) qemu-system-riscv32 -version
	PATH=$(abspath $(OBJDIR)/$(NATIVE)/launch/$(PACKAGE_TARNAME)/bin):$(PATH) qemu-system-riscv64 -version
	@echo "Finished testing $(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).tar.gz tarball"
	date > $@
