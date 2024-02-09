#!/usr/bin/env bash

l_mname="cramfs" # Nom du module à vérifier

# Vérifie si le module existe sur le système
if ! /sbin/modprobe -n -v "$l_mname" &> /dev/null; then
    echo -e " - Le module \"$l_mname\" n'existe pas sur le système"
else
    # Remediation pour la charge (loadable)
    l_loadable="$(/sbin/modprobe -n -v "$l_mname")"
    if [ "$(wc -l <<< "$l_loadable")" -gt 1 ]; then
        l_loadable="$(grep -P "(^\s*install|\b$l_mname)\b" <<< "$l_loadable")"
        if ! grep -Pq '^\s*install /bin/(true|false)' <<< "$l_loadable"; then
            echo -e " - Configuration du module \"$l_mname\" pour le rendre non chargeable"
            echo -e "install $l_mname /bin/false" >> "/etc/modprobe.d/$l_mname.conf"
        fi
    fi

    # Remediation pour le déchargement (unloaded)
    if /sbin/lsmod | grep "$l_mname" &> /dev/null; then
        echo -e " - Déchargement du module \"$l_mname\""
        /sbin/modprobe -r "$l_mname"
    fi

    # Remediation pour la liste noire (deny list)
    if ! /sbin/modprobe --showconfig | grep -Pq "^\s*blacklist\s+$l_mname\b"; then
        echo -e " - Liste noire du module \"$l_mname\""
        echo -e "blacklist $l_mname" >> "/etc/modprobe.d/$l_mname.conf"
    fi
fi
