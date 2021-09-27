# Shared bootdir helper

## Problem to solve

You may have multiple linux installations, and they want to share the same `/boot` directory. 
However, each of them want different kernel paramters. 

This scenario usually appears while you want to deniable-encrypt all your computers, without 
bringing tons of USB sticks with you. 

## What this package do

1. Add a pre-transaction hook to make sure you have inserted your USB stick before upgrading kernel. 
2. Add a post-transaction hook to rename your kernel file basing on hostname, to avoid conflicting with other installations. 
3. Add a new mkinitcpio preset, TODO: find a way to change pkgbase in mkinitcpio-install
4. Modify `/etc/default/grub` to allow external script to manage kernel parameters. 
5. Add a post-transaction hook after `grub-mkconfig`, to automatically set kernel parameters for every boot entry. 

> I don't think it's a good idea for a package to modify others configuration file. I'm reviewing the design to see if there's any better solution. 

## Support status

### Bootloader

only supports grub

### Distributions

only supports arch-based distributions. Tested on Arch Linux and Manjaro Linux. 

