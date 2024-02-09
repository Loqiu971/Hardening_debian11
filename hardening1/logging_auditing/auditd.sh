#!/usr/bin/env bash

apt install -y auditd audispd-plugins
systemctl --now enable auditd
sed -i 's/GRUB_CMDLINE_LINUX="apparmor=1 security=apparmor ipv6.disable=1"/GRUB_CMDLINE_LINUX="apparmor=1 security=apparmor ipv6.disable=1 audit=1 audit_backlog_limit=8192"/g' /etc/default/grub
cp /sbin/update-grub /bin/
update-grub
rm /bin/update-grub

