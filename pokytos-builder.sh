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
