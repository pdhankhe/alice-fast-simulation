#!/bin/bash

macroname="testload.C"

if [ -z "$ALIPHYSICS_RELEASE" ]
then
    echo "Error: AliPhysics not loaded."
    exit 1
fi

echo "ROOT: $ROOT_RELEASE, AliRoot: $ALIROOT_RELEASE, AliPhysics: $ALIPHYSICS_RELEASE"
echo "Compiling the library"
rm -rf libAnalysisCode.so CMakeCache.txt CMakeFiles cmake_install.cmake G__*
cmake . && make && root -l -b -q $macroname

exit 0

