#!/usr/bin/env bash

apt install -y ufw 
/sbin/ufw allow proto tcp from any to any port 22
systemctl unmask ufw.service
systemctl --now enable ufw.service
/sbin/ufw enable
