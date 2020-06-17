# Getting started with terms & technology

- WiFi is primarily a local area networking (LAN) technology designed to provide in-building broadband coverage.

- stands for Wireless Fidelity.
- based on IEEE 802.11 specification. 
- it operates over a larger 20 MHz bandwidth - hence, remarkably higher peak data rates than do 3G systems.
- WiFi is Half Duplex , becoz - all WiFi networks are contention-based TDD systems - ie, **the access point and the mobile stations all view for use of the same channel.**
- Channel Bandwidth - fixed channel bandwidth of 25 MHz for 802.11b and 20 MHz for either 802.11a or g networks.
- **Radio Signals are used.**
- Access points, consisting of antennas and routers, are the main source that transmit and receive radio waves. 
    - Public areas - stronger - radius of 300-500 feet.
    - Homes - weaker yet effective - radius of 100-150 feet.

- **WiFi Cards** - WiFi cards can be external or internal - For laptops, this card will be a PCMCIA card which you insert to the PCMCIA slot on the laptop.
- **WiFi Hotspots** 
    - Created by installing an access point to an internet connection.
    - wireless signal over a short distance - typically covers around 300 feet.
    - 802.11b is the most common specification for hotspots worldwide.

- IEEE 802.11 wireless LANs - uses Media access control protocol - Carrier Sense Multiple Access with Collision Avoidance (CSMA/CA)
- According to DCF (Distributed Control Function) - a WiFi station will transmit only when the channel is clear - All transmissions are acknowledged -> so if a station does not receive an acknowledgement -> it assumes a collision occurred and retries after a random waiting interval.

- Summary - **To begin, the access point that sends out the radio frequency (RF) signal is known as the AP. These APs are capable of sending out signals (between 2.4 and 5 Ghz) that comply with a number of different standards. These standards are known as 802.11a, 802.11b, 802.11g, and 802.11n. In the very near future, we'll see a new standard that's tentatively named 802.11ac.**

- Related Attacks possible 
    - wardriving (act of searching for Wi-Fi wireless networks by an attacker usually in a moving vehicle, using a laptop or smartphone)
    - DOS attacks 
    - password hacking (WEP, WPA, WPA2, WPS, and WPA-enterprise) 
    - rogue APs 
    - evil twins 
    - Wi-Fi MitM  
    - Wi-Fi snooping

## How secured are wireless networks?

- Our attack approach will depend upon which of these security technologies is being deployed.

### WEP (Wired Equivalent Privacy)

- The first wireless security scheme employed
- Designed to provide security to the end-user - equivalent to the privacy that was enjoyed in a wired environment(Ethernet).
- It failed miserably
    - easy to crack because of a flawed implementation of the RC4 encryption algorithm. 
    - It's not unusual to be able to crack WEP in less than 5 minutes. 
    - This is because WEP used a very small (24-bit) initialization vector (IV) that could be captured in the datastream, and this IV could then be used to discover the password using statistical techniques.

### WPA (Wi-Fi Protected Access) 

- It's often referred to as WPA1 to distinguish it from WPA2.
- WPA used Temporal Key Integrity Protocol (TKIP) to improve the security of WEP without requiring new hardware. 
- It still uses WEP for encryption, but it makes the statistical attacks used to crack WEP much more difficult and time-consuming.

### WPA2-PSK

- WPA2-PSK is the implementation of WPA2 for the home or small business user. 
- As the name implies, it's the WPA2 implementation that uses a pre-shared key (PSK). 
- It's this security standard that is used by most households today, and although it's far more secure, it's still vulnerable to various attacks.
- A feature that was added in 2007 called Wi-Fi Protected Setup, or **WPS, allows us to bypass the security in WP2-PSK .**

### WPA2-AES

- WPA2-AES is the enterprise implementation of WPA2. 
- **It uses the Advanced Encryption Standard or AES to encrypt data and is the most secure.** 
- It's often coupled with a RADIUS server that is dedicated for authentication.
- Although cracking it is possible, it significantly more difficult.

## Channels

- Like radio, wireless has multiple channels - so various communication streams don't interfere with each other. 
- **The 802.11 standard allows for channels ranging from 1 thru 14.**
    - In US - use channels 1 thru 11. 
    - In Europe - uses channels 1 thru 13 
    - **In India - uses channels 1 thru 13**
    - Japan 1 thru 14.
- For the hacker, this can be useful information as a rogue AP using channel 12 thru 14 would be invisible to U.S.- made wireless devices and security professionals scanning for rogue access points.
- Each channel has a width of 22 Mhz around its central frequency. 
- To avoid interference, an AP can use any of these channels, but to avoid any overlap, channels 1, 6, and 11 are most often utilized in the U.S. 
- The other channels can be used, but because you need five channels between the working channels to not overlap signals, with three or more channels, **only 1, 6, and 11 will work.**

## Datagrams and Frames

## Signal Strength

- In USA - The FCC says that the access point's signal cannot exceed 27 dBm (500 milliwatts). Most access points have this limit built-in, but we can change and override this limitation, if the access point is capable of a stronger signal. 
- This may be useful for the hacker in setting up evil twins and rogue access points where strength of signal is critical, among other techniques.

## WiFi Adapters

- One of the crucial needs to becoming an effective Wi-Fi hacker is the Wi-Fi adapter. 
- Generally, the Wi-Fi adapter on your laptop or desktop is insufficient for our purposes. 
- The key capability we need is the ability to inject packets into the access point and most run-of-the-mill wireless adapters are incapable of packet injection.
- **Alfa AWUS036NH USB wireless adapter is highly recommended  (₹ 9,299.00 + ₹ 100.00 Shipping)**

## Attennas

- Antennas come in two basic types, omni-directional and directional. 
- Most APs and wireless adapters come with omni-directional antennas, meaning that they send and receive in all directions.

## References
- [Tutorials point - Wi-Fi](https://www.tutorialspoint.com/wi-fi/wifi_access_protocols.htm)    
- [Getting Started with Terms & Technologies ](https://null-byte.wonderhowto.com/how-to/hack-wi-fi-getting-started-with-terms-technologies-0147659/)    
- [Crack Wi-Fi Passwords—For Beginners!](https://null-byte.wonderhowto.com/how-to/crack-wi-fi-passwords-for-beginners-0139793/)    
- [WPA vs. WPA2](https://www.diffen.com/difference/WPA_vs_WPA2)
- [Hack WPA WiFi Passwords by Cracking the WPS PIN](https://null-byte.wonderhowto.com/how-to/hack-wpa-wifi-passwords-by-cracking-wps-pin-0132542/)
- [Crack Wi-Fi Passwords—For Beginners! ](https://null-byte.wonderhowto.com/how-to/crack-wi-fi-passwords-for-beginners-0139793/)