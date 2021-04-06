# The default target
.PHONY: all
all:
	@echo " Makefile targets: package regress cleanup flushup clean flush help all"

.PHONY: help
help:
	@echo ""
	@echo " SiFive Freedom Tools - Makefile targets:"
	@echo ""
	@echo " package"
	@echo "   Build the binary packages for this repo."
	@echo ""
	@echo " regress"
	@echo "   Test the prebuilt packages for this repo."
	@echo ""
	@echo " cleanup"
	@echo "   Clean the build artifacts for this repo."
	@echo ""
	@echo " flushup"
	@echo "   Flush the build artifacts for this repo."
	@echo ""
	@echo " clean"
	@echo "   Remove the bin and obj directories."
	@echo ""
	@echo " flush"
	@echo "   Remove the obj directory."
	@echo ""
	@echo " help"
	@echo "   Show this help."
	@echo ""
	@echo " all"
	@echo "   Show Makefile targets."
	@echo ""

.PHONY: package native-package cross-package
package:
native-package:
cross-package:

.PHONY: regress
regress:

# Make uses /bin/sh by default, ignoring the user's value of SHELL.
# Some systems now ship with /bin/sh pointing at dash, and this Makefile
# requires bash
SHELL = /bin/bash

BINDIR_PREFIX ?= ../../
OBJDIR_PREFIX ?= ../../
BINDIR := $(BINDIR_PREFIX)bin
OBJDIR := $(OBJDIR_PREFIX)obj

UBUNTU64 ?= x86_64-linux-ubuntu14
REDHAT ?= x86_64-linux-centos6
WIN64  ?= x86_64-w64-mingw32
DARWIN ?= x86_64-apple-darwin

-include /etc/lsb-release
ifneq ($(wildcard /etc/redhat-release),)
NATIVE ?= $(REDHAT)
NINJA ?= ninja-build
package: redhat-package
native-package: redhat-package
regress: native-regress
else ifeq ($(DISTRIB_ID),Ubuntu)
NATIVE ?= $(UBUNTU64)
CROSS ?= $(WIN64)
package: ubuntu64-package
native-package: ubuntu64-package
package: win64-package
cross-package: win64-package
regress: native-regress
else ifeq ($(shell uname),Darwin)
NATIVE ?= $(DARWIN)
LIBTOOLIZE ?= glibtoolize
TAR ?= gtar
SED ?= gsed
AWK ?= gawk
package: darwin-package
native-package: darwin-package
regress: native-regress
else ifneq ($(wildcard /mingw64/etc),)
NATIVE ?= $(WIN64)
regress: native-regress
else
$(error Unknown host)
endif

LIBTOOLIZE ?= libtoolize
TAR ?= tar
SED ?= sed
AWK ?= awk
NINJA ?= ninja

OBJ_NATIVE   := $(OBJDIR)/$(NATIVE)
OBJ_CROSS    := $(OBJDIR)/$(CROSS)
OBJ_UBUNTU64 := $(OBJDIR)/$(UBUNTU64)
OBJ_WIN64    := $(OBJDIR)/$(WIN64)
OBJ_DARWIN   := $(OBJDIR)/$(DARWIN)
OBJ_REDHAT   := $(OBJDIR)/$(REDHAT)

# Targets that don't build anything
.PHONY: clean
clean::
	rm -rf $(OBJDIR) $(BINDIR)

.PHONY: flush
flush::
	rm -rf $(OBJDIR)
