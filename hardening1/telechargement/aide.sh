#!/usr/bin/env bash

apt install -y aide aide-common
/sbin/aideinit
mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db

cat > /etc/systemd/system/aidecheck.service <<END
[Unit]
Description=Aide Check
[Service]
Type=simple
ExecStart=/usr/bin/aide.wrapper --config /etc/aide/aide.conf --check
[Install]
WantedBy=multi-user.target

END

cat > /etc/systemd/system/aidecheck.timer <<END
[Unit]
Description=Aide check every day at 5AM
[Timer]
OnCalendar=*-*-* 05:00:00
Unit=aidecheck.service
[Install]
WantedBy=multi-user.target

END

chown root:root /etc/systemd/system/aidecheck.*
chmod 0644 /etc/systemd/system/aidecheck.*
systemctl daemon-reload
systemctl enable aidecheck.service
systemctl --now enable aidecheck.timer

