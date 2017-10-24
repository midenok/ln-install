#!/bin/sh
src=$(dirname $(readlink -fn "$0"))
lib=$(readlink -fn "$src/../CMake")
build=$(mktemp -d /tmp/ln-install.XXXX)
opt="$build/opt"
cd "$build"
cmake()
{
    $(which cmake) -DCMAKE_INSTALL_PREFIX="$opt" "$@" "$src"
}
# cmake
# make install
opt="${opt}-ln"
cmake -DCMAKE_MODULE_PATH="$lib"
make install
check()
{
    find "$@" -type f,l -printf "%s %p %l\n"
}
# check opt
check opt-ln
rm -rf "$build"
