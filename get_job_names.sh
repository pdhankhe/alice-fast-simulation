#!/bin/bash

# Get only job names from the log files.

./get_job_parameters.sh | cut -d $'\t' -f 2

exit 0

