#!/usr/bin/env bash

rm /etc/issue
rm /etc/issue.net
cat > /etc/issue <<END

0 INFO ENCORE UNE FOIS

END

cat > /etc/issue.net <<END

0 INFO ENCORE UNE FOIS ARRETE DE FORCER

END


chown root:root $(readlink -e /etc/issue)
chmod u-x,go-wx $(readlink -e /etc/issue)
chown root:root $(readlink -e /etc/issue.net)
chmod u-x,go-wx $(readlink -e /etc/issue.net)
