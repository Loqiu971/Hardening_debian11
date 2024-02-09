#!/usr/bin/env bash

awk '/^ *-w/ &&/\/etc\/sudoers/ &&/ +-p *wa/ &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)' /etc/audit/rules.d/*.rules
/sbin/auditctl -l | awk '/^ *-w/  &&/\/etc\/sudoers/  &&/ +-p *wa/  &&(/ key= *[!-~]* *$/||/ -k *[!-~]* *$/)'
