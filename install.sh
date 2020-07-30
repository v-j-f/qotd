#!/bin/bash

readonly QOTD_DOWNLOAD_URL="https://github.com/vjfernan/qotd/raw/master/qotd"
readonly QOTD_DIRECTORY="/usr/local/bin"

if [ ${EUID} -ne 0 ]; then
    echo "This script must be run as root." >&2
    exit 1
fi
if ! [[ -t 0 ]]; then
    echo "This script is interactive, please run: bash -c \"\$(curl -sL https://github.com/vjfernan/qotd/raw/master/install.sh)\"" >&2
    exit 1
fi
if ! [[ -f "$QOTD_DIRECTORY/qotd" ]]; then
    curl -L $QOTD_DOWNLOAD_URL -o /tmp/qotd
    if  [ $? != 0 ]; then
        echo "Error downloading qotd."
        exit 1
    else
        mv /tmp/qotd $QOTD_DIRECTORY/
        chmod 755 $QOTD_DIRECTORY/qotd
    	echo "qotd installed."
    	echo "Run qotd to show a quote of the day."
    fi
else
    echo "You already have qotd installed."
    exit 1
fi
