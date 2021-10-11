#!/bin/bash
# This is the pre-transaction hook, to force user to check if /boot is mounted. 
# If there's no device mounted at /boot, generates an error. 

while true; do
    mount | cut -d ' ' -f 3 | grep '^/boot$' > /dev/null && break
    [[ $warned = 1 ]] || ! echo "Please mount /boot BEFORE upgrading kernel. Waiting for mounting..." >&2 || warned=1
    echo -n .
    sleep 4
done

exit $?


