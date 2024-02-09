#!/usr/bin/env bash
{
	l_output="" l_output2=""
	l_parlist="net.ipv4.icmp_ignore_bogus_error_responses=1"
	l_searchloc="/run/sysctl.d/*.conf /etc/sysctl.d/*.conf /usr/local/lib/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /lib/sysctl.d/*.conf /etc/sysctl.conf $([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/{print $2}' /etc/default/ufw)"
	l_kpfile="/etc/sysctl.d/60-netipv4_sysctl.conf"
	KPF()
	{
		# comment out incorrect parameter(s) in kernel parameter file(s)
		l_fafile="$(grep -s  "^\s*$l_kpname" $l_searchloc | grep -Pv "\h*=\h*$l_kpvalue\b\h*" | awk -F: '{print $1}')"
		for l_bkpf in $l_fafile; do
			echo -e "\n - Commenting out \"$l_kpname\" in \"$l_bkpf\""
			sed -ri "/$l_kpname/s/^/# /" "$l_bkpf"
		done
		# Set correct parameter in a kernel parameter file
		if ! grep -Pslq  "^\h*$l_kpname\h*=\h*$l_kpvalue\b\h*(#.*)?$" $l_searchloc; then
			echo -e "\n - Setting \"$l_kpname\" to \"$l_kpvalue\" in \"$l_kpfile\""
			echo "$l_kpname = $l_kpvalue" >> "$l_kpfile"
		fi
		# Set correct parameter in active kernel parameters
		l_krp="$(/sbin/sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)"
		if [ "$l_krp" != "$l_kpvalue" ]; then
			echo -e "\n - Updating \"$l_kpname\" to \"$l_kpvalue\" in the active kernel parameters"
			/sbin/sysctl -w "$l_kpname=$l_kpvalue"
			/sbin/sysctl -w "$(awk -F'.' '{print $1"."$2".route.flush=1"}' <<< "$l_kpname")"
		fi
	}
	for l_kpe in $l_parlist; do
		l_kpname="$(awk -F= '{print $1}' <<< "$l_kpe")"
		l_kpvalue="$(awk -F= '{print $2}' <<< "$l_kpe")"
		KPF
	done
}
