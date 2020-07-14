# *Automating Wi-Fi Hacking with Besside-ng - Bruteforce

> **Warning: Besside-Ng Is Very Loud & Leaves a Ton of Evidence**

```bash
# Identify Attack Antenna & Let It Rip
iwconfig
```

- Besside-ng is dead simple. 
- With the attack antenna known as `wlan1`, simply type the following to initiate a wide-area attack against all detected APs. 
- While it helps to put an adapter in monitor mode, Besside-ng will take care of that.
```bash
besside-ng -vv wlan1
```
- Clarify Operation During Attack Runs - As it attack runs - it will prioritize WEP networks as they can be completely compromised from within the script - As such, Besside-ng may focus too heavily on WEP and slow down the attack. 