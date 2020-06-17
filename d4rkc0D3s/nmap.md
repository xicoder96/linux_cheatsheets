# Nmap - Network Mapper

- Nmap  is a free and open source utility for network discovery and security auditing. 
- Many systems and network administrators also find it useful for tasks such as network inventory, managing service upgrade schedules, and monitoring host or service uptime. 
- Nmap uses raw IP packets in novel ways to determine what hosts are available on the network, what services (application name and version) those hosts are offering, what operating systems (and OS versions) they are running, what type of packet filters/firewalls are in use, and dozens of other characteristics. 
- It was designed to rapidly scan large networks, but works fine against single hosts. 

## Options

```shell
   testuser@ubuntu8:/~$ nmap

    Nmap 5.61TEST5 ( https://nmap.org )
    Usage: nmap [Scan Type(s)] [Options] {target specification}
    TARGET SPECIFICATION:
    Can pass hostnames, IP addresses, networks, etc.
    Ex: scanme.nmap.org, microsoft.com/24, 192.168.0.1; 10.0.0-255.1-254
    -iL : Input from list of hosts/networks
    -iR : Choose random targets
    --exclude : Exclude hosts/networks
    --excludefile : Exclude list from file
    HOST DISCOVERY:
    -sL: List Scan - simply list targets to scan
    -sn: Ping Scan - disable port scan
    -Pn: Treat all hosts as online -- skip host discovery
    -PS/PA/PU/PY[portlist]: TCP SYN/ACK, UDP or SCTP discovery to given ports
    -PE/PP/PM: ICMP echo, timestamp, and netmask request discovery probes
    -PO[protocol list]: IP Protocol Ping
    -n/-R: Never do DNS resolution/Always resolve [default: sometimes]
    --dns-servers : Specify custom DNS servers
    --system-dns: Use OS DNS resolver
    --traceroute: Trace hop path to each host
    SCAN TECHNIQUES:
    -sS/sT/sA/sW/sM: TCP SYN/Connect()/ACK/Window/Maimon scans
    -sU: UDP Scan
    -sN/sF/sX: TCP Null, FIN, and Xmas scans
    --scanflags : Customize TCP scan flags
    -sI : Idle scan
    -sY/sZ: SCTP INIT/COOKIE-ECHO scans
    -sO: IP protocol scan
    -b : FTP bounce scan
    PORT SPECIFICATION AND SCAN ORDER:
    -p : Only scan specified ports
        Ex: -p22; -p1-65535; -p U:53,111,137,T:21-25,80,139,8080,S:9
    -F: Fast mode - Scan fewer ports than the default scan
    -r: Scan ports consecutively - dont randomize
    --top-ports : Scan  most common ports
    --port-ratio : Scan ports more common than 
    SERVICE/VERSION DETECTION:
    -sV: Probe open ports to determine service/version info
    --version-intensity : Set from 0 (light) to 9 (try all probes)
    --version-light: Limit to most likely probes (intensity 2)
    --version-all: Try every single probe (intensity 9)
    --version-trace: Show detailed version scan activity (for debugging)
    SCRIPT SCAN:
    -sC: equivalent to --script=default
    --script=:  is a comma separated list of
            directories, script-files or script-categories
    --script-args=: provide arguments to scripts
    --script-args-file=filename: provide NSE script args in a file
    --script-trace: Show all data sent and received
    --script-updatedb: Update the script database.
    --script-help=: Show help about scripts.
                is a comma separted list of script-files or
            script-categories.
    OS DETECTION:
    -O: Enable OS detection
    --osscan-limit: Limit OS detection to promising targets
    --osscan-guess: Guess OS more aggressively
    TIMING AND PERFORMANCE:
    Options which take  are in seconds, or append 'ms' (milliseconds),
    's' (seconds), 'm' (minutes), or 'h' (hours) to the value (e.g. 30m).
    -T<0-5>: Set timing template (higher is faster)
    --min-hostgroup/max-hostgroup : Parallel host scan group sizes
    --min-parallelism/max-parallelism : Probe parallelization
    --min-rtt-timeout/max-rtt-timeout/initial-rtt-timeout : Specifies
        probe round trip time.
    --max-retries : Caps number of port scan probe retransmissions.
    --host-timeout : Give up on target after this long
    --scan-delay/--max-scan-delay : Adjust delay between probes
    --min-rate : Send packets no slower than  per second
    --max-rate : Send packets no faster than  per second
    FIREWALL/IDS EVASION AND SPOOFING:
    -f; --mtu : fragment packets (optionally w/given MTU)
    -D : Cloak a scan with decoys
    -S : Spoof source address
    -e : Use specified interface
    -g/--source-port : Use given port number
    --data-length : Append random data to sent packets
    --ip-options : Send packets with specified ip options
    --ttl : Set IP time-to-live field
    --spoof-mac : Spoof your MAC address
    --badsum: Send packets with a bogus TCP/UDP/SCTP checksum
    OUTPUT:
    -oN/-oX/-oS/-oG : Output scan in normal, XML, s|: Output in the three major formats at once
    -v: Increase verbosity level (use -vv or more for greater effect)
    -d: Increase debugging level (use -dd or more for greater effect)
    --reason: Display the reason a port is in a particular state
    --open: Only show open (or possibly open) ports
    --packet-trace: Show all packets sent and received
    --iflist: Print host interfaces and routes (for debugging)
    --log-errors: Log errors/warnings to the normal-format output file
    --append-output: Append to rather than clobber specified output files
    --resume : Resume an aborted scan
    --stylesheet : XSL stylesheet to transform XML output to HTML
    --webxml: Reference stylesheet from Nmap.Org for more portable XML
    --no-stylesheet: Prevent associating of XSL stylesheet w/XML output
    MISC:
    -6: Enable IPv6 scanning
    -A: Enable OS detection, version detection, script scanning, and traceroute
    --datadir : Specify custom Nmap data file location
    --send-eth/--send-ip: Send using raw ethernet frames or IP packets
    --privileged: Assume that the user is fully privileged
    --unprivileged: Assume the user lacks raw socket privileges
    -V: Print version number
    -h: Print this help summary page.
    EXAMPLES:
    nmap -v -A scanme.nmap.org
    nmap -v -sn 192.168.0.0/16 10.0.0.0/8
    nmap -v -iR 10000 -Pn -p 80
    SEE THE MAN PAGE (https://nmap.org/book/man.html) FOR MORE OPTIONS AND EXAMPLES
```
## Typical Usage

