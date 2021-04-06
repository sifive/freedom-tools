$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/extra-binutils/transit.stamp: \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/source.stamp
	$(eval $@_EXTRA := $(patsubst %/build/$(PACKAGE_HEADING)/extra-binutils/transit.stamp,%/build/$(PACKAGE_HEADING)/extra-install,$@))
	$(eval $@_BUILD := $(patsubst %/build/$(PACKAGE_HEADING)/extra-binutils/transit.stamp,%/build/$(PACKAGE_HEADING),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/extra-binutils/transit.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	# Workaround for CentOS random build fail issue
	#
	# Corresponding bugzilla entry on upstream:
	# https://sourceware.org/bugzilla/show_bug.cgi?id=22941
	touch $(abspath $($@_BUILD))/$(RISCV_BINUTILS_FOLDER)/intl/plural.c
# CC_FOR_TARGET is required for the ld testsuite.
	cd $(dir $@) && CC_FOR_TARGET=$(BARE_METAL_CC_FOR_TARGET) $(abspath $($@_BUILD))/$(RISCV_BINUTILS_FOLDER)/configure \
		--target=$(BARE_METAL_TUPLE) \
		$($(NATIVE)-binutils-host) \
		--prefix=$(abspath $($@_EXTRA)) \
		--with-pkgversion="SiFive Binutils-Metal $(PACKAGE_VERSION)" \
		--with-bugurl="https://github.com/sifive/freedom-tools/issues" \
		--disable-werror \
		--disable-gdb \
		--disable-sim \
		--disable-libdecnumber \
		--disable-libreadline \
		--with-expat=no \
		--with-mpc=no \
		--with-mpfr=no \
		--with-gmp=no \
		$($(NATIVE)-binutils-configure) \
		CFLAGS="-O2" \
		CXXFLAGS="-O2" &>$($@_BUILDLOG)/extra-binutils-make-configure.log
	$(MAKE) -C $(dir $@) &>$($@_BUILDLOG)/extra-binutils-make-build.log
	date > $@
