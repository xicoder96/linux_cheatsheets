# PROCESS MANAGEMENT

```bash
    ## Display your currently running processes
    ps

    ## Display all the currently running processes on the system.
    ps -ef

    ## Display process information for processname
    ps -ef | grep processname

    ## Display and manage the top processes
    top

    ## Interactive process viewer (top alternative)
    htop

    ## A snapshot of the current processes.(pid process id, ppid parent processid,uname username,stat current state,vsz addressspace based on active apps,rsz phy mem allocated,class scheduling policy,ni nice values for non realtime precoess,rtprio realtime prio,command)
    ps -eH -o pid,ppid,uname,stat,vsz,rsz,class,ni,rtprio,command | less

    ## Kill process with process ID of pid
    kill <pid>

    ## Kill all processes named processname
    killall <processname>

    ## Start program in the background
    program &

    ## Display stopped or background jobs
    bg

    ## Brings the most recent background job to foreground
    fg

    ## Brings job n to the foreground
    fg n
```