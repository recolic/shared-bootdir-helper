#!/bin/bash
#
# For shared boot partition between multiple installations, 
#   each kernel image may need different boot parameter, and 
#   it's not a good idea to manage them manually in grub.d. 
# So we set GRUB_CMDLINE_LINUX_DEFAULT to 
#    __KERNEL_PARAMETER_MANAGED_BY_HELPER, 
# and this script is intended to run after `grub-mkconfig`, 
#   which alters all `__KERNEL_PARAMETER_MANAGED_BY_HELPER`
#   to correct kernel parameters. 
#
# Usage: ./this.sh /boot/grub/grub.cfg

source "/etc/shared-bootdir-helper-multi-kparam.cfg" || exit 1

########### implementation begin ##############
tmpfile="$(mktemp)"
inputfile="$1"
[[ "$inputfile" = "" ]] && echo "Usage: $0 /boot/grub/grub.cfg" && exit 1

while IFS= read -r line; do
    matched=0
    if [[ "$line" == *"$placeholder"* ]]; then
        for hostname in "${!map_hostname_to_kparam[@]}"; do
            # Assuming that, the kimg filename contains "vmlinuz-xxx-$hostname ", in lowercase. That's important! 
            [[ "$line" == *"-$hostname "* ]] &&
                echo "$line" | sed "s|$placeholder|${map_kimage_to_kparam[$hostname]}|g" >> "$tmpfile" &&
                matched=1 && 
                break
        done
    fi
    [[ $matched == 0 ]] && echo "$line" >> "$tmpfile"
done < "$inputfile" || exit $?

mv "$tmpfile" "$inputfile" || exit $?

grep "$placeholder" "$inputfile" &&
    echo "Warning: placeholder '$placeholder' still exists in processed grub.cfg. Have you correctly set the 'map_kimage_to_kparam' of $0? Please double-check! " &&
    exit 2

exit 0

