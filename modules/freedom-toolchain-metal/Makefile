# Setup the Freedom build script environment
include ../../scripts/Freedom.mk

# Include version identifiers to build up the full version string
include Metadata.mk
PACKAGE_WORDING := Bare Metal Toolchain
PACKAGE_HEADING := riscv64-unknown-elf-toolchain
PACKAGE_VERSION := $(RISCV_TOOLCHAIN_VERSION)-$(FREEDOM_TOOLCHAIN_METAL_ID)$(EXTRA_SUFFIX)
PACKAGE_COMMENT := \# SiFive Freedom Package Properties File

# Some special package references for specific targets
NATIVE_BINUTILS_TARBALL = $(wildcard $(BINDIR)/riscv64-unknown-elf-binutils-*-$(NATIVE).tar.gz)
NATIVE_GCC_TARBALL = $(wildcard $(BINDIR)/riscv64-unknown-elf-gcc-*-$(NATIVE).tar.gz)
NATIVE_GDB_TARBALL = $(wildcard $(BINDIR)/riscv64-unknown-elf-gdb-*-$(NATIVE).tar.gz)
WIN64_BINUTILS_TARBALL = $(wildcard $(BINDIR)/riscv64-unknown-elf-binutils-*-$(WIN64).tar.gz)
WIN64_GCC_TARBALL = $(wildcard $(BINDIR)/riscv64-unknown-elf-gcc-*-$(WIN64).tar.gz)
WIN64_GDB_TARBALL = $(wildcard $(BINDIR)/riscv64-unknown-elf-gdb-*-$(WIN64).tar.gz)

# Setup the package targets and switch into secondary makefile targets
# Targets $(PACKAGE_HEADING)/install.stamp and $(PACKAGE_HEADING)/libs.stamp
include ../../scripts/Package.mk

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/install.stamp: \
		$(OBJDIR)/%/build/$(PACKAGE_HEADING)/build-gdb/build.stamp
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/install.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/install.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_PROPERTIES := $(patsubst %/build/$(PACKAGE_HEADING)/install.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET).properties,$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/install.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	mkdir -p $(dir $@)
	git log --format="[%ad] %s" > $(abspath $($@_INSTALL))/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET).changelog
	rm -f $(abspath $($@_PROPERTIES))
	echo "$(PACKAGE_COMMENT)" > $(abspath $($@_PROPERTIES))
	echo "PACKAGE_TYPE = freedom-tools" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_DESC_SEG = $(PACKAGE_WORDING)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_FIXED_ID = $(PACKAGE_HEADING)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_BUILD_ID = $(FREEDOM_TOOLCHAIN_METAL_ID)$(EXTRA_SUFFIX)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_CORE_VER = $(RISCV_TOOLCHAIN_VERSION)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_TARGET = $($@_TARGET)" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_VENDOR = SiFive" >> $(abspath $($@_PROPERTIES))
	echo "PACKAGE_RIGHTS = sifive-v00 eclipse-v20" >> $(abspath $($@_PROPERTIES))
	echo "RISCV_TAGS = $(FREEDOM_TOOLCHAIN_METAL_RISCV_TAGS)" >> $(abspath $($@_PROPERTIES))
	echo "TOOLS_TAGS = $(FREEDOM_TOOLCHAIN_METAL_TOOLS_TAGS)" >> $(abspath $($@_PROPERTIES))
	cp $(abspath $($@_PROPERTIES)) $(abspath $($@_INSTALL))/
	tclsh ../../scripts/check-maximum-path-length.tcl $(abspath $($@_INSTALL)) "$(PACKAGE_HEADING)" "$(RISCV_TOOLCHAIN_VERSION)" "$(FREEDOM_TOOLCHAIN_METAL_ID)$(EXTRA_SUFFIX)"
	tclsh ../../scripts/check-same-name-different-case.tcl $(abspath $($@_INSTALL))
	echo $(PATH)
	date > $@

# We might need some extra target libraries for this package
$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/libs.stamp: \
		$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/install.stamp
	date > $@

$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/libs.stamp: \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/install.stamp
	date > $@