```bash
    # First, we’ll sweep the network with a simple Ping scan to determine which hosts are online.
    [root] nmap -sP 10.0.0.0/24
    Starting Nmap 4.01 ( http://www.insecure.org/nmap/ ) at
            2006-07-14 14:19 BST
            Host 10.0.0.1 appears to be up.
            MAC Address: 00:09:5B:29:FD:96 (Netgear)
            Host 10.0.0.2 appears to be up.
            MAC Address: 00:0F:B5:96:38:5D (Netgear)
            Host 10.0.0.4 appears to be up.
            Host 10.0.0.5 appears to be up.
            MAC Address: 00:14:2A:B1:1E:2E (Elitegroup Computer System Co.)
        Nmap finished: 256 IP addresses (4 hosts up) scanned in 5.399 seconds

    # we’re going to take a look at 10.0.0.1 and 10.0.0.2, both listed as Netgear in the ping sweep. 

    # We’ll scan 10.0.0.1 using a SYN scan [-sS] and -A to enable OS fingerprinting and version detection.
    [root] nmap -sS -A 10.0.0.1
    
    Starting Nmap 4.01 ( http://www.insecure.org/nmap/ ) at
        2006-07-14 14:23 BST
    Insufficient responses for TCP sequencing (0),
        OS detection may be less accurate
    Interesting ports on 10.0.0.1:
    (The 1671 ports scanned but not shown below are in state:
        closed)
    PORT   STATE SERVICE    VERSION
    80/tcp open  tcpwrapped
    MAC Address: 00:09:5B:29:FD:96 (Netgear)
    Device type: WAP
    Running: Compaq embedded, Netgear embedded
    OS details: WAP: Compaq iPAQ Connection Point or
            Netgear MR814
    
    Nmap finished: 1 IP address (1 host up) scanned in
            3.533 seconds

    # The only open port is 80/tcp - in this case, the web admin interface for the router. 
    
    # OS fingerprinting guessed it was a Netgear Wireless Access Point - in fact this is a Netgear (wired) ADSL router. 
    # As it said, though, there were insufficient responses for TCP sequencing to accurately detect the OS.

    # Now we’ll do the same for 10.0.0.2...
   [root] nmap -sS -A 10.0.0.2
   
   Starting Nmap 4.01 ( http://www.insecure.org/nmap/ )
        at 2006-07-14 14:26 BST
   Interesting ports on 10.0.0.2:
   (The 1671 ports scanned but not shown below are in state:
        closed)
   PORT   STATE SERVICE VERSION
   80/tcp open  http    Boa HTTPd 0.94.11
   MAC Address: 00:0F:B5:96:38:5D (Netgear)
   Device type: general purpose
   Running: Linux 2.4.X|2.5.X
   OS details: Linux 2.4.0 - 2.5.20
   Uptime 14.141 days (since Fri Jun 30 11:03:05 2006)
    
   Nmap finished: 1 IP address (1 host up) scanned in 9.636
        seconds     

    # Interestingly, the OS detection here listed Linux, and the version detection was able to detect the httpd running. 
    # The accuracy of this is uncertain, this is a Netgear home wireless access point, so it could be running some embedded Linux!

    # Now we’ll move on to 10.0.0.4 and 10.0.0.5, these are likely to be normal computers running on the network...
    [root] nmap -sS -P0 -A -v 10.0.0.4
    
    Starting Nmap 4.01 ( http://www.insecure.org/nmap/ ) at
        2006-07-14 14:31 BST
    DNS resolution of 1 IPs took 0.10s. Mode:
            Async [#: 2, OK: 0, NX: 1, DR: 0, SF: 0, TR: 1, CN: 0]
    Initiating SYN Stealth Scan against 10.0.0.4 [1672 ports] at 14:31
    Discovered open port 21/tcp on 10.0.0.4
    Discovered open port 22/tcp on 10.0.0.4
    Discovered open port 631/tcp on 10.0.0.4
    Discovered open port 6000/tcp on 10.0.0.4
    The SYN Stealth Scan took 0.16s to scan 1672 total ports.
    Initiating service scan against 4 services on 10.0.0.4 at 14:31
    The service scan took 6.01s to scan 4 services on 1 host.
    For OSScan assuming port 21 is open, 1 is closed, and neither are
            firewalled
    Host 10.0.0.4 appears to be up ... good.
    Interesting ports on 10.0.0.4:
    (The 1668 ports scanned but not shown below are in state: closed)
    PORT     STATE SERVICE VERSION
    21/tcp   open  ftp     vsftpd 2.0.3
    22/tcp   open  ssh     OpenSSH 4.2 (protocol 1.99)
    631/tcp  open  ipp     CUPS 1.1
    6000/tcp open  X11      (access denied)
    Device type: general purpose
    Running: Linux 2.4.X|2.5.X|2.6.X
    OS details: Linux 2.4.0 - 2.5.20, Linux 2.5.25 - 2.6.8 or
        Gentoo 1.2 Linux 2.4.19 rc1-rc7
    TCP Sequence Prediction: Class=random positive increments
                        Difficulty=4732564 (Good luck!)
    IPID Sequence Generation: All zeros
    Service Info: OS: Unix 
    Nmap finished: 1 IP address (1 host up) scanned in 8.333 seconds
                Raw packets sent: 1687 (74.7KB) | Rcvd: 3382 (143KB)

    #  we can deduce that 10.0.0.4 is a Linux system (in fact, the one I’m typing this tutorial on!) running a 2.4 to 2.6 kernel (Actually, Slackware Linux 10.2 on a 2.6.19.9 kernel) with open ports 21/tcp, 22/tcp, 631/tcp and 6000/tcp. 
    # All but 6000 have version information listed. 

    # The scan found the IPID sequence to be all zeros, which makes it useless for idle scanning, and the TCP Sequence prediction as random positive integers. The -v option is needed to get Nmap to print the IPID information out!

   # Now, onto 10.0.0.5... 
   [root] nmap -sS -P0 -A -v 10.0.0.5
   
   Starting Nmap 4.01 ( http://www.insecure.org/nmap/ )
        at 2006-07-14 14:35 BST
   Initiating ARP Ping Scan against 10.0.0.5 [1 port] at 14:35
   The ARP Ping Scan took 0.01s to scan 1 total hosts.
   DNS resolution of 1 IPs took 0.02s. Mode: Async
       [#: 2, OK: 0, NX: 1, DR: 0, SF: 0, TR: 1, CN: 0]
   Initiating SYN Stealth Scan against 10.0.0.5 [1672 ports] at 14:35
   The SYN Stealth Scan took 35.72s to scan 1672 total ports.
   Warning:  OS detection will be MUCH less reliable because we did
        not find at least 1 open and 1 closed TCP port
   Host 10.0.0.5 appears to be up ... good.
   All 1672 scanned ports on 10.0.0.5 are: filtered
   MAC Address: 00:14:2A:B1:1E:2E (Elitegroup Computer System Co.)
   Too many fingerprints match this host to give specific OS details
   TCP/IP fingerprint:
   SInfo(V=4.01%P=i686-pc-linux-gnu%D=7/14%Tm=44B79DC6%O=-1%C=-1%M=00142A)
   T5(Resp=N)
   T6(Resp=N)
   T7(Resp=N)
   PU(Resp=N)
   
   Nmap finished: 1 IP address (1 host up) scanned in 43.855 seconds
            Raw packets sent: 3369 (150KB) | Rcvd: 1 (42B)

# No open ports, and Nmap couldn’t detect the OS. 
# This suggests that it is a firewalled or otherwise protected system, with no services running (and yet it responded to ping sweeps).

# We now have rather more information about this network than we did when we started, and can guess at several other things based on these results. 
# Using that information, and the more advanced Nmap scans, we can obtain further scan results which will help to plan an attack, or to fix weaknesses, in this network.


```

