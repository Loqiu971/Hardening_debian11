#!/usr/bin/env bash
{
	# Check if GNMOE Desktop Manager is installed. If package isn't installed, recommendation is Not Applicable\n
	# determine system's package manager
	l_pkgoutput=""
	if command -v dpkg-query > /dev/null 2>&1; then
		l_pq="dpkg-query -W"
	elif command -v rpm > /dev/null 2>&1; then
		l_pq="rpm -q"
	fi
	# Check if GDM is installed
	l_pcl="gdm gdm3" # Space seporated list of packages to check
	for l_pn in $l_pcl; do
		$l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="y" && echo -e "\n- Package: \"$l_pn\" exists on the system\n - remediating configuration if needed"
	done
	# Check configuration (If applicable)
	if [ -n "$l_pkgoutput" ]; then
		# Look for idle-delay to determine profile in use, needed for remaining tests
		l_kfd="/etc/dconf/db/$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
		# Look for lock-delay to determine profile in use, needed for remaining tests
		l_kfd2="/etc/dconf/db/$(grep -Psril '^\h*lock-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
		if [ -d "$l_kfd" ]; then # If key file directory doesnt exist, options can't be locked
			if grep -Prilq '^\h*\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd"; then
				echo " - \"idle-delay\" is locked in \"$(grep -Pril'^\h*\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd")\""
			else
				echo "creating entry to lock \"idle-delay\""
				[ ! -d "$l_kfd"/locks ] && echo "creating directory $l_kfd/locks" && mkdir "$l_kfd"/locks
				{
					echo -e '\n# Lock desktop screensaver idle-delay setting'
					echo '/org/gnome/desktop/session/idle-delay'
				} >> "$l_kfd"/locks/00-screensaver
			fi
		else
			echo -e " - \"idle-delay\" is not set so it can not be locked\n- Please follow Recommendation \"Ensure GDM screen locks when the user is idle\" and follow this Recommendation again"
		fi
		if [ -d "$l_kfd2" ]; then # If key file directory doesn't exist, options can't be locked
			if grep -Prilq '^\h*\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2"; then
				echo " - \"lock-delay\" is locked in \"$(grep -Pril'^\h*\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2")\""
			else
				echo "creating entry to lock \"lock-delay\""
				[ ! -d "$l_kfd2"/locks ] && echo "creating directory $l_kfd2/locks" && mkdir "$l_kfd2"/locks
				{
					echo -e '\n# Lock desktop screensaver lock-delay setting'
					echo '/org/gnome/desktop/screensaver/lock-delay'
				} >> "$l_kfd2"/locks/00-screensaver
			fi
		else
			echo -e " - \"lock-delay\" is not set so it can not be locked\n- Please follow Recommendation \"Ensure GDM screen locks when the user is idle\" and follow this Recommendation again"
		fi
	else
		echo -e " - GNOME Desktop Manager package is not installed on the system\n - Recommendation is not applicable"
	fi
}
