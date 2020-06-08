# Other Important commands and details

```bash
    ## Disable Root Account in Linux 
    sudo vi /etc/passwd
        root:x:0:0:root:/root:/bin/bash
            to
        root:x:0:0:root:/root:/sbin/nologin

    ## Use Proxychains and tor
    sudo service tor stop    
    sudo service tor start
    proxychain firefox www.duckduckgo.com    

```