#!/bin/bash

ext=0
if [ ! -z "$2" ]
then
    ext=$2
fi

dir=$(dirname $0)
macro="summary.C"

root -b -q ''${dir}/${macro}'("'$1'",'$ext')'

exit 0

