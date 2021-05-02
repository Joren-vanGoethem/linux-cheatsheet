# Installation

## FOLLOW official arch install first although this contains some issues, read thoroughly

### most of the next steps can be done during installation, networking is recommended to do during installation

## network configuration
*not complete*
```bash
nano /etc/systemd/network/ens33.network
# add this to the file
# [Match]
# name=ens33
# [Network]
# DHCP=yes

systemctl enable systemd-networkd
systemctl enable systemd-resolved
systemctl start systemd-networkd
systemctl start systemd-resolved
```


## install Xorg
```bash
pacman -S xorg-server xorg-init

Xorg :0 -configure

cp /root/xorg.conf.new /etc/X11/xorg.conf
```

## kde configuration
```bash
nano ~/.xinitrc
#add 'export DESKTOP_SESSION=plasma' and 'exec startplasma-x11'
```