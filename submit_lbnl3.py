#!/usr/bin/env python

import os
import subprocess
import argparse
import time
import shutil
import random
import yaml
import UserConfiguration
import GeneratePowhegInput

def subprocessCall(cmd):
    print(cmd)
    return subprocess.call(cmd)

def subprocessCheckCall(cmd):
    print(cmd)
    return subprocess.check_call(cmd)

def subprocessCheckOutput(cmd):
    print(cmd)
    return subprocess.check_output(cmd, universal_newlines=True)

def CopyFilesToTheWorkingDir(Files, LocalDest):
    for fil in Files:
        shutil.copy(fil, LocalDest)

def SubmitParallel(LocalDest, ExeFile, Events, Jobs, yamlFileName):
    for ijob in range(0, Jobs):
        JobDir = LocalDest
        JobOutput = "{}/JobOutput_{:04d}.log".format(JobDir, ijob)
        RunJobFileName = "{}/RunJob_{:04d}.sh".format(JobDir, ijob)
        with open(RunJobFileName, "w") as myfile:
            myfile.write("#!/bin/bash\n")
            myfile.write(GenerateComments())
            myfile.write("#PBS -o %s\n" % (JobOutput))
            myfile.write("#PBS -j oe\n")
            myfile.write("source /home/salvatore/load_alice.sh\n")
            myfile.write("{LocalDest}/{ExeFile} {yamlFileName} --numevents {Events} --job-number {ijob} --batch-job lbnl3\n".format(LocalDest=LocalDest, ExeFile=ExeFile, yamlFileName=yamlFileName, Events=Events, ijob=ijob))
        output = subprocessCheckOutput(["qsub", RunJobFileName])
        print(output)

def SubmitParallelPowheg(LocalDest, ExeFile, Events, Jobs, yamlFileName, PowhegStage, XGridIter):
    input_file_name = GeneratePowhegInput.GetParallelInputFileName(PowhegStage, XGridIter)
    shutil.copy("{}/{}".format(LocalDest, input_file_name), "{}/powheg.input".format(LocalDest))

    if PowhegStage == 1:
        njobs = 10
    elif PowhegStage == 2:
        njobs = 20
    elif PowhegStage == 3:
        njobs = 10
    elif PowhegStage == 4:
        njobs = Jobs

    for ijob in range(1, njobs + 1):
        JobDir = LocalDest
        if PowhegStage == 1:
            JobOutput = "{}/JobOutput_Stage_{}_XGridIter_{}_{:04d}.log".format(JobDir, PowhegStage, XGridIter, ijob)
            RunJobFileName = "{}/RunJob_Stage_{}_XGridIter_{}_{:04d}.sh".format(JobDir, PowhegStage, XGridIter, ijob)
        else:
            JobOutput = "{}/JobOutput_Stage_{}_{:04d}.log".format(JobDir, PowhegStage, ijob)
            RunJobFileName = "{}/RunJob_{}_{:04d}.sh".format(JobDir, PowhegStage, ijob)
        with open(RunJobFileName, "w") as myfile:
            myfile.write("#!/bin/bash\n")
            myfile.write(GenerateComments())
            myfile.write("#PBS -o %s\n" % (JobOutput))
            myfile.write("#PBS -j oe\n")
            myfile.write("source /home/salvatore/load_alice.sh\n")
            myfile.write("{LocalDest}/{ExeFile} {LocalDest}/{yamlFileName} --numevents {Events} --job-number {ijob} --powheg-stage {PowhegStage} --batch-job lbnl3\n".format(LocalDest=LocalDest, ExeFile=ExeFile, yamlFileName=yamlFileName, Events=Events, ijob=ijob, PowhegStage=PowhegStage))
        os.chmod(RunJobFileName, 0o755)
        output = subprocessCheckOutput(["qsub", RunJobFileName])
        print(output)

def GenerateComments():
    branch = subprocessCheckOutput(["git", "rev-parse", "--abbrev-ref", "HEAD"])
    git_hash = subprocessCheckOutput(["git", "rev-parse", "HEAD"])
    comments = "# This is the startup script \n\
# alice-yale-hfjet \n\
# Generated using branch {branch} ({git_hash}) \n\
".format(branch=branch.strip('\n'), git_hash=git_hash.strip('\n'))
    return comments

