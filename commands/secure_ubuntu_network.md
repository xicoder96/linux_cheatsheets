# Securing up Ubuntu OS against Network Attacks

-  When defending against network-based attacks, you'll want to minimize hardware disclosures, prevent packet sniffers, harden firewall rules, and much more.

## Defend Against Hardware Enumeration
- **When connecting to new Wi-Fi networks and routers, spoof the Wi-Fi adapter's MAC address.**
- **This won't prevent a motivated attacker from learning which operating system you're using** but it may confuse and prevent them from discovering hardware information.
- If you appear on the network with an [Apple MAC address](https://www.adminsub.net/mac-address-finder/apple), the attacker may completely ignore your device.
- Or, they might try some macOS-specific attack against your device which won't work, because you're not actually using a MacBook — you only appear on the network as using Apple hardware. 
- This coupled with a spoofed browser user-agent may really confuse a passive adversary.

> To spoof your MAC address in Ubuntu, open up Network Manager and "Edit" your Wi-Fi connection. In the Identity tab, enter the MAC address you want to use into the Cloned Address box.

## Defend Against Listening Service Abuse

```bash
sudo netstat -ntpul

Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      651/systemd-resolve
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      806/cupsd
tcp6       0      0 ::1:631                 :::*                    LISTEN      806/cupsd
udp    47616      0 127.0.0.53:53           0.0.0.0:*                           651/systemd-resolve
udp        0      0 0.0.0.0:631             0.0.0.0:*                           812/cups-browsed
udp     2304      0 0.0.0.0:5353            0.0.0.0:*                           750/avahi-daemon: r
udp        0      0 0.0.0.0:38284           0.0.0.0:*                           750/avahi-daemon: r
udp6       0      0 :::37278                :::*                                750/avahi-daemon: r
udp6   25344      0 :::5353                 :::*                                750/avahi-daemon: r
```

- Disable or Remove CUPS
    - Cupsd is a scheduler for CUPS, a service used by applications to interface with printers. 
    - There are several Nmap NSE scripts designed to pull information from CUPS services and pose a very minor security risk. 
    - However, if you very rarely need to interact with printers, CUPS can be disabled using the below systemctl disable cups-browsed command. 
    - The changes will take effect after a reboot.
    - To Disable it
    ```bash
    systemctl disable cups-browsed

    Synchronizing state of cups-browsed.service with SysV service script with /lib/systemd/systemd-sysv-install.
    Executing: /lib/systemd/systemd-sysv-install disable cups-browsed
    ``` 
    - To Remove it
    ```bash
    sudo apt-get autoremove cups-daemon
    ```   
- Disable or Remove Avahi
    - The Avahi daemon implements Apple's Zeroconf architecture (also known as "Rendezvous" or "Bonjour"). 
    - The daemon registers local IP addresses and static services using mDNS/DNS-SD.
    - In 2011, a denial of service vulnerability was discovered in the avahi-daemon. While this CVE is quite old and low in severity, it illustrates how attackers on a local network find vulnerabilities in networking protocols and manipulate running services on a victim's device.
    - Avahi can also be completely removed with `sudo apt-get purge avahi-daemon`.
    ```bash
    sudo apt-get purge avahi-daemon
    ```

## Defend Against Port Abuse
    
- An amateur hacker might try to exfiltrate data on `port 1337` or create a reverse shell on `port 4444` (literally listed on Wikipedia as Metasploit's default port). 
- **A firewall that only allows outgoing transmissions on a handful of ports will stop leet h4x0rz dead in their tracks.**
- To manage port allowances, we'll use UFW, a program that aims to provide an easy to use interface while configuring firewalls.    

## References
- [Using Ubuntu as Your Primary OS, Part 2 (Network Attack Defense) ](https://null-byte.wonderhowto.com/how-to/locking-down-linux-using-ubuntu-as-your-primary-os-part-2-network-attack-defense-0185709/)
- [MAC Address Finder](https://www.adminsub.net/mac-address-finder/apple)
- [Stealthfully Sniff Wi-Fi Activity Without Connecting to a Target Router](https://null-byte.wonderhowto.com/how-to/stealthfully-sniff-wi-fi-activity-without-connecting-target-router-0183444/#jump-2findgetdata)