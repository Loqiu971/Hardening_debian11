#!/usr/bin/env bash


sed -i 's/#NTP=/NTP=time.nist.gov/g' /etc/systemd/timesyncd.conf
sed -i 's/#FallbackNTP=0.debian.pool.ntp.org 1.debian.pool.ntp.org 2.debian.pool.ntp.org 3.debian.pool.ntp.org/FallbackNTP=time-a-g.nist.gov time-b-g.nist.gov time-c-g.nist.gov/g' /etc/systemd/timesyncd.conf

systemctl try-reload-or-restart systemd-timesyncd
