#!/usr/bin/env python

import datetime
import platform
import subprocess
import argparse

def environment_validation():
    try:
        rootPath = subprocess.check_output(["which", "root"]).rstrip()
        alirootPath = subprocess.check_output(["which", "aliroot"]).rstrip()
        alienPath = subprocess.check_output(["which", "alien-token-info"]).rstrip()
    except subprocess.CalledProcessError:
        print("Environment is not configured correctly!")
        exit()

    print("Root: " + rootPath)
    print("AliRoot: " + alirootPath)
    print("Alien: " + alienPath)

def main(trainName, xmlFile):
    print("------------------ job starts ---------------------")
    dateNow = datetime.datetime.now()
    print(dateNow)

    # environment_validation()
    # unable to load legacy AliPhysics with ROOT5 from AliEn

    print("Running merging of {0} on: {1}".format(trainName, " ".join(platform.uname())))

    print("Running merging...")
    with open('stdout', 'w+') as stdoutFile:
        shell = subprocess.Popen(["bash"], stdin=subprocess.PIPE, stdout=stdoutFile, stderr=stdoutFile)
        shell.stdin.write('/cvmfs/alice.cern.ch/bin/alienv enter VO_ALICE@AliPhysics::vAN-20181026-1\n'.encode())
        shell.stdin.write("which aliroot\n".encode())
        shell.stdin.write(f"aliroot -b -l -q 'start_merging.C(\"{xmlFile}\")'\n".encode())
        shell.communicate()
    print("Done")
    print("...see results in the log files")

    subprocess.call(["ls", "-l"])

    print("############### SCRATCH SIZE ####################")
    subprocess.call(["du", "-sh"])

    print("------------------ job ends ----------------------")
    dateNow = datetime.datetime.now()
    print(dateNow)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Run fast simulation.')
    parser.add_argument('train_name', metavar='NAME')
    parser.add_argument('--xml', metavar='FILE.XML')
    
    args, unknown = parser.parse_known_args()
    print('[+] Unknown arguments : ' + repr(unknown))

    main(args.train_name, args.xml)
