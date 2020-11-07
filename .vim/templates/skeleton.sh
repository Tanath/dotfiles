#!/usr/bin/env bash

set -o errexit          # Exit on most errors (see the manual)
set -o errtrace         # Make sure any error trap is inherited
#set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline

version='0.1'
function help() {
    cat << EOF
Usage: ${0##*/} [OPTION]
     -h|--help          Show this help.
     -V|--version       Show version info.
EOF
}

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -h | --help )
    help
    exit 0
    ;;
  -V | --version )
    echo ${0##*/} version $version
    exit 0
    ;;
  -f | --flag )
    shift; flag=$1
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi
