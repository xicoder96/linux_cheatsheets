# Harware Information

```bash
    
    ## Display messages in kernel ring buffer
    dmesg

    ## Display CPU information
    cat /proc/cpuinfo

    ## Display memory info
    cat /proc/meminfo

    ## Display free and used memory ( -h for human readable, -m for MB, -g for GB.)
    free -h

    ## Display PCI devices ( -t for tree view, -v for verbose)
    lspci -tv

    ## Display USB devices
    lsusb -tv

    ## Display DMI/SMBIOS (hardware info) from the BIOS
    sudo dmidecode

    ## Show info about disk sda
    sudo hdparm -i /dev/sda

    ## Perform a read speed test on disk sda
    sudo hdparm -tT /dev/sda

    ## Test for unreadable blocks on disk sda
    sudo badblocks -s /dev/sda

    ## Display info about all hardware        
    sudo hwinfo --short  

```