#!/bin/bash

# Make symlinks to the tree files in a list.

# https://unix.stackexchange.com/questions/82541/loop-through-the-lines-of-two-files-in-parallel

if [ -z "$1" ] || [ -z "$2" ]
then
    echo "Usage: $0 <file with tags> <file with job names>"
    exit 1
fi

list_tag="$(readlink -f "$1")"
if [ ! -f "$list_tag" ]
then
  echo "Error: File ${list_tag} does not exist!"
  exit 1
fi

list_job="$(readlink -f "$2")"
if [ ! -f "$list_job" ]
then
  echo "Error: File ${list_job} does not exist!"
  exit 1
fi

dirjobs=$(dirname ${list_job})
while read -u 3 -r tag && read -u 4 -r job; do
    path_treefile="$(readlink -f "${dirjobs}/${job/FastSim_/trees_}".root)"
    linkname="${tag}.root"
    if [ ! -f "$path_treefile" ]
    then
      echo "Error: File ${path_treefile} does not exist!"
      exit 1
    fi
    echo "Linking ${path_treefile} to ${linkname}"
    ln -s ${path_treefile} ${linkname}
done 3<${list_tag} 4<${list_job}

exit 0

