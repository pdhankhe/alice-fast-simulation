#!/bin/bash

# Convert trees in the simulation output files into flat trees.

if [ -z "$1" ]
then
    echo "Usage: $0 <text file containing the list of input files>"
    exit -1
fi

file_list="$(readlink -f "$1")"

if [ ! -f "$file_list" ]
then
  echo "Error: File ${file_list} does not exist!"
  exit -1
fi

if [ -z "$ALIPHYSICS_RELEASE" ]
then
    echo "Error: AliPhysics not loaded."
    exit 1
fi

for file in $(cat "${file_list}")
do
    if [ ! -f "$file" ]
    then
      echo "Error: File ${file} does not exist!"
      exit -1
    fi
    aliroot -b -q 'ConvertTrees.C("'${file}'")'
done

exit 0

