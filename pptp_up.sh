#!/bin/sh
# if there is no rule, add rules to nat table on POSTROUTING chan that nat source ip adrr 192.168.16.0/24 to internet
iptables -C POSTROUTING -t nat -s 192.168.16.0/24 -j MASQUERADE || iptables -A POSTROUTING -t nat -s 192.168.16.0/24 -j MASQUERADE
