#!/usr/bin/env python

import os
# support both Python 2.7 and 3.6
# https://python-future.org/compatible_idioms.html#raw-input
try:
    from builtins import input
except ImportError:
    from __builtin__ import input
import yaml

def LoadUserConfiguration(path):
    if not os.path.isfile(path):
        return GenerateUserConfiguration(path)

    f = open(path, 'r')
    config = yaml.safe_load(f)
    f.close()
    return config

def GenerateUserConfiguration(path):
    config = dict()
    username = input("Please enter your CERN user name: ")
    local_path = input("Please enter a local path that I can use as working directory: ")
    config["username"] = username
    config["local_path"] = local_path
    with open(path, 'w') as f:
        yaml.dump(config, f)
    return config
