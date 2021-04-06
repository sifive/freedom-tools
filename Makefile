# Reuse the default target
.PHONY: package
package: all

.PHONY: regress
regress: all

.PHONY: cleanup
cleanup: all

.PHONY: flushup
flushup: all

# Make uses /bin/sh by default, ignoring the user's value of SHELL.
# Some systems now ship with /bin/sh pointing at dash, and this Makefile
# requires bash
SHELL = /bin/bash

BINDIR_PREFIX ?= ./
OBJDIR_PREFIX ?= ./
BINDIR := $(BINDIR_PREFIX)bin
OBJDIR := $(OBJDIR_PREFIX)obj

# The default target
.PHONY: all
all:
	@echo " Makefile modules: *-*package *-*regress *-*cleanup *-*flushup clean flush help all"

.PHONY: help
help:
	@echo ""
	@echo " SiFive Freedom Tools - Makefile modules:"
	@echo ""
	@echo " *-package, *-native-package, *-cross-package"
	@echo "   Build the binary packages for * repo."
	@echo ""
	@echo " *-regress, *-native-regress, *-cross-regress"
	@echo "   Test the prebuilt packages for * repo."
	@echo ""
	@echo " *-cleanup, *-native-cleanup, *-cross-cleanup"
	@echo "   Clean the build artifacts for * repo."
	@echo ""
	@echo " *-flushup, *-native-flushup, *-cross-flushup"
	@echo "   Flush the build artifacts for * repo."
	@echo ""
	@echo " clean"
	@echo "   Remove the obj and bin directories."
	@echo ""
	@echo " flush"
	@echo "   Remove the obj directory."
	@echo ""
	@echo " help"
	@echo "   Show this help."
	@echo ""
	@echo " all"
	@echo "   Show Makefile modules."
	@echo ""
	@echo " * refers to an item from the package list"
	@echo "   toolchain-metal"
	@echo "   binutils-metal"
	@echo "   gcc-metal"
	@echo "   gdb-metal"
	@echo "   qemu"
	@echo "   sdk-utilities"
	@echo "   openocd"
	@echo "   trace-decoder"
	@echo "   xc3sprog"
	@echo ""
	@echo " TARGET_BRANCH can be set for a package to"
	@echo " override the one in freedom-*.mk files."
	@echo ""

# Include Makefiles for all modules
include modules/freedom-binutils-metal/Monorepo.mk
include modules/freedom-gcc-metal/Monorepo.mk
include modules/freedom-gdb-metal/Monorepo.mk
include modules/freedom-toolchain-metal/Monorepo.mk
include modules/freedom-qemu/Monorepo.mk
include modules/freedom-sdk-utilities/Monorepo.mk
include modules/freedom-openocd/Monorepo.mk
include modules/freedom-trace-decoder/Monorepo.mk
include modules/freedom-xc3sprog/Monorepo.mk

# Targets that don't build anything
.PHONY: clean
clean::
	rm -rf $(OBJDIR) $(BINDIR)

.PHONY: flush
flush::
	rm -rf $(OBJDIR)
