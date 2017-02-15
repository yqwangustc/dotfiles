#!/bin/bash

# install necessary bin / package 
BIN=$HOME/bin
mkdir -p $BIN

# install pip3 locally if it has not been installed yet
PYTHON=$BIN/python
mkdir -p $PYTHON
# check whether pip3 is installed 
which pip > /dev/null
if [ "$?" -ne 0 ]; then 
    export PYTHONBASE=$PYTHON
    python3 $EXTRA_DIR/get-pip.py  --user
    export PATH=$PYTHON:$PATH
fi

# install pyclewn
