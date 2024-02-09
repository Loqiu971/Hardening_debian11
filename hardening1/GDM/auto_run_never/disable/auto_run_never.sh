#!/usr/bin/env bash
{
	l_pkgoutput="" l_output="" l_output2=""
	l_gpname="local" # Set to desired dconf profile name (default is local)
	# Check if GNOME Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n
	# determine system's package manager
	if command -v dpkg-query > /dev/null 2>&1; then
		l_pq="dpkg-query -W"
	elif command -v rpm > /dev/null 2>&1; then
		l_pq="rpm -q"
	fi
	# Check if GDM is installed
	l_pcl="gdm gdm3" # Space separated list of packages to check
	for l_pn in $l_pcl; do
		$l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n- Package: \"$l_pn\" exists on the system\n - checking configuration"
	done
	echo -e "$l_pkgoutput"
	# Check configuration (If applicable)
	if [ -n "$l_pkgoutput" ]; then
		echo -e "$l_pkgoutput"
		# Look for existing settings and set variables if they exist
		l_kfile="$(grep -Prils -- '^\h*autorun-never\b' /etc/dconf/db/*.d)"
		# Set profile name based on dconf db directory ({PROFILE_NAME}.d)
		if [ -f "$l_kfile" ]; then
			l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")"
			echo " - updating dconf profile name to \"$l_gpname\""
		fi
		[ ! -f "$l_kfile" ] && l_kfile="/etc/dconf/db/$l_gpname.d/00-media-autorun"
		# Check if profile file exists
		if grep -Pq -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*; then
			echo -e "\n - dconf database profile exists in: \"$(grep -Pl -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*)\""
		else
			[ ! -f "/etc/dconf/profile/user" ] && l_gpfile="/etc/dconf/profile/user" || l_gpfile="/etc/dconf/profile/user2"
			echo -e " - creating dconf database profile"
			{
				echo -e "\nuser-db:user"
				echo "system-db:$l_gpname"
			} >> "$l_gpfile"
		fi
		# create dconf directory if it doesn't exists
		l_gpdir="/etc/dconf/db/$l_gpname.d"
		if [ -d "$l_gpdir" ]; then
			echo " - The dconf database directory \"$l_gpdir\" exists"
		else
			echo " - creating dconf database directory \"$l_gpdir\""
			mkdir "$l_gpdir"
		fi
		# check autorun-never setting
		if grep -Pqs -- '^\h*autorun-never\h*=\h*true\b' "$l_kfile"; then
			echo " - \"autorun-never\" is set to true in: \"$l_kfile\""
		else
			echo " - creating or updating \"autorun-never\" entry in \"$l_kfile\""
			if grep -Psq -- '^\h*autorun-never' "$l_kfile"; then
				sed -ri 's/(^\s*autorun-never\s*=\s*)(\S+)(\s*.*)$/\1true \3/' "$l_kfile"
			else
				! grep -Psq -- '\^\h*\[org\/gnome\/desktop\/media-handling\]\b' "$l_kfile" && echo '[org/gnome/desktop/media-handling]' >> "$l_kfile"
				sed -ri '/^\s*\[org\/gnome\/desktop\/media-handling\]/a\\nautorun-never=true' "$l_kfile"
			fi
		fi
	else
		echo -e "\n - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable"
	fi
	# update dconf database
	dconf update
}