## Nmap Scan Types

1. TCP  connect() Scan [-sT]
- A TCP scan is generally used to check and complete a three-way handshake between you and a chosen target system. 
- **A TCP scan is generally very noisy and can be detected with almost little to no effort.** - because the services can log the sender IP address - and might trigger Intrusion Detection Systems. 

2. UDP SCAN [-sU]
- UDP scans are used to check whether there is any UDP port up and listening for incoming requests on the target machine. 
- Unlike TCP, UDP has no mechanism to respond with a positive acknowledgment, so there is always **a chance for a false positive in the scan results.** 
- However, **UDP scans are used to reveal Trojan horses that might be running on UDP ports or even reveal hidden RPC services.** 
- This type of scan tends to be quite slow because machines, in general, tend to slow down their responses to this kind of traffic as a precautionary measure.

3. SYN SCAN [-sS]
- This is another form of TCP scan. 
- The difference is unlike a normal TCP scan, nmap itself crafts a syn packet, which is the first packet that is sent to establish a TCP connection. 
- What is important to note here is that **the connection is never formed**, rather the responses to these specially crafted packets are analyzed by Nmap to produce scan results.

4. ACK SCAN [-sA]
- ACK scans are used to determine whether a particular port is filtered or not. 
- This proves to be extremely helpful when **trying to probe for firewalls and their existing set of rules.** 
- Simple packet filtering will allow established connections (packets with the ACK bit set), whereas a more sophisticated stateful firewall might not.

