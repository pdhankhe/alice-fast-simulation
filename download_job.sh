#!/bin/bash

# Download and merge job output files.

# Use the third parameter to require or exclude a disk storage element (SE)
# Use \! in front of the SE name to exclude it.

if [ -z "$1" ] || [ -z "$2" ] || ! [ "$2" -eq "$2" ]
then
    echo "Usage: $0 <job name> <number of files to download> [storage element]"
    exit 1
fi

if [ -z "$ALIPHYSICS_RELEASE" ]
then
    echo "Error: AliPhysics not loaded."
    exit 1
fi

SE=""
if [ ! -z "$3" ]
then
    SE="$3"
fi

jobfullname=$1 # name of the job directory (e.g. FastSim_powheg+pythia6+evtgen_beauty_1581559114)
nfiles=$2 # number of files to download
username="vkucera"

dirbase="/alice/cern.ch/user/${username:0:1}/$username"
n_=$(echo $jobfullname | grep -o '_' | wc -l) # number of underscores
if [ $n_ -eq 0 ]
then
    echo "Failed to interpret the directory name $jobfullname"
    exit 1
fi
jobname=$(echo $jobfullname | cut -d '_' -f 1-$n_) # substring before the last _
timestamp=$(echo $jobfullname | cut -d '_' -f $((n_+1))) # substring after the last _
dirjob="${jobfullname}"
dirout="output"
filename="AnalysisResults_${jobname}.root"
filename_merged="AnalysisResults_${jobfullname}.root"
inputlist="list_${dirjob}.txt"
dirlocal="${dirbase:1}/$dirjob/$dirout"
pause=60 # number of seconds to wait before starting another download cycle

if [ $nfiles -gt 0 ]
then
    echo "$nfiles files in $jobfullname should be downloaded."
    nsuccess=0
    while [ $nsuccess -lt $nfiles ]
    do
        echo "Creating list of output files."
        rm -f $inputlist
        alien_find $dirbase/$dirjob/$dirout/ $filename | grep alice | head -n $nfiles > $inputlist
        nfiles_real=$(cat $inputlist | wc -l)
        i_file=0
        for file in $(cat $inputlist)
        do
            i_file=$((i_file + 1))
            target_file=".${file}"
            echo "$i_file/$nfiles_real $file"
            if [ -f $target_file ]
            then
                echo "File already exists. Skipping."
                continue
            fi
            echo "Downloading"
            mkdir -p $(dirname $target_file)
            path_alien="alien://${file}"
            if [ ! -z "$SE" ]
            then
                path_alien="${path_alien}@${SE}"
            fi
            alien_cp ${path_alien} .${file}
        done
        rm -f $inputlist

        nsuccess=$(find $dirlocal -type f -name $filename | wc -w)
        if [ $nsuccess -lt $nfiles ]
        then
            echo "Not enough files to start merging: $nsuccess/$nfiles"
            echo "Downloading will restart in $pause s (at $(date --date='+'$pause' sec' +'%H:%M:%S'))."
            sleep $pause
        fi
    done
fi

nsuccess=$(find $dirlocal -type f -name $filename | wc -w)
echo "Merging $nsuccess output files."
time hadd -f3 -O -j $(nproc) $filename_merged $(find $dirlocal -type f -name $filename)
du -sh $filename_merged

exit 0

