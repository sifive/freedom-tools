SiFive Freedom RISC-V Tools for Embedded Development
--------

At SiFive we've been distributing binary release packages of the embedded development
tools that target our Freedom RISC-V platforms.  This repository contains the scripts
we use to build these tools.

To build the tools:
```
  % git clone git@github.com:sifive/freedom-tools.git
  % cd freedom-tools
  % git submodule update --init --recursive
  % make
```

The final output is a set of tarballs in the "bin" folder that should be ready to use.
