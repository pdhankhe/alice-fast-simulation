# Instructions for running on lxplus and on the Grid

## Set up the code repository

~~~~bash
git clone https://github.com/vkucera/alice-fast-simulation.git
cd alice-fast-simulation
git checkout taskHFjets
~~~~

## Load the necessary packages

~~~~bash
alienv enter VO_ALICE@AliPhysics::vAN-20181026-1
~~~~
In case you want to run POWHEG without loading packages separately (disabled now):
~~~~bash
alienv enter VO_ALICE@AliPhysics::vAN-20181026-1,VO_ALICE@POWHEG::r3178-alice1-1
~~~~

## Build the library

~~~~bash
./build-library.sh
~~~~

## Edit the config file if needed

e. g. `POWHEG_PYTHIA6_EVTGEN_BEAUTY_13TeV_central.yaml`

## Run a test job locally on lxplus

~~~~bash
./submit_grid.py <config file> --offline
cd <created directory>
./runFastSim.py <config file> --numevents 10 --batch-job grid
~~~~

## Submit jobs on the Grid

~~~~bash
alien-token-init
./submit_grid.py <config file>
~~~~

