#!/bin/bash

smilepath=$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

set -u

hosts=$(cat ~/.ssh/config | sed -n '/Host\s[^*]/ p' | cut -d ' ' -f 2-)

update_dotfiles() {
    local host=$1

    ssh -o ConnectTimeout=1 $host "echo zoo > /dev/null 2>&1" > /dev/null 2>&1
    test $? -eq 0 || return 1

    destpath=$(ssh -o ConnectTimeout=1 $host "cat .smile.conf 2> /dev/null" 2> /dev/null)
    result=$?
    destpath=${destpath##*=}

    local message
    if [ $result -eq 0 ]; then
        message="$host: dotfiles installed in $destpath"
    else
        message="$host: no dotfiles found"
    fi

    # rsync -az --delete "$smilepath" "$host:$destpath"

    # if [ $? -eq 0 ]; then
    #     message="$message ... updated"
    # else
    #     message="$message ... not updated, error during rsync"
    # fi

    printf "%s\n" "$message"
}

while read -ru 3 host; do
    update_dotfiles "$host" &
done 3<<< "$hosts"

wait
