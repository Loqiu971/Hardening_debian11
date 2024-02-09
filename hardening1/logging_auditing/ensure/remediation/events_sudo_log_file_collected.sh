#!/usr/bin/env bash



{SUDO_LOG_FILE=$(grep -r logfile /etc/sudoers* | sed -e 's/.*logfile=//;s/,?.*//' -e 's/"//g') [ -n "${SUDO_LOG_FILE}" ] && printf " -w ${SUDO_LOG_FILE} -p wa -k sudo_log_file " >> /etc/audit/rules.d/50-sudo.rules || printf "ERROR: Variable 'SUDO_LOG_FILE_ESCAPED' is unset.\n"}
