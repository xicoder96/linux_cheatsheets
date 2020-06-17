# NETWORKING COMMANDS

```bash
    ## Display all network interfaces and ip address (package:net-tools)
    ifconfig -a

    ## Display eth0 address and details
    ifconfig eth0

    ## Query or control network driver and hardware settings(package:ethtool)
    ethtool eth0

    ## Send ICMP echo request to host
    ping host

    ## Display whois information for domain (package:whois)
    whois google.com

    ## Display DNS information for domain
    dig google.com

    ## Reverse lookup of IP_ADDRESS
    dig -x IP_ADDRESS

    ## Display DNS ip address for domain
    host domain

    ## Another utility to investigate sockets
    ss -a

    ## Display the network address of the host name.
    hostname -i

    ## Display all local ip addresses
    hostname -I

    ## Download http://domain.com/file
    wget http://domain.com/file

    ## Display listening tcp and udp ports and corresponding programs
    netstat -tulpn

    ## Capture and display all packets on interface eth0
    sudo tcpdump -i eth0

    ## Monitor all traffic on port 80 ( HTTP )
    sudo tcpdump -i eth0 'port 80'

```