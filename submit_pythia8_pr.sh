#!/bin/bash

list=( \
PYTHIA8_CHARM_13TeV \
#PYTHIA8_CHARM_ColorSoft_13TeV \
#PYTHIA8_CHARM_ColorHard_13TeV \
)

#for var in ${list[@]}; do
#    echo -e "Submit \e[1;32m$var\e[0m?"
#    #read -p "Press [ENTER] to continue..." -s
#    #./submit_grid.py ${var}.yaml
#    while true; do
#        read -p "Answer: " yn
#        case $yn in
#            [Yy] ) echo "Submitting"; ./submit_grid.py ${var}.yaml; break;;
#            [Nn] ) echo "Skipping"; break;;
#            * ) echo "Please answer y or n.";;
#        esac
#    done
#done

for var in ${list[@]}; do
    echo -e "Submitting \e[1;32m$var\e[0m"
    logfile="${var}.log"
    ./submit_grid.py ${var}.yaml > $logfile 2>&1
    sleep 5
done

exit 0

