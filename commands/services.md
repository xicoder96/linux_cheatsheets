# SERVICES & SYSTEMD COMMANDS

```bash
    ## List out all the service
    sudo service --status-all 

    ## check status of the service
    sudo service apache2 status

    ## Basic Log viewing (-x --catalog Add message explanations where available, -e  Immediately jump to the end in the pager)
    journalctl -xe | less

    ## Displaying Logs from the Current Boot
    journalctl -b 


```