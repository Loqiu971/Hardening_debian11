#!/usr/bin/env bash

chmod -R 700 ./

filesystem/cramfs/verif/cramfs.sh
filesystem/squashfs/verif/squashfs.sh
filesystem/udf/verif/udf.sh

GDM/auto_mounting/verif/auto_mounting.sh
GDM/auto_mounting_over/verif/auto_mounting_over.sh
GDM/auto_run_never/verif/auto_run_never.sh
GDM/auto_run_never_over/verif/auto_run_never_over.sh
GDM/loggin_banner/verif/loggin_banner.sh
GDM/screen_lock/verif/screen_lock.sh
GDM/screen_lock_over/verif/screen_lock_over.sh

kernel/verif/deamon_synchro.sh
kernel/verif/kernel_randomize.sh
kernel/usb/verif/usb.sh

network/parameters/accept_ra/verif/accept_ra.sh
network/parameters/accept_redirects/verif/accept_redirects.sh
network/parameters/accept_source_route/verif/accept_source_route.sh
network/parameters/fowarding/verif/ip_fowarding.sh
network/parameters/icmp_echo_ignore_broadcoasts/verif/icmp_echo_ignore_broadcoasts.sh
network/parameters/icmp_ignore_bogus_error_responses/verif/icmp_ignore_bogus_error_responses.sh
network/parameters/log_martians/verif/log_martians.sh
network/parameters/redirect_sending/verif/redirect_sending.sh
network/parameters/rp_filter/verif/rp_filter.sh
network/parameters/secure_redirects/verif/secure_redirects.sh
network/parameters/tcp_syncookies/verif/tcp_syncookies.sh

network/protocols/dccp/verif/dccp.sh
network/protocols/ipv6/verif/ipv6.sh
network/protocols/rds/verif/rds.sh
network/protocols/sctp/verif/sctp.sh
network/protocols/tipc/verif/tipc.sh
network/protocols/wireless/verif/wireless.sh

logging_auditing/ensure/audit/action_user_always_logged.sh
logging_auditing/ensure/audit/administration_scope_is_collected.sh
logging_auditing/ensure/audit/events_sudo_log_file_collected.sh