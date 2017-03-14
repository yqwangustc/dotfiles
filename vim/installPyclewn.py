#!/usr/bin/env python

import os
import sys
import pip
import glob
import shutil
from distutils.dir_util import copy_tree

# this script assume pip has already been installed 

# 1. try to see whether pyclewn has installed yet 
try:
    import clewn
except ImportError:
    pip.main(['install', '--user', 'pyclewn'])

# 2. copy necessary files to ~/.vim
dotdir=os.environ["DOTFILES_DIR"]
HOME=os.environ["HOME"]
src="%s/vim/pyclewn/" % dotdir
tgt="%s/.vim" % HOME
copy_tree(src, tgt)