5. FIN SCAN [-sF]
- Also a stealthy scan, like the SYN scan, but sends a TCP FIN packet instead. 
- Most but not all computers will send an RST packet (reset packet) back if they get this input, so the FIN scan can show false positives and negatives, but it may get under the radar of some IDS programs and other countermeasures.

6. NULL SCAN [-sN]
- Null scans are extremely stealthy scan and what they do is as the name suggests — they set all the header fields to null. 
- Generally, this is not a valid packet and a few targets will not know how to deal with such a packet. 
- Such targets are generally some version of windows and scanning them with NULL packets may end up producing unreliable results. 
- On the other hand, when a system is not running windows this can be used as an effective way to get through.

7. XMAS SCAN [-sX]
- Just like null scans, these are also stealthy in nature. 
- Computers running windows will not respond to Xmas scans due to the way their TCP stack is implemented. 
- The scan derives its name from the set of flags that are turned on within the packet that is sent out for scanning. 
- XMAS scans are used to manipulate the PSH, URG and FIN flags that can be found in the TCP header.

8. RPC SCAN [-sR]
- RPC scans are used to discover machines that respond to Remote Procedure Call services (RPC). RPC allows commands to be run on a certain machine remotely, under a certain set of connections. 
- RPC service can run on an array of different ports, hence, it becomes hard to infer from a normal scan whether RPC services are running or not. 
- It is generally a good idea to run an RPC scan from time to time to find out where you have these services running.

