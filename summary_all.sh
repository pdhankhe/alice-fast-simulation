#!/bin/bash

# Print a summary for output files for a list of jobs.

if [ -z "$1" ]
then
    echo "Usage: $0 <text file containing the list of job names>"
    exit 1
fi

job_list="$(readlink -f "$1")"
nfiles=$2

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
script="summary.sh"

for jobfullname in $(cat $job_list)
do
    filename="AnalysisResults_$jobfullname.root"
    logfile="stdouterr_${jobfullname}_summary.txt"
    ${dir}/${script} $filename > $logfile 2>&1 &
done

exit 0

