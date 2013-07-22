#!/bin/bash

smilepath=$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

set -u

hosts=$(cat ~/.ssh/config | sed -n '/Host\s[^*]/ p' | cut -d ' ' -f 2-)

update_dotfiles() {
    local host=$1
    local smilepath=$2
    local destpath=$3

    rsync -az --delete "$smilepath" "$host:${destpath%/*}"
    if [ $? -eq 0 ]; then
        echo "updated"
        # TODO launch install without download for private servers
        ssh -o ConnectTimeout=1 $host "$destpath/install.sh > /dev/null 2>&1" > /dev/null 2>&1
        ssh -o ConnectTimeout=1 $host "echo $host > ~/.box-name" > /dev/null 2>&1
        return 0
    fi

    echo "not updated, error during rsync"
    return 1
}

run() {
    local host=$1

    ssh -o ConnectTimeout=1 $host "echo zoo > /dev/null 2>&1" > /dev/null 2>&1
    test $? -eq 0 || return 1

    destpath=$(ssh -o ConnectTimeout=1 $host "cat .smile.conf 2> /dev/null" 2> /dev/null)
    result=$?
    destpath=${destpath##*=}

    local message
    if [ $result -eq 0 ]; then
        message="$host: dotfiles installed in $destpath"
        message="$message ... $(update_dotfiles "$host" "$smilepath" "$destpath")"
    else
        message="$host: no dotfiles found"
        message="$message ... $(update_dotfiles "$host" "$smilepath" "~/${smilepath##*/}")"
    fi

    printf "%s\n" "$message"
}

export -f update_dotfiles

while read -ru 3 host; do
    run "$host" &
done 3<<< "$hosts"

wait