$(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp:
	$(eval $@_TARGET := $(patsubst $(OBJDIR)/%/build/$(PACKAGE_HEADING)/source.stamp,%,$@))
	$(eval $@_INSTALL := $(patsubst %/build/$(PACKAGE_HEADING)/source.stamp,%/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$($@_TARGET),$@))
	$(eval $@_BUILDLOG := $(abspath $(patsubst %/build/$(PACKAGE_HEADING)/source.stamp,%/buildlog/$(PACKAGE_HEADING),$@)))
	tclsh ../../scripts/check-naming-and-version-syntax.tcl "$(PACKAGE_WORDING)" "$(PACKAGE_HEADING)" "$(RISCV_TOOLCHAIN_VERSION)" "$(FREEDOM_TOOLCHAIN_METAL_ID)$(EXTRA_SUFFIX)"
	rm -rf $($@_INSTALL)
	mkdir -p $($@_INSTALL)
	rm -rf $($@_BUILDLOG)
	mkdir -p $($@_BUILDLOG)
	rm -rf $(dir $@)
	mkdir -p $(dir $@)
	git log > $($@_BUILDLOG)/$(PACKAGE_HEADING)-git-commit.log
	git remote -v > $($@_BUILDLOG)/$(PACKAGE_HEADING)-git-remote.log
	date > $@

$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/build-binutils/build.stamp: \
		$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/source.stamp
ifneq ($(NATIVE_BINUTILS_TARBALL),)
	$(eval $@_TARNAME = $(basename $(basename $(notdir $(NATIVE_BINUTILS_TARBALL)))))
	mkdir -p $(OBJ_NATIVE)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE)
	rm -rf $(OBJ_NATIVE)/install/$($@_TARNAME)
	$(TAR) -xz -C $(OBJ_NATIVE)/install -f $(NATIVE_BINUTILS_TARBALL)
	cp $(OBJ_NATIVE)/install/$($@_TARNAME)/$($@_TARNAME).properties $(OBJ_NATIVE)/buildlog/$(PACKAGE_HEADING)/
	rm -f $(OBJ_NATIVE)/install/$($@_TARNAME)/$($@_TARNAME).properties
	cp -RL $(OBJ_NATIVE)/install/$($@_TARNAME)/* $(OBJ_NATIVE)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE)/
	rm -rf $(BINDIR)/$($@_TARNAME).properties
	rm -rf $(BINDIR)/$($@_TARNAME).tar.gz
	rm -rf $(BINDIR)/$($@_TARNAME).zip
endif
	mkdir -p $(dir $@)
	date > $@

$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/build-gcc/build.stamp: \
		$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/build-binutils/build.stamp
ifneq ($(NATIVE_GCC_TARBALL),)
	$(eval $@_TARNAME = $(basename $(basename $(notdir $(NATIVE_GCC_TARBALL)))))
	mkdir -p $(OBJ_NATIVE)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE)
	rm -rf $(OBJ_NATIVE)/install/$($@_TARNAME)
	$(TAR) -xz -C $(OBJ_NATIVE)/install -f $(NATIVE_GCC_TARBALL)
	cp $(OBJ_NATIVE)/install/$($@_TARNAME)/$($@_TARNAME).properties $(OBJ_NATIVE)/buildlog/$(PACKAGE_HEADING)/
	rm -f $(OBJ_NATIVE)/install/$($@_TARNAME)/$($@_TARNAME).properties
	cp -RL $(OBJ_NATIVE)/install/$($@_TARNAME)/* $(OBJ_NATIVE)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE)/
	rm -rf $(BINDIR)/$($@_TARNAME).properties
	rm -rf $(BINDIR)/$($@_TARNAME).tar.gz
	rm -rf $(BINDIR)/$($@_TARNAME).zip
endif
	mkdir -p $(dir $@)
	date > $@

$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/build-gdb/build.stamp: \
		$(OBJ_NATIVE)/build/$(PACKAGE_HEADING)/build-gcc/build.stamp
ifneq ($(NATIVE_GDB_TARBALL),)
	$(eval $@_TARNAME = $(basename $(basename $(notdir $(NATIVE_GDB_TARBALL)))))
	mkdir -p $(OBJ_NATIVE)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE)
	rm -rf $(OBJ_NATIVE)/install/$($@_TARNAME)
	$(TAR) -xz -C $(OBJ_NATIVE)/install -f $(NATIVE_GDB_TARBALL)
	cp $(OBJ_NATIVE)/install/$($@_TARNAME)/$($@_TARNAME).properties $(OBJ_NATIVE)/buildlog/$(PACKAGE_HEADING)/
	rm -f $(OBJ_NATIVE)/install/$($@_TARNAME)/$($@_TARNAME).properties
	cp -RL $(OBJ_NATIVE)/install/$($@_TARNAME)/* $(OBJ_NATIVE)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE)/
	rm -rf $(BINDIR)/$($@_TARNAME).properties
	rm -rf $(BINDIR)/$($@_TARNAME).tar.gz
	rm -rf $(BINDIR)/$($@_TARNAME).zip
endif
	mkdir -p $(dir $@)
	date > $@

$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/build-binutils/build.stamp: \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/source.stamp
ifneq ($(WIN64_BINUTILS_TARBALL),)
	$(eval $@_TARNAME = $(basename $(basename $(notdir $(WIN64_BINUTILS_TARBALL)))))
	mkdir -p $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)
	rm -rf $(OBJ_WIN64)/install/$($@_TARNAME)
	$(TAR) -xz -C $(OBJ_WIN64)/install -f $(WIN64_BINUTILS_TARBALL)
	cp $(OBJ_WIN64)/install/$($@_TARNAME)/$($@_TARNAME).properties $(OBJ_WIN64)/buildlog/$(PACKAGE_HEADING)/
	rm -f $(OBJ_WIN64)/install/$($@_TARNAME)/$($@_TARNAME).properties
	cp -RL $(OBJ_WIN64)/install/$($@_TARNAME)/* $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/
	rm -rf $(BINDIR)/$($@_TARNAME).properties
	rm -rf $(BINDIR)/$($@_TARNAME).tar.gz
	rm -rf $(BINDIR)/$($@_TARNAME).zip
endif
	mkdir -p $(dir $@)
	date > $@

$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/build-gcc/build.stamp: \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/build-binutils/build.stamp
ifneq ($(WIN64_GCC_TARBALL),)
	$(eval $@_TARNAME = $(basename $(basename $(notdir $(WIN64_GCC_TARBALL)))))
	mkdir -p $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)
	rm -rf $(OBJ_WIN64)/install/$($@_TARNAME)
	$(TAR) -xz -C $(OBJ_WIN64)/install -f $(WIN64_GCC_TARBALL)
	cp $(OBJ_WIN64)/install/$($@_TARNAME)/$($@_TARNAME).properties $(OBJ_WIN64)/buildlog/$(PACKAGE_HEADING)/
	rm -f $(OBJ_WIN64)/install/$($@_TARNAME)/$($@_TARNAME).properties
	cp -RL $(OBJ_WIN64)/install/$($@_TARNAME)/* $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/
	rm -rf $(BINDIR)/$($@_TARNAME).properties
	rm -rf $(BINDIR)/$($@_TARNAME).tar.gz
	rm -rf $(BINDIR)/$($@_TARNAME).zip
endif
	mkdir -p $(dir $@)
	date > $@

$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/build-gdb/build.stamp: \
		$(OBJ_WIN64)/build/$(PACKAGE_HEADING)/build-gcc/build.stamp
ifneq ($(WIN64_GDB_TARBALL),)
	$(eval $@_TARNAME = $(basename $(basename $(notdir $(WIN64_GDB_TARBALL)))))
	mkdir -p $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)
	rm -rf $(OBJ_WIN64)/install/$($@_TARNAME)
	$(TAR) -xz -C $(OBJ_WIN64)/install -f $(WIN64_GDB_TARBALL)
	cp $(OBJ_WIN64)/install/$($@_TARNAME)/$($@_TARNAME).properties $(OBJ_WIN64)/buildlog/$(PACKAGE_HEADING)/
	rm -f $(OBJ_WIN64)/install/$($@_TARNAME)/$($@_TARNAME).properties
	cp -RL $(OBJ_WIN64)/install/$($@_TARNAME)/* $(OBJ_WIN64)/install/$(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(WIN64)/
	rm -rf $(BINDIR)/$($@_TARNAME).properties
	rm -rf $(BINDIR)/$($@_TARNAME).tar.gz
	rm -rf $(BINDIR)/$($@_TARNAME).zip
endif
	mkdir -p $(dir $@)
	date > $@

$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/test.stamp: \
		$(OBJDIR)/$(NATIVE)/test/$(PACKAGE_HEADING)/launch.stamp
	mkdir -p $(dir $@)
	@echo "Finished testing $(PACKAGE_HEADING)-$(PACKAGE_VERSION)-$(NATIVE).tar.gz tarball"
	date > $@
