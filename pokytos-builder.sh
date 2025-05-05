#!/bin/bash

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

# 'sed_marker' will be substituted by install.sh script with
# path to pokytos-builder Makefile
pushd sed_marker

# Source env vars
. ENV_FILE

# No arguments -> Spawn container with a shell
if [ $# -eq 0 ]; then
    echo "Launching an interactive shell"
    make run

# With arguments
else
    # Must be at leat 2 arguments in the form 'bitbake <arg1> arg<2> ...'
    if [[ $# -lt 2 || "$1" != "bitbake" ]]; then
        usage
        popd
        exit 1
    fi

    # Concatenate all arguments (shift one to exclude 'bitbake' from arg list)
    shift
    export ARGS="$*"
    make bitbake
fi

popd
