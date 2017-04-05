#!/usr/bin/env python

""" This small tool is to faciliate buck build for relative path """
""" e.g. mybuck . ==> buck build experimental/yqw/env """


import os
import sys
import argparse
from subprocess import call

parser = argparse.ArgumentParser(description="mybuck")
parser.add_argument("--fbcode",
                    default="~/fbsource/fbcode",
                    help="path to fbcode",
                    type=str)
parser.add_argument("rel_path",
                    default=".",
                    type=str,
                    help="relative path to build")
parser.add_argument("-b", "--just-show", action='store_true')
args = parser.parse_args()

curw = os.getcwd()
tgtp = os.path.normpath(os.path.join(curw, args.rel_path))
fbcode = os.path.realpath( os.path.expanduser(args.fbcode) )

relpath = os.path.relpath(tgtp, fbcode)
print("buck build %s:" %relpath)
if not args.just_show:
    call(["buck", "build", relpath+":"])

