#!/bin/sh
# if there is no rule, add rules to nat table on POSTROUTING chan that nat source ip adrr 192.168.16.0/24 to internet
iptables -C POSTROUTING -t nat -s 192.168.16.0/24 -j MASQUERADE || iptables -A POSTROUTING -t nat -s 192.168.16.0/24 -j MASQUERADE
#disable data packge from ppp+ interface to 192.168.31.0/24(my router lan)
iptables -t filter -A FORWARD -i ppp+ -d 192.168.31.0/24 -j REJECT
#disable data packge from ppp+ interface to 192.168.16.0/24(ppp+ device ip lan)
iptables -t filter -A INPUT -i ppp+ -j DROP
