#!/bin/bash

# Download and merge job output files for a list of jobs.

if [ -z "$1" ] || [ -z "$2" ] || ! [ "$2" -eq "$2" ]
then
    echo "Usage: $0 <text file containing the list of job names> <number of files per job to download>"
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
script="download_job.sh"

for jobfullname in $(cat $job_list)
do
    logfile="stdouterr_${jobfullname}_download.txt"
    ${dir}/${script} $jobfullname $nfiles > $logfile 2>&1 &
done

exit 0

