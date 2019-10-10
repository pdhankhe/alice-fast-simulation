#!/bin/bash

macroname="testload.C"

echo "ROOT: `which root`"
echo "Compiling the library"
#make clean
#make
root -l -b -q $macroname

exit 0

