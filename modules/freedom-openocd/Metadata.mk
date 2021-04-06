# Git repos, branches, commits and folders to get source code for the tool we are building
RISCV_OPENOCD_GITURL := git@github.com:riscv/riscv-openocd.git
RISCV_OPENOCD_BRANCH := riscv
RISCV_OPENOCD_COMMIT := a83ac8102208fe43029e31a20ea00eb5f242f5e3
RISCV_OPENOCD_FOLDER := riscv-openocd

# Version number, which should match the official version of the tool we are building
RISCV_OPENOCD_VERSION := 0.10.0

# Customization ID, which should identify the customization added to the original by SiFive
FREEDOM_OPENOCD_ID := 2020.12.1

# Characteristic tags, which should be usable for matching up providers and consumers
FREEDOM_OPENOCD_RISCV_TAGS = 
FREEDOM_OPENOCD_TOOLS_TAGS = openocd