def SubmitProcessingJobs(TrainName, LocalPath, Events, Jobs, Gen, yamlFileName, copy_files, PowhegStage, XGridIter):
    print("Submitting processing jobs for train {0}".format(TrainName))

    ExeFile = "runFastSim.py"
    LocalDest = "{0}/{1}".format(LocalPath, TrainName)

    if copy_files:
        os.makedirs(LocalDest)
        GeneratePowhegInput.main(yamlFileName, LocalDest, Events, 1, 1)
        GeneratePowhegInput.main(yamlFileName, LocalDest, Events, 1, 2)
        GeneratePowhegInput.main(yamlFileName, LocalDest, Events, 1, 3)
        GeneratePowhegInput.main(yamlFileName, LocalDest, Events, 2)
        GeneratePowhegInput.main(yamlFileName, LocalDest, Events, 3)
        GeneratePowhegInput.main(yamlFileName, LocalDest, Events, 4)

        with open("{}/pwgseeds.dat".format(LocalDest), "w") as myfile:
            if Jobs > 20:
                nseeds = Jobs
            else:
                nseeds = 20
            for _ in range(1, nseeds + 1):
                rnd = random.randint(0, 1073741824)  # 2^30
                myfile.write("{}\n".format(rnd))

        FilesToCopy = [yamlFileName, "OnTheFlySimulationGenerator.cxx", "OnTheFlySimulationGenerator.h",
                       "runJetSimulation.C", "start_simulation.C",
                       "lhapdf_utils.py",
                       "powheg_pythia8_conf.cmnd",
                       "Makefile", "HepMC.tar",
                       "AliGenExtFile_dev.h", "AliGenExtFile_dev.cxx",
                       "AliGenReaderHepMC_dev.h", "AliGenReaderHepMC_dev.cxx",
                       "AliGenEvtGen_dev.h", "AliGenEvtGen_dev.cxx",
                       "AliGenPythia_dev.h", "AliGenPythia_dev.cxx",
                       "AliPythia6_dev.h", "AliPythia6_dev.cxx",
                       "AliPythia8_dev.h", "AliPythia8_dev.cxx",
                       "AliPythiaBase_dev.h", "AliPythiaBase_dev.cxx"]

        FilesToCopy.extend([ExeFile])

        CopyFilesToTheWorkingDir(FilesToCopy, LocalDest)

        temp = os.getcwd()
        os.chdir(LocalDest)
        print("Compiling analysis code...")
        subprocess.call(["make"])
        os.chdir(temp)

    if "powheg" in Gen:
        SubmitParallelPowheg(LocalDest, ExeFile, Events, Jobs, yamlFileName, PowhegStage, XGridIter)
    else:
        SubmitParallel(LocalDest, ExeFile, Events, Jobs, yamlFileName)

    print("Done.")

def main(UserConf, yamlFileName, continue_powheg, powheg_stage, XGridIter):
    f = open(yamlFileName, 'r')
    config = yaml.load(f)
    f.close()

    Events = config["numevents"]
    Jobs = config["numbjobs"]
    Gen = config["gen"]
    Proc = config["proc"]

    try:
        rootPath = subprocess.check_output(["which", "root"]).rstrip()
        alirootPath = subprocess.check_output(["which", "aliroot"]).rstrip()
        qsubPath = subprocess.check_output(["which", "qsub"]).rstrip()
    except subprocess.CalledProcessError:
        print("Environment is not configured correctly!")
        exit()

    print("Root: " + rootPath)
    print("AliRoot: " + alirootPath)
    print("qsub: " + qsubPath)

    LocalPath = UserConf["local_path"]

    print("Local working directory: {0}".format(LocalPath))

    if not continue_powheg:
        unixTS = int(time.time())
        copy_files = True
        print("New job with timestamp {0}.".format(unixTS))
    else:
        unixTS = continue_powheg
        copy_files = False
        print("Continue job with timestamp {0}.".format(unixTS))
    TrainName = "FastSim_{0}_{1}_{2}".format(Gen, Proc, unixTS)
    SubmitProcessingJobs(TrainName, LocalPath, Events, Jobs, Gen, yamlFileName, copy_files, powheg_stage, XGridIter)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Local final merging for LEGO train results.')
    parser.add_argument('config', metavar='config.yaml',
                        default="default.yaml", help='YAML configuration file')
    parser.add_argument('--user-conf', metavar='USERCONF',
                        default="userConf.yaml")
    parser.add_argument('--continue-powheg', metavar='timestamp',
                        default=None)
    parser.add_argument('--powheg-stage',
                        type=int)
    parser.add_argument('--xgrid-iter',
                        default=1, type=int)
    args = parser.parse_args()

    userConf = UserConfiguration.LoadUserConfiguration(args.user_conf)

    main(userConf, args.config, args.continue_powheg, args.powheg_stage, args.xgrid_iter)
