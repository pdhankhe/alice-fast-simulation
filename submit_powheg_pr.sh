#!/bin/bash

list=( \
POWHEG_PYTHIA6_CHARM_13TeV_central \
POWHEG_PYTHIA6_CHARM_13TeV_F1-R05 \
POWHEG_PYTHIA6_CHARM_13TeV_F05-R1 \
POWHEG_PYTHIA6_CHARM_13TeV_F2-R1 \
POWHEG_PYTHIA6_CHARM_13TeV_F1-R2 \
POWHEG_PYTHIA6_CHARM_13TeV_F2-R2 \
POWHEG_PYTHIA6_CHARM_13TeV_F05-R05 \
POWHEG_PYTHIA6_CHARM_13TeV_Mhi \
POWHEG_PYTHIA6_CHARM_13TeV_Mlo \
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

