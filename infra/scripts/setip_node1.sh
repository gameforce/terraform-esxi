#!/bin/bash
# set static ip for kube-master

# Get device name
DEVICE="$(ip link | grep -i '2:\ ' | cut -d ':' -f 2)"
IPADDR="192.168.11.21/24" 

# Set the IP
/sbin/ip a add $IPADDR dev $DEVICE

# Set the Gateway
/sbin/ip route add 192.168.11.0/24 dev $DEVICE

# Set DNS
echo 'nameserver 192.168.11.5' > /etc/resolv.conf
echo 'search gameforce.net' > /etc/resolv.conf

# Set Hostname
/bin/hostnamectl set-hostname kube-node1

# Reboot
/sbin/shutdown -r now





