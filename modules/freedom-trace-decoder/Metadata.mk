include ../freedom-binutils-metal/Metadata.mk

# Git repos, branches, commits and folders to get source code for the tool we are building
TRACE_DECODER_GITURL := git@github.com:sifive/trace-decoder.git
TRACE_DECODER_BRANCH := master
TRACE_DECODER_COMMIT := 7f39506b39e49320b6dd51a53abc08aedabfaf8b
TRACE_DECODER_FOLDER := trace-decoder

# Version number, which should match the official version of the tool we are building
TRACE_DECODER_VERSION := 0.10.5

# Customization ID, which should identify the customization added to the original by SiFive
FREEDOM_TRACE_DECODER_ID := 2020.12.0-preview1

# Characteristic tags, which should be usable for matching up providers and consumers
FREEDOM_TRACE_DECODER_RISCV_TAGS = rv32i rv64i m a f d c v zfh zba zbb
FREEDOM_TRACE_DECODER_TOOLS_TAGS = trace-decoder
