#!/usr/bin/env bash

/sbin/ufw status numbered
/sbin/ufw allow out on all
/sbin/ufw status numbered
