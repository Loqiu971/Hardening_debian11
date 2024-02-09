#!/usr/bin/env bash

sed -i 's/GRUB_CMDLINE_LINUX="apparmor=1 security=apparmor"/GRUB_CMDLINE_LINUX="apparmor=1 security=apparmor ipv6.disable=1"/g' /etc/default/grub
sed -i -n 's/grub-mkconfig/\/sbin\/grub-mkconfig/g' /sbin/update-grub
/sbin/update-grub
sed -i 's/\sbin\/grub-mkconfig/grub-mkconfig/g' /sbin/update-grub
