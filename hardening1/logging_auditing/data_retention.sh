#!/usr/bin/env bash

sed -i 's/max_log_file = 8/max_log_file = 20/g' /etc/audit/auditd.conf
sed -i 's/max_log_file_action = ROTATE/max_log_file_action = keep_logs/g' /etc/audit/auditd.conf
sed -i 's/space_left_action = SYSLOG/space_left_action = email/g' /etc/audit/auditd.conf
sed -i 's/admin_space_left_action = SUSPEND/admin_space_left_action = halt/g' /etc/audit/auditd.conf

