# Git repos, branches, commits and folders to get source code for the tool we are building
RISCV_ISA_SIM_GITURL := git@github.com:riscv/riscv-isa-sim.git
RISCV_ISA_SIM_BRANCH := master
RISCV_ISA_SIM_COMMIT := f1bcfac7ebe334ebdef39a5d59e18e37eef813a5
RISCV_ISA_SIM_FOLDER := riscv-isa-sim
FREEDOM_ELF2HEX_GITURL := git@github.com:sifive/freedom-elf2hex.git
FREEDOM_ELF2HEX_BRANCH := master
FREEDOM_ELF2HEX_COMMIT := 7bcc57b85fdb7002dffb6e7515d8b8ecac32cfcd
FREEDOM_ELF2HEX_FOLDER := freedom-elf2hex

# Version number, which should match the official version of the tool we are building
RISCV_ISA_SIM_VERSION := 1.0.1

# Customization ID, which should identify the customization added to the original by SiFive
FREEDOM_SDK_UTILITIES_ID := 2020.12.1

# Characteristic tags, which should be usable for matching up providers and consumers
FREEDOM_SDK_UTILITIES_RISCV_TAGS = rv32i rv64i m a f d c v zfh zba zbb
FREEDOM_SDK_UTILITIES_TOOLS_TAGS = dtc libfdt elf2hex zspike-dasm
