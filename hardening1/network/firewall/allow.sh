#!/usr/bin/env bash

cp /sbin/ufw /bin/
ufw allow git
ufw allow in http
ufw allow out http
ufw allow in https
ufw allow out https
ufw allow out 53
ufw logging on
rm /bin/ufw
