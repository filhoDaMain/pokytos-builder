#!/bin/bash

# MIT License
#
# Copyright (c) 2025 Andre Temprilho
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


usage(){
    echo "Usage:"
    echo "(1)  Launch container with interactive shell - call with no arguments"
    echo "     $ pokytos-builder.sh"
    echo ""
    echo "(2)  Bitbake one target"
    echo "     $ pokytos-builder.sh bitbake <target and options>"
    echo ""
    echo "     e.g.:   $ pokytos-builder.sh bitbake pokytos-console-image -c clean"
    echo ""
    echo ""
}

# $1: exit code
quit(){
    popd
    exit $1
}



# 'sed_marker' will be substituted by install.sh script with
# path to pokytos-builder Makefile
pushd sed_marker

# Allow user to override HOST_POKYTOS_DIR from ENV_FILE.
# If unset, source it from ENV_FILE.
if [ -z "${HOST_POKYTOS_DIR}" ]; then
    . ENV_FILE
fi

# No arguments -> Spawn container with a shell
if [ $# -eq 0 ]; then
    echo "Launching an interactive shell"
    make run

# With arguments
else
    # Must be at least 2 arguments in the form 'bitbake <arg1> arg<2> ...'
    if [[ $# -lt 2 || "$1" != "bitbake" ]]; then
        usage
        quit 1
    fi

    # Concatenate all arguments (shift one to exclude 'bitbake' from arg list)
    shift
    export ARGS="$*"
    make bitbake
fi

quit $?
