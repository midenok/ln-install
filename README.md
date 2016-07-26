# Symlinked Install

Supplies `autoconf`, `cmake` or `MakeMaker` configured trees with symlinked version of `make install`.
I.e. it will create symlinks to binaries in compiled tree instead of copying them.
This speeds up development inside large source trees with repeated fix-compile-run cycles.

### Installation
Just add path to `ln-install` into beginning of `PATH` for `autoconf` or `cmake` based trees.

Add path to `ln-install` into `PERL5LIB` (and export) for `MakeMaker` trees.


### Usage
For `autoconf` or `MakeMaker` trees just run  `make install` as usual.

For `cmake`-d sources use `cmake-ln` instead of `cmake`.
