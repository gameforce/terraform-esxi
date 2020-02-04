#!/bin/bash
# set static ip for kube-master

# Get device name
DEVICE="$(ip link | grep -i '2:\ ' | cut -d ':' -f 2)"
IPADDR="192.168.11.40/24" 

# Flush the current IP
/sbin/ip addr flush dev $DEVICE

# Set the IP
/sbin/ip a add $IPADDR dev $DEVICE

# Set the Gateway
# /sbin/ip route add 192.168.11.0/24 dev $DEVICE

# Set DNS
echo 'nameserver 192.168.11.5' > /etc/resolv.conf
echo 'search gameforce.net' > /etc/resolv.conf

# Set Hostname
/bin/hostnamectl set-hostname sid

# Reboot
/sbin/shutdown -r +1

exit 0;





