#!/bin/bash

set -euo pipefail

IMAGE_NAME="pokytos-builder"
MOUNT="${MOUNT:-/usr/local/etc/pokytos-builder.conf}"

# Read mount points from MOUNT
mounts=()
workdir=""


# Parse a mount conf file passed as argument.
# This overrides the default MOUNT file.
while [[ $# -gt 0 ]]; do
    case "$1" in
        -m)
            if [[ -z "${2:-}" ]]; then
                echo "Error: -m requires a configuration file" >&2
                exit 1
            fi
            MOUNT="$2"
            shift 2
            ;;
        *)
            break
            ;;
    esac
done


echo "Reading directories and files to mount from $MOUNT"
while IFS= read -r dir; do
    # Skip blank lines and comments
    [[ "$dir" =~ ^[[:space:]]*$ ]] && continue
    [[ "$dir" =~ ^[[:space:]]*# ]] && continue

    # Expand environment variables (${HOME}, $USER, etc.)
    dir=$(eval "echo \"$dir\"")

    # Ensure the path exists (file or directory)
    if [[ ! -e "$dir" ]]; then
        echo "Error: path does not exist: $dir" >&2
        exit 1
    fi

    mounts+=(-v "$dir:$dir")

    # First path becomes the working directory
    [[ -z "$workdir" ]] && workdir="$dir"

done < "$MOUNT"

if [[ -z "$workdir" ]]; then
    echo "Error: no mount directories found in $MOUNT" >&2
    exit 1
fi


# Call arguments. Execute "run" by default.
case "${1:-run}" in
    run)
        echo "Launching interactive shell at $workdir"
        echo
        exec docker run -it --rm \
            "${mounts[@]}" \
            -w "$workdir" \
            -h "$IMAGE_NAME" \
            "$IMAGE_NAME"
        ;;

    bitbake)
        echo "Calling bitbake with arguments at $workdir"
        echo
        shift
        exec docker run --rm \
            "${mounts[@]}" \
            -w "$workdir" \
            "$IMAGE_NAME" \
            /bin/bash -c "source pokytos-env && bitbake $*"
        ;;

    *)
        cat <<EOF

Usage:
    pokytos-builder.sh                Launch an interactive shell in the container.
    pokytos-builder.sh bitbake ...    Run bitbake with the given arguments.
    pokytos-builder.sh -m <mount> ... Read MOUNT directories file before parsing any other subsequent argument
    
    Note: if -m option is not invoked, directories to mount are read from $MOUNT

Examples:
    pokytos-builder.sh
    pokytos-builder.sh bitbake pokytos-console-image
    pokytos-builder.sh -m /home/foo/mountdirs.conf
    pokytos-builder.sh -m /home/foo/mountdirs.conf bitbake pokytos-console-image
EOF
        exit 1
        ;;
esac
