
# which g++ compiler to use for compiling spike-dasm
CROSSPREFIX ?=

# optional prefix for spike-asm executable
EXEC_PREFIX ?=

# optional prefix for spike-asm executable
BINEXT ?=

# which g++ compiler to use for compiling spike-dasm
CXX ?=

# where to find the source files for a spike-dasm build
SOURCE_PATH ?=.

# where to install all the artifacts of a spike-dasm build
INSTALL_PATH ?=./install

# which source files to use for compiling spike-dasm
SOURCE_FILES = \
		$(SOURCE_PATH)/riscv/extensions.cc \
		$(SOURCE_PATH)/disasm/regnames.cc \
		$(SOURCE_PATH)/disasm/disasm.cc \
		$(SOURCE_PATH)/spike_dasm/spike_dasm_option_parser.cc \
		$(SOURCE_PATH)/spike_dasm/spike-dasm.cc

# which include paths to use for compiling spike-dasm
INCLUDE_PATHS = \
		-I. \
		-I$(SOURCE_PATH) \
		-I$(SOURCE_PATH)/fesvr \
		-I$(SOURCE_PATH)/riscv \
		-I$(SOURCE_PATH)/softfloat

# the full name of the spike-asm executable inluding all prefix and suffix
EXEC_ALLFIX = $(EXEC_PREFIX)spike-dasm$(BINEXT)

.PHONY: all install
all: $(EXEC_ALLFIX)

$(EXEC_ALLFIX): $(SOURCE_FILES)
	$(CROSSPREFIX)$(CXX) -Wall -Wno-unused -std=c++11 $(INCLUDE_PATHS) -o $@ $(SOURCE_FILES)

install: $(EXEC_ALLFIX)
	rm -rf $(INSTALL_PATH)/bin/$(EXEC_ALLFIX)
	mkdir -p $(INSTALL_PATH)/bin
	cp $(EXEC_ALLFIX) $(INSTALL_PATH)/bin/$(EXEC_ALLFIX)

clean:
	rm -rf $(EXEC_ALLFIX)
