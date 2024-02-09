#!/usr/bin/env bash
cp /sbin/ufw /bin/
ufw default deny incoming
ufw default deny outgoing
ufw default deny routed
rm /bin/ufw
