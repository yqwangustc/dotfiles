#!/usr/bin/env python

""" This small tool is to faciliate finding buck-out target """
""" e.g. mybuck . ==> buck build experimental/yqw/env """


import os
import sys
import argparse
from subprocess import call

parser = argparse.ArgumentParser(description="mybuck-out")
parser.add_argument("--fbcode",
                    default="~/fbsource/fbcode",
                    help="path to fbcode",
                    type=str)
parser.add_argument("-b", "--just-show", action='store_true')
parser.add_argument("rel_path",
                    default=".",
                    type=str,
                    help="relative path to build")
args = parser.parse_args()

curw = os.getcwd()
tgtp = os.path.normpath(os.path.join(curw, args.rel_path))
fbcode = os.path.realpath( os.path.expanduser(args.fbcode) )

relpath = os.path.relpath(tgtp, fbcode)
buckoutpath = os.path.join(fbcode, "buck-out/gen/", relpath) 
print("%s" % buckoutpath)
print("export PATH=$PATH:%s" % buckoutpath)
