#!/usr/bin/env bash

{
l_output=""
l_output2=""
l_mname="cramfs" # Nom du module à vérifier

# Vérifie si le module existe sur le système
if [ -z "$(/usr/sbin/modprobe -n -v "$l_mname" 2>&1 | grep -Pi 'FATAL: Module\s+'$l_mname'\s+not found in directory')" ]; then
    # Vérifie comment le module sera chargé
    l_loadable="$(/usr/sbin/modprobe -n -v "$l_mname")"
    [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P '(^\s*install|\b'$l_mname')\b' <<< "$l_loadable")"
    
    if grep -Pq '^\s*install /bin/(true|false)' <<< "$l_loadable"; then
        l_output="$l_output\n - module: \"$l_mname\" n'est pas chargeable: \"$l_loadable\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" est chargeable: \"$l_loadable\""
    fi
    
    # Vérifie si le module est actuellement chargé
    if ! /sbin/lsmod | grep "$l_mname" > /dev/null 2>&1; then
        l_output="$l_output\n - module: \"$l_mname\" n'est pas chargé"
    else
        l_output2="$l_output2\n - module: \"$l_mname\" est chargé"
    fi
    
    # Vérifie si le module est listé dans les modules blacklistés
    if /usr/sbin/modprobe --showconfig | grep -Pq '^\s*blacklist\s+'$l_mname'\b'; then
        l_output="$l_output\n - module: \"$l_mname\" est listé dans : \"$(/bin/grep -Pl '^\s*blacklist\s+'$l_mname'\b' /etc/modprobe.d/*)\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" n'est pas listé dans la liste noire"
    fi
else
    l_output="$l_output\n - Le module \"$l_mname\" n'existe pas sur le système"
fi

# Rapporte les résultats. Si aucune erreur n'est trouvée, le script passe
if [ -z "$l_output2" ]; then
    echo -e "\n- Résultat de l'audit:\n ** RÉUSSI **\n$l_output\n"
else
    echo -e "\n- Résultat de l'audit:\n ** ÉCHEC **\n - Raison(s) de l'échec de l'audit:\n$l_output2\n"
    [ -n "$l_output" ] && echo -e "\n- Correctement configuré:\n$l_output\n"
fi
}
