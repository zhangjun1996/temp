#!/bin/sh
iptables -C POSTROUTING -t nat -s 192.168.16.0/24 -j MASQUERADE && iptables -A POSTROUTING -t nat -s 192.168.16.0/24 -j MASQUERADE
