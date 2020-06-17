# TOR - Bcoz Privacy matters

> **NEVER USE TOR AND ANY BROWSERS WITH ROOT PRIVILEGE** 

- Tor is a software that enables you to hide your identity on the internet.
- It is an open network that helps defend against traffic analysis and grants you a high level of privacy.

> Tor protects you by bouncing your communications around a distributed network of relays (known as onion routing) run by volunteers all around the world: it prevents somebody watching your Internet connection from learning what sites you visit, and it prevents the sites you visit from learning your physical location.

## What is Onion Routing ?

- In onion routing, the data to be sent is encapsulated in layers of encryption, just like the layers of an onion. 
- The resulting encrypted data is then transmitted through a series of network nodes called onion routers, each of which “peels” away (or decrypts) a single layer of the encryption, uncovering the data’s next destination.
- Upon decrypting the final layer, the data arrives at its destination. The sender remains anonymous because each intermediary knows only the location of the immediately preceding and following nodes.

## How to Install Tor on Ubuntu ?

1. Adding Source Entries

```bash    
    sudo cat >> /etc/apt/sources.list
```    

```conf
    deb http://deb.torproject.org/torproject.org trusty main
    deb-src http://deb.torproject.org/torproject.org trusty main
```

2. Adding gpg key

```bash
    sudo gpg — keyserver keys.gnupg.net — recv 886DDD89
    sudo gpg — export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -
```
3. Installing Tor

```bash
    sudo apt-get update
    sudo apt-get install tor deb.torproject.org-keyring 
```

## Configuring Tor

- Tor comes with a control port, which can be used to control it. 
- It is highly recommended that in order to control Tor using the control port, you set up an authentication method to prevent anyone else from accessing it. The recommended way is to use a password. 

```bash
    $ tor --hash-password "passwordhere"
    16:AC5FB526B90B4ED06027C6C4343EF87075B63B9A25822EE198622EE4D6
```
- Open the torrc file (if you followed the above installation steps, then your torrc file path should be /etc/tor/torrc) and uncomment these lines:
1. ControlPort
2. CookieAuthentication OR HashedControlPassword (if you choose to uncomment HashedControlPassword, copy the hashed password you got in the previous step and paste it next to HashedControlPassword in the torrc file)

- These lines are shown below:
```bash
    # This provides a port for our script to talk with. If you set this then be
    # sure to also set either CookieAuthentication *or* HashedControlPassword!
    #
    # You could also use ControlSocket instead of ControlPort, which provides a
    # file based socket. You don't need to have authentication if you use
    # ControlSocket. For this example however we'll use a port.

    ControlPort 9051 # <--- uncomment this ControlPort line

    # Setting this will make Tor write an authentication cookie. Anything with
    # permission to read this file can connect to Tor. If you're going to run
    # your script with the same user or permission group as Tor then this is the
    # easiest method of authentication to use.

    CookieAuthentication 1 #either uncomment this or below HashedControlPassword line

    # Alternatively we can authenticate with a password. To set a password first
    # get its hash...
    #
    # % tor --hash-password "my_password"
    # 16:E600ADC1B52C80BB6022A0E999A7734571A451EB6AE50FED489B72E3DF
    #
    # ... and use that for the HashedControlPassword in your torrc.

    HashedControlPassword 16:E600ADC1B52C80BB6022A0E999A7734571A451EB6AE50FED489B72E3DF #if you choose to uncomment this line, paste your hashed password here
```
- **Cookie authentication simply means that your credential is the content of a file in Tor’s DataDirectory.**

- Restart tor service.
```bash
    $ sudo service tor restart
```

## Torsocks

```bash
    $ sudo apt-get install torsocks
    # Now let’s use torsocks! First, get your public ip address.
    $ curl 'https://api.ipify.org'
    75.119.16.140
    # So, it says 75.119.16.140 is my public ip, now use torsocks before the curl command:
    $ torsocks curl 'https://api.ipify.org'
    31.45.26.14
```

## Signalling Tor Control to create a new circuit (or path)
- You can tell Tor control to initiate a new Tor circuit. 
- **An important thing to note here is that a new circuit does not necessarily mean a new IP address.** 
- To do this, we use a command already introduced above:
```bash
    $ telnet localhost 9051
    Trying 127.0.0.1...
    Connected to localhost.
    Escape character is '^]'.
    AUTHENTICATE "my_password"
    250 OK
    SIGNAL NEWNYM
    250 OK
    QUIT
    250 closing connection
    Connection closed by foreign host.
```
