#!/usr/bin/env bash

set -o errexit          # Exit on most errors (see the manual)
set -o errtrace         # Make sure any error trap is inherited
#set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline

version='0.1'
ip='192.168.0.x'
serial='deadbeefdeadbeef'

function help() {
    cat << EOF
Usage: ${0##*/} [OPTION]
     -h, --help          Show this help.
     -V, --version       Show version info.
     -r, --record        Record screen to eg., ~/Video/acap-$(date +%F-%H-%M).mkv
EOF
}

while [[ "${1-}" =~ ^- && ! "${1-}" == "--" ]]; do case ${1-} in
    -h | --help )
        help
        exit 0
        ;;
    -V | --version )
        echo ${0##*/} version $version
        exit 0
        ;;
    -r | --record )
        shift
        adb connect $ip \
            && scrcpy -tS --record-format mkv -r ~/Video/acap-$(date +%F-%H-%M).mkv \
            || scrcpy -s $serial -tS --record-format mkv -r ~/Video/acap-$(date +%F-%H-%M).mkv \
            || zenity --notification --text="${0}: Something went wrong."
        exit 0
        ;;
    -* )
        echo "Invalid option $1"
        ;;
esac; shift; done
if [[ "${1-}" == '--' ]]; then shift; fi

adb connect $ip \
    && scrcpy -tS \
    || scrcpy -s $serial -tS \
    || zenity --notification --text="${0}: Something went wrong."
