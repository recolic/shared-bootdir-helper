#!/bin/bash
# This is the pre-transaction hook, to force user to check if /boot is mounted. 
# If there's no device mounted at /boot, generates an error. 

mount | cut -d ' ' -f 3 | grep '^/boot$' > /dev/null
exit $?


