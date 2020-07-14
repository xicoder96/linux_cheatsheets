#!/bin/bash

echo -e "\e[1;32m Enter Your Starting IP address:\e[0m"
read FirstIP

echo -e "\e[1;32m Enter Your last IP address:\e[0m"
read LastOctetIP

echo -e "\e[1;32m Enter the port number you want to scan for:\e[0m"
read port

sudo nmap -sS $FirstIP-$LastOctetIP -p $port > /dev/null -oG ~/nmapReport

cat ~/nmapReport | grep open > scan_report.txt

echo -e "\e[1;35m Scan Results\e[0m"
cat scan_report.txt