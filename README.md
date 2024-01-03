# Shared bootdir helper

> Sharing the same `/boot` between multiple linux installations.

Background: <https://recolic.net/blog/post/deniable-encryption-and-shared-boot-partition>

You have multiple linux installations, with the same `/boot`. 
However, each of them want different kernel paramters.

This scenario usually appears while you want to deniable-encrypt all your computers, without 
bringing many USB sticks with you. 

## Problem1 - multiple installations may share the same vmlinuz filename

You just need to install this package. And it can automatically add hooks to help you rename them. 

- What does this package do for you

1. Add a pre-transaction hook to make sure you have inserted your USB stick before upgrading kernel. 
2. Add a post-transaction hook to rename your kernel file basing on hostname, to avoid conflicting with other installations. And learn from `/usr/share/libalpm/scripts/mkinitcpio-install`, to find and modify the `pkgbase` file to add a hostname.
3. Add a new mkinitcpio preset basing on hostname.  

## Problem2 - every kernel wants its own kernel parameter set

GRUB is managing kernel parameters. 

- What does this package do for you

Modify `/usr/bin/grub-mkconfig` and add a post-transaction hook after `grub-mkconfig`, to automatically modify /boot/grub/grub.cfg for you. 

- What should you do

Modify file `/etc/shared-bootdir-helper-multi-kparam.cfg`, to set kernel parameters for each hostname. 

## Usage

Firstly, install this package. 

Secondly, modify `/etc/shared-bootdir-helper-multi-kparam.cfg` to solve problem 2. 

Thirdly, you must re-install your kernel. You may want to run `pacman -S linux`, `pacman -S linux-lts`, `pacman -S linux-surface`, or something like this. 

Lastly, you need to run `grub-mkconfig -o /boot/grub/grub.cfg` again. Now you have successfully configured this tool! Enjoy and forget it! 

You need to do nothing while upgrading your kernel in the future, because the kimage filename would not be changed. Just do what you usually do. 

## Support status

### Distributions

only supports arch-based distributions. Tested on Arch Linux and Manjaro Linux. 

### Bootloader

only supports grub. This only matters if you're using `shared-bootdir-helper-multi-kparam`. 

## notes

depends on: sed, bash, 

