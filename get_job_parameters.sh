#!/bin/bash

# Get the job name and the job ID from the log file.

list_jobs="jobs.txt"

for var in $(cat $list_jobs); do
    logfile="${var}.log"
    jobname=$(grep "Submitting" $logfile | cut -d " " -f 6)
    jobid=$(grep "Your new job ID" $logfile | cut -d " " -f 7 | cut -d m -f 3)
    echo -e "${var}\t${jobname}\t${jobid}\e[0m"
done

exit 0

