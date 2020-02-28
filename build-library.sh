#!/bin/bash

macroname="testload.C"

echo "ROOT: $ROOT_RELEASE, AliRoot: $ALIROOT_RELEASE, AliPhysics: $ALIPHYSICS_RELEASE"
echo "Compiling the library"
rm -rf CMakeCache.txt CMakeFiles cmake_install.cmake G__*
cmake . && make && root -l -b -q $macroname

exit 0

