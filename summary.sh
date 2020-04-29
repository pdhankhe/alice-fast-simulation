#!/bin/bash

if [ -z "$1" ]
then
    echo "Usage: $0 <job output ROOT file>"
    exit 1
fi


file_root="$(readlink -f "$1")"

if [ ! -f "$file_root" ]
then
  echo "Error: File ${file_root} does not exist!"
  exit 1
fi

if [ -z "$ALIPHYSICS_RELEASE" ]
then
    echo "Error: AliPhysics not loaded."
    exit 1
fi

ext=0
if [ ! -z "$2" ]
then
    ext=$2
fi

dir=$(dirname $0)
macro="summary.C"

root -b -q ''${dir}/${macro}'("'$1'",'$ext')'

exit 0

