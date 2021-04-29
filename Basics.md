### Change Hostname
```bash
hostname <newname>
# also change /etc/hostname and /etc/hosts to keep this hostname after reboot
```

### enable root ssh
```bash
nano /etc/ssh/sshd_config
# uncomment PermitRootLogin and change Prohibit-Password to yes
```

### add user to sudo
```bash
usermod -aG sudo <username>
```

### view running processes
```bash
ps aux
```

### view ALL files with size, permissions etc.
```bash
ls -la
# -l shows permissions etc.
# -a shows hidden files
```

### view all processes listening on TCP op UDP ports
```bash
netstat -tulpn
```

### Info about system
```bash
cd /proc
# all files in this directory contain info about hardware, kernel, processes
```