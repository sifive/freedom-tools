
# which gcc compiler to use for compiling spike-dasm
HOST_PREFIX ?=

# optional prefix for spike-asm executable
EXEC_PREFIX ?=

# optional prefix for spike-asm executable
EXEC_SUFFIX ?=

# where to find the source files for a spike-dasm build
SOURCE_PATH ?=.

# where to install all the artifacts of a spike-dasm build
INSTALL_PATH ?=./install

# which source files to use for compiling spike-dasm
SOURCE_FILES = \
		$(SOURCE_PATH)/fesvr/option_parser.cc \
		$(SOURCE_PATH)/riscv/regnames.cc \
		$(SOURCE_PATH)/riscv/extensions.cc \
		$(SOURCE_PATH)/spike_main/disasm.cc \
		$(SOURCE_PATH)/spike_main/spike-dasm.cc

# which include paths to use for compiling spike-dasm
INCLUDE_PATHS = \
		-I. \
		-I$(SOURCE_PATH) \
		-I$(SOURCE_PATH)/fesvr \
		-I$(SOURCE_PATH)/riscv \
		-I$(SOURCE_PATH)/softfloat

# the full name of the spike-asm executable inluding all prefix and suffix
EXEC_ALLFIX = $(EXEC_PREFIX)spike-dasm$(EXEC_SUFFIX)

.PHONY: all install
all: $(EXEC_ALLFIX)

$(EXEC_ALLFIX): $(SOURCE_FILES)
	$(HOST_PREFIX)g++ -Wall -Wno-unused -std=c++11 $(INCLUDE_PATHS) -o $@ $(SOURCE_FILES)

install: $(EXEC_ALLFIX)
	rm -rf $(INSTALL_PATH)/bin/$(EXEC_ALLFIX)
	mkdir -p $(INSTALL_PATH)/bin
	cp $(EXEC_ALLFIX) $(INSTALL_PATH)/bin/$(EXEC_ALLFIX)

clean:
	rm -rf $(EXEC_ALLFIX)
