# Git repos, branches, commits and folders to get source code for the tool we are building
RISCV_QEMU_GITURL := git@github.com:sifive/qemu.git
RISCV_QEMU_BRANCH := v5.2.0-rvv-rvb-zfh
RISCV_QEMU_COMMIT := 3870dd3ef58a5c74673388785ad3bfa655af23a4
RISCV_QEMU_FOLDER := riscv-qemu

# Version number, which should match the official version of the tool we are building
RISCV_QEMU_VERSION := 5.2.0

# Customization ID, which should identify the customization added to the original by SiFive
FREEDOM_QEMU_ID := 2020.12.0-preview1

# Characteristic tags, which should be usable for matching up providers and consumers
FREEDOM_QEMU_RISCV_TAGS = rv32i rv64i m a f d c v zfh zba zbb
FREEDOM_QEMU_TOOLS_TAGS = qemu
