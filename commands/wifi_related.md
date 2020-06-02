# Network Commands - Wifi Related

## check for wifi and network details

```shell
       ## wireless interfaces, master command 
        $ iwconfig
         
       ## determine the name of Wifi interface
        $ nmcli d
       
       ## Make sure WIfi Radio is on
        $ nmcli r wifi on 
       
       ## show all network devices
        $ nmcli device show
       
       ## show all the wifi router list
        $ nmcli d wifi list
       
       ## connect using wifi interface 
        $ nmcli d connect <WifiInterface>
       
       ## connect using Saved Wifi Conn 
        $ nmcli c up <SavedWifiConn>
       
       ## disconnect using wifi interface 
        $ nmcli d connect <WifiInterface> 
       
       ## disconnect using wifi interface 
        $ nmcli c down <SavedWifiConn>
```

