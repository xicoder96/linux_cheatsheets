# PERFORMANCE MONITORING AND STATISTICS

```bash
    ## Display and manage the top processes
    top

    ## Interactive process viewer (top alternative)
    htop

    ## Display processor related statistics (package:sysstat)
    mpstat 1

    ## Display virtual memory statistics (package:sysstat)
    vmstat 1

    ## Display I/O statistics (package:sysstat)
    iostat 1

    ## Display the last 100 syslog messages  (Use /var/log/syslog for Debian based systems else use /var/log/messages.)
    tail /var/log/syslog

    ## Capture and display all packets on interface eth0
    sudo tcpdump -i eth0

    ## Monitor all traffic on port 80 ( HTTP )
    sudo tcpdump -i eth0 'port 80'

    ## List all open files on the system
    lsof

    ## List files opened by user
    lsof -u user

    ## Display free and used memory ( -h for human readable, -m for MB, -g for GB.)
    free -h

    ## Execute "df -h", showing periodic updates
    watch df -h

```