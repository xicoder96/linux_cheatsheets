#!/bin/bash

if [ -z `which ufw` ]; then
    echo 'You have to install ufw first.'
    return
fi

# Deny All Incoming & Outgoing Connections
if [ -z "sudo ufw status" ] ; then
  echo "Usage: $0 [-c X] pattern {filename}" >&2; exit 0
fi
echo "Enabling UFW..."
# Use the sudo ufw enable command to enable UFW.
sudo ufw enable
echo -e "ufw \e[1;32m Enabled\e[0m"
# Disallow all incoming connections with the following.
echo "Disallow all incoming connections..."
sudo ufw default deny incoming
# Next, disallow all forward connections:
echo "Disallow all forward connections..."
sudo ufw default deny forward
# And then disallow all outgoing connections:
echo "Disallow all outgoing connections..."
sudo ufw default deny outgoing
echo "Find Your Wireless Interface..."
echo "Found!"
for interface in $(ip link | awk -F: '$0 !~ "lo|vir|^[^0-9]"{print $2;getline}')
do
    echo -e "Adding rules for \e[1;34m${interface}\e[0m..."
    echo "allowing DNS 1.1.1.1 on port 53..."
    sudo ufw allow out on ${interface} to 1.1.1.1 proto udp port 53 comment "allow DNS on ${interface}"
    echo -e "allowing HTTP on port 80..."
    sudo ufw allow out on ${interface} to any proto tcp port 80 comment "allow HTTP on ${interface}"
    echo -e "allow HTTPS on port 443..."
    sudo ufw allow out on ${interface} to any proto tcp port 443 comment "allow HTTPS on ${interface}"
done
sudo ufw status
