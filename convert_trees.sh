#!/bin/bash

# Convert trees in the simulation output files into flat trees.

if [ -z "$1" ]
then
    echo "Usage: $0 <text file containing the list of job names>"
    exit 1
fi

job_list="$(readlink -f "$1")"

if [ ! -f "$job_list" ]
then
  echo "Error: File ${job_list} does not exist!"
  exit 1
fi

if [ -z "$ALIPHYSICS_RELEASE" ]
then
    echo "Error: AliPhysics not loaded."
    exit 1
fi

dir=$(dirname $0)
macro="ConvertTrees.C"

for jobfullname in $(cat "${job_list}")
do
    filename_merged="AnalysisResults_${jobfullname}.root"
    filename_tree=${filename_merged/AnalysisResults_FastSim_/trees_}
    if [ ! -f "$filename_merged" ]
    then
      echo "Error: File ${filename_merged} does not exist!"
      exit 1
    fi
    logfile="stdouterr_${jobfullname}_convert.txt"
    aliroot -b -q ''${dir}/${macro}'("'${filename_merged}'")' > $logfile 2>&1 && du -sh $filename_tree >> $logfile 2>&1 &
done

exit 0

