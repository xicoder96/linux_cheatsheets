# Useful Packages

1. htop 
- An interactive process viewer

```bash
    sudo apt-get install htop
    htop
```

2. net-tools
- For more advanced tools and commands like `ifconfig`,`iwconfig`,....
```bash
    sudo apt-get install tor proxychains
```

3. visual studio code
- Visual Studio Code is a free source-code editor made by Microsoft 
```bash
    sudo apt-get install code 
    code <folder>
```

4. UFW & GUFW
- The default firewall configuration tool for Ubuntu is ufw. An abstraction over iptables.
- GUFW is the graphical interface for managing the same.
```bash
    sudo apt-get install ufw gufw 
```

5. macchanger
- For spoofing the mac address to keep your device protected on a public network.
```bash
    sudo apt-get install macchanger
    sudo macchanger <interface> -r # for random mac address; but be sure interface is not active before.
```

6. Proxychains & Tor
- For anonymity.
```bash
    sudo apt-get install tor proxychains
```


7. Snort
- Intrution Detection System.
```bash
    sudo apt-get install snort
    sudo snort 
    sudo snort -A console -q -c /etc/snort/snort.conf -i <interface> # Run Snort in IDS mode 

```



. vlc
- One of the best open source video player.
```bash
    sudo apt-get install vlc
```