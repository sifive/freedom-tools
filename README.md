SiFive Freedom RISC-V Tools for Embedded Development
--------

At SiFive we've been distributing binary release packages of the embedded development
tools that target our Freedom RISC-V platforms.  This repository contains the scripts
we use to build these tools.

### Packages and their contents

* RISC-V GNU Newlib Toolchain (`riscv64-unknown-elf-*`)
    * Binutils
    * GCC
    * GDB
    * Newlib (and nano)
    * LibExpat
* RISC-V OpenOCD (`riscv-openocd-*`)
    * OpenOCD
    * LibFTDI
    * LibUSB

All the packages has a uniquely named root folder, making it easy to untar/unzip'ing
multiple versions next to each other.

### To build the tools:

    $ git clone git@github.com:sifive/freedom-tools.git
    $ cd freedom-tools
    $ git submodule update --init --recursive
    $ make

The final output is a set of tarballs in the "bin" folder that should be ready to use.
The output of a Ubuntu build includes a set of tarballs and zip files for Windows
which is build using the MinGW toolchain.

### Prerequisites

Several standard packages are needed to build the tools on the different supported platforms.  


On Ubuntu, executing the following command should suffice:

    $ sudo apt-get install cmake autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf patchutils bc zlib1g-dev libexpat-dev libtool pkg-config mingw-w64

On OS X, you can use [Homebrew](http://brew.sh) to install the dependencies:

    $ brew install cmake gawk gnu-sed gnu-tar gmp mpfr libmpc isl zlib expat texinfo libtool pkg-config

On Fedora/CentOS/RHEL OS, executing the following command should suffice - plus see below:

    $ sudo yum install cmake libmpc-devel mpfr-devel gmp-devel gawk bison flex texinfo patchutils gcc gcc-c++ zlib-devel expat-devel

On CentOS/RHEL 7 and Fedora you can use yum install for the rest:

    $ sudo yum install autoconf automake libtool pkg-config

On CentOS/RHEL 6 you need to download a compile some tools manually to get the correct versions:

    $ wget http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
    $ gunzip autoconf-2.69.tar.gz
    $ tar xvf autoconf-2.69.tar
    $ cd autoconf-2.69
    $ ./configure
    $ make
    $ make install

    $ wget http://ftp.gnu.org/gnu/automake/automake-1.15.tar.gz
    $ tar xvzf automake-1.15.tar.gz
    $ cd automake-1.15
    $ ./configure
    $ make
    $ make install

    $ wget http://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz
    $ tar -xzvf libtool-2.4.6.tar.gz 
    $ cd libtool-2.4.6
    $ ./configure && make
    $ make install

    $ wget https://pkgconfig.freedesktop.org/releases/pkg-config-0.29.2.tar.gz
    $ tar -xzvf pkg-config-0.29.2.tar.gz 
    $ cd pkg-config-0.29.2
    $ ./configure --with-internal-glib
    $ make
    $ make install
