#!/usr/bin/env bash
{
	l_pkgoutput=""
	if command -v dpkg-query > /dev/null 2>&1; then
		l_pq="dpkg-query -W"
	elif command -v rpm > /dev/null 2>&1; then
		l_pq="rpm -q"
	fi
	l_pcl="gdm gdm3" # Space seporated list of packages to check
	for l_pn in $l_pcl; do
		$l_pq "$l_pn" > /dev/null 1>&1 && l_pkgoutput="$l_pkgoutput\n- Package: \"$l_pn\" exists on the system\n - checking configuration"
	done
	if [ -n "$l_pkgoutput" ]; then
		l_gdmprofile="gdm" # Set this to desired profile name IaW Local site policy
		l_bmessage="'Authorized uses only. All activity may be monitored and reported'"
		 # Set to desired banner message
		if [ ! -f "/etc/dconf/profile/$l_gdmprofile" ]; then
			echo "Creating profile \"$l_gdmprofile\""
			echo -e "user-db:user\nsystem-db:$l_gdmprofile\nfile-db:/usr/share/$l_gdmprofile/greeter-dconf-defaults" > /etc/dconf/profile/$l_gdmprofile
		fi
		if [ ! -d "/etc/dconf/db/$l_gdmprofile.d/" ]; then
			echo "Creating dconf database directory\"/etc/dconf/db/$l_gdmprofile.d/\""
			mkdir /etc/dconf/db/$l_gdmprofile.d/
		fi
		if ! grep -Piq '^\h*banner-message-enable\h*=\h*true\b' /etc/dconf/db/$l_gdmprofile.d/*; then
			echo "creating gdm keyfile for machine-wide settings"
			if ! grep -Piq -- '^\h*banner-message-enable\h*=\h*' /etc/dconf/db/$l_gdmprofile.d/*; then
				l_kfile="/etc/dconf/db/$l_gdmprofile.d/01-banner-message"
				echo -e "\n[org/gnome/login-screen]\nbanner-message-enable=true" >> "$l_kfile"
			else
				l_kfile="$(grep -Pil -- '^\h*banner-message-enable\h*=\h*' /etc/dconf/db/$l_gdmprofile.d/*)" ! grep -Pq '^\h*\[org\/gnome\/login-screen\]' "$l_kfile" && sed -ri '/^\s*banner-message-enable/ i\[org/gnome/login-screen]' "$l_kfile" ! grep -Pq '^\h*banner-message-enable\h*=\h*true\b' "$l_kfile" && sed -ri 's/^\s*(banner-message-enable\s*=\s*)(\S+)(\s*.*$)/\1true \3//' "$l_kfile" enable=true' "$l_kfile"'
			fi
		fi
		if ! grep -Piq "^\h*banner-message-text=[\'\"]+\S+" "$l_kfile"; then
			sed -ri "/^\s*banner-message-enable/ a\banner-message-text=$l_bmessage" "$l_kfile"
		fi
	#dconf update
	else
		echo -e "\n\n - GNOME Desktop Manager isn't installed\n- Recommendation is Not Applicable\n - No remediation required\n"
	fi
}
