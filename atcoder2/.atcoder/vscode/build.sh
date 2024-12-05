#!/bin/bash
# SCRIPT_DIR=$(cd $(dirname $0); pwd)
# cd $SCRIPT_DIR

g++ main.cpp `tail -n +2 compile_flags.txt`
