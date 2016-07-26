# Symlinked Install

Supplies `autoconf` or `cmake` configured trees with symlinked version of `make install`.
I.e. it will create symlinks to binaries in compiled tree instead of copying them.
This speeds up development inside large source trees with repeated fix-compile-run cycles.

### Installation
Just add `ln-install` dir into PATH before standard binaries.

### Usage
Autoconf-ed `make install` then will take wrapper `ln-install/install` instead of `/usr/bin/install`.

For cmake-d sources use `cmake-ln` instead of `cmake`.
