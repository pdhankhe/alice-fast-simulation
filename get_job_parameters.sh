#!/bin/bash

# Get the job name and the job ID from the log file.

# removing special characters: https://superuser.com/questions/380772/removing-ansi-color-codes-from-text-stream

list_jobs="jobs.txt"

for var in $(cat $list_jobs); do
    logfile="${var}.log"
    jobname=$(grep "Submitting" $logfile | cut -d " " -f 6)
    jobid=$(grep "Your new job ID" $logfile | cut -d " " -f 7 | sed 's/\x1b\[[0-9;]*m//g')
    echo -e "${var}\t${jobname}\t${jobid}"
done

exit 0