9. IDLE SCAN [-sI]
- IDLE scan is the stealthiest of all scans discussed in this nmap tutorial, as the packets are bounced off an external host. 
- Control over the host is generally not necessary, but the host needs to meet a specific set of conditions. 
- It is one of the more controversial options in Nmap since it only has a use for malicious attacks.

## Timing and Hiding Scans

### Timings

- Nmap adjusts its timings automatically depending on network speed and response times of the victim
- There are six predefined timing policies which can be specified by name or number (starting with 0, corresponding to Paranoid timing). 
- A -T Paranoid (or -T0) scan will wait (generally) at least 5 minutes between each packet sent-This makes it almost impossible for a firewall to detect a port scan in progress (since the scan takes so long it would most likely be attributed to random network traffic)-Such a scan will still show up in logs, but it will be so spread out that most analysis tools or humans will miss it completely.
- A -T Insane (or -T5) scan will map a host in very little time, provided you are on a very fast network or don’t mind losing some information along the way.

### Decoys [-D]

- This option makes it look like those decoys are scanning the target network. 
- It does not hide your own IP, but it makes your IP one of a torrent of others supposedly scanning the victim at the same time. 
- This not only makes the scan look more scary, but reduces the chance of you being traced from your scan (difficult to tell which system is the "real" source).

###  Turning Off Ping 

-  The `-P0` (that’s a zero) option allows you to switch off ICMP pings. 

- The `-PT` option switches on TCP Pings, you can specify a port after the -PT option to be the port to use for the TCP ping.

- Disabling pings has two advantages: First, it adds extra stealth if you’re running one of the more stealthy attacks, and secondly it allows Nmap to scan hosts which don’t reply to pings (ordinarily, Nmap would report those hosts as being "down" and not scan them).

- In conjunction with `-PT`, you can use `-PS` to send SYN packets instead of ACK packets for your TCP Ping.

- The `-PU` option (with optional port list after) sends UDP packets for your "ping". This may be best to send to suspected-closed ports rather than open ones, since open UDP ports tend not to respond to zero-length UDP packets.

- Other ping types are `-PE` (Standard ICMP Echo Request), `-PP` (ICMP Timestamp Request), `-PM` (Netmask Request) and `-PB` (default, uses both ICMP Echo Request and TCP ping, with ACK packets)

### Fragmenting

-  The `-f` option splits the IP packet into tiny fragments when used with `-sS`, `-sF`, `-sX` or `-sN`. 
- This makes it more difficult for a firewall or packet filter to determine the packet type. 
- Note that **many modern packet filters and firewalls (including iptables) feature optional defragmenters for such fragmented packets, and will thus reassemble the packet to check its type before sending it on.** 
- Less complex firewalls will not be able to cope with fragmented packets this small and will most likely let the OS reassemble them and send them to the port they were intended to reach. 
- *Using this option could crash some less stable software and hardware since packet sizes get pretty small with this option!*

### Idle Scanning

- See the section on `-sI` for information about idle scans.

>  Highly recommended, `-v` - Use `-v` twice for more verbosity - The option `-d` can also be used (once or twice) to generate more verbose output. 

## Good References
- [Offical tutorial - bennieston-tutorial](https://nmap.org/bennieston-tutorial/)
- [Edureka!](https://www.edureka.co/blog/nmap-tutorial/)
- [Hacker Target](https://hackertarget.com/nmap-tutorial/)
- [DEFCON - Hacking nmap conference](https://youtu.be/bKUjyeQ78AU)
