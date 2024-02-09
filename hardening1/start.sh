#!/usr/bin/env bash
#yes

chmod -R 700 ./
./purge/unistall.sh
./purge/motd.sh
./purge/issue.sh

./grub/grub.sh
./telechargement/aide.sh
./telechargement/apparmor.sh
./time/time.sh

./network/parameters/accept_ra/disable/accept_ra.sh
./network/parameters/acept_redirects/disable/acept_redirects.sh
./network/parameters/accept_source_route/disable/accept_source_route.sh
./network/parameters/fowarding/disable/ip_fowarding.sh
./network/parameters/icmp_echo_ignore_broadcoasts/disable/icmp_echo_ignore_broadcoasts.sh
./network/parameters/icmp_ignore_bogus_error_responses/disable/icmp_ignore_bogus_error_responses.sh
./network/parameters/log_martians/disable/log_martians.sh
./network/parameters/redirect_sending/disable/redirect_sending.sh
./network/parameters/rp_filter/disable/rp_filter.sh
./network/parameters/secure_redirects/disable/secure_redirects.sh
./network/parameters/tcp_syncookies/disable/tcp_syncookies.sh

./network/protocols/dccp/disable/dccp.sh
./network/protocols/rds/disable/rds.sh
./network/protocols/sctp/disable/sctp.sh
./network/protocols/ipv6/disable/ipv6.sh
./network/protocols/tipc/disable/tipc.sh
./network/protocols/wireless/disable/wireless.sh

./network/firewall/purge/purge.sh
./network/firewall/install_ufw.sh
./network/firewall/loopback.sh
./network/firewall/outbound_connection.sh
./network/firewall/firewall_rules.sh
./network/firewall/allow.sh

./logging_auditing/ensure/auditd.sh
./logging_auditing/ensure/data_retention.sh
./logging_auditing/ensure/remediation/action_user_always_logged.sh
./logging_auditing/ensure/remediation/administration_scope_is_collected.sh
./logging_auditing/ensure/remediation/action_user_always_logged.sh

./kernel/usb/disable/usb.sh
./enable/kernel_randomize.sh

./filesystem/cramfs/disable/cramfs.sh
./filesystem/squashfs/disable/squashfs.sh
./filesystem/udf/disable/udf.sh