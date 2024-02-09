#!/usr/bin/env bash
cp /sbin/sysctl /bin/
/sbin/ufw status verbose
/sbin/ufw allow in on lo
/sbin/ufw allow out on lo
/sbin/ufw deny in from 127.0.0.0/8
/sbin/ufw deny in from ::1
/sbin/ufw status verbose
rm /bin/sysctl
