#!/bin/bash

# This script is designed to find hosts with MySQL installed

if [ -z `which nmap` ]; then
    echo 'You have to install nmap first.'
    return
fi

sudo nmap -sS 192.168.43.0/24 -p 3306 > /dev/null -oG MySQLscan
cat MySQLscan | grep open > MySQLscan2 
cat MySQLscan2