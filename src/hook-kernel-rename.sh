#!/bin/bash
# post-transaction hook, to rename the installed kernel basing on hostname. 
# This hook must run before mkinitcpio hook. 

echo "Executing $0..." 1>&2

function generate_mkinitcpio_preset () {
    template='
# mkinitcpio preset file for the "__PKGBASE__" package

ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/boot/vmlinuz-__PKGBASE__"

PRESETS=("default" "fallback")

#default_config="/etc/mkinitcpio.conf"
default_image="/boot/initramfs-__PKGBASE__.img"
#default_options=""

#fallback_config="/etc/mkinitcpio.conf"
fallback_image="/boot/initramfs-__PKGBASE__-fallback.img"
fallback_options="-S autodetect"
'
    new_pkgbase="$1"
    echo -n "$template" | sed "s/__PKGBASE__/$new_pkgbase/g" > "/etc/mkinitcpio.d/${new_pkgbase}.preset"
    # Maybe we should delete old_pkgbase.preset. I'm not sure if it would crash something on `mkinitcpio -P` (may called by mkinitcpio-install)
    return $?
}

# Learned from /usr/share/libalpm/scripts/mkinitcpio-install
while read -r line; do
    [[ $line != */vmlinuz ]] && continue
    if ! read -r pkgbase > /dev/null 2>&1 < "${line%/vmlinuz}/pkgbase"; then
        # if the kernel has no pkgbase, we skip it
        continue
    fi

    # Generates a filename for the kernel, and limit the length, convert to lowercase
    new_pkgbase="${pkgbase}-$(cat /etc/hostname)"
    new_pkgbase="${new_pkgbase:0:63}"
    new_pkgbase="${new_pkgbase,,}" # since bash 4.0

    # Generate mkinitcpio presets
    generate_mkinitcpio_preset "${new_pkgbase}" && 

    # Rename vmlinuz
    cp "/$line" "/boot/vmlinuz-${new_pkgbase}" && 

    # Overwrite /usr/lib/modules/.../pkgbase to make mkinitcpio-install use the new filename
    echo "${new_pkgbase}" > "${line%/vmlinuz}/pkgbase" && 

    echo "Renamed pkgbase from $pkgbase to $new_pkgbase successfully. " 1>&2 || 
    exit $? # Crash on error
done

