#!/bin/bash

list=( \
POWHEG_PYTHIA6_EVTGEN_BEAUTY_13TeV_central \
POWHEG_PYTHIA6_EVTGEN_BEAUTY_13TeV_F1-R05 \
POWHEG_PYTHIA6_EVTGEN_BEAUTY_13TeV_F05-R1 \
POWHEG_PYTHIA6_EVTGEN_BEAUTY_13TeV_F2-R1 \
POWHEG_PYTHIA6_EVTGEN_BEAUTY_13TeV_F1-R2 \
POWHEG_PYTHIA6_EVTGEN_BEAUTY_13TeV_F2-R2 \
POWHEG_PYTHIA6_EVTGEN_BEAUTY_13TeV_F05-R05 \
POWHEG_PYTHIA6_EVTGEN_BEAUTY_13TeV_Mhi \
POWHEG_PYTHIA6_EVTGEN_BEAUTY_13TeV_Mlo \
POWHEG_PYTHIA6_BEAUTY_13TeV_central \
)

for var in ${list[@]}; do
    echo -e "Submit \e[1;32m$var\e[0m?"
    #read -p "Press [ENTER] to continue..." -s
    #./submit_grid.py ${var}.yaml
    while true; do
        read yn
        case $yn in
            [Yy] ) echo "Submitting"; ./submit_grid.py ${var}.yaml; break;;
            [Nn] ) echo "Skipping"; break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
done

exit 0

