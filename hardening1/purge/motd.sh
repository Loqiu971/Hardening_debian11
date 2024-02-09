#!/usr/bin/env bash

rm /etc/motd

cat > /etc/motd <<END

0 Information pour toi ! débrouille toi !

END

chown root:root $(readlink -e /etc/motd)
chmod u-x,go-wx $(readlink -e /etc/motd)

