#!/bin/bash

ext=0
if [ ! -z "$2" ]
then
    ext=$2
fi

root -b -q 'summary.C("'$1'",'$ext')'

