# X11
## install Xorg
```bash
pacman -S xorg-server xorg-init

Xorg :0 -configure

cp /root/xorg.conf.new /etc/X11/xorg.conf
```

## install KDE Packages
```bash
pacman -S plasma-desktop # or plasma-meta for minimal setup
```

## kde configuration
`~/.xinitrc`
```bash
export DESKTOP_SESSION=plasma
exec startplasma-x11
```

## autostart after login
`~/.profile`
```bash
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
```

# WAYLAND
## install Wayland
```bash
pacman -S wayland
```

## install KDE Packages
```bash
pacman -S plasma-desktop plasma-wayland-session # also add egl-wayland if you use nvidia
```

## kde configuration with wayland
```bash
sddm --example-config > /etc/sddm.conf
nano /etc/sddm.conf
# look for `Session=` and add plasma.desktop
# enablehighDPI scaling? to be tested
# enabling auto login is also possible for a specific user
systemctl start sddm
```

## autostart before login
**there has to be a non-root user enabled, make sure to give this user sudo permissions**
**there is no standard console/terminal, install konsole**
```bash
systemctl enable sddm.service
```

## disable wallet
```bash
[Wallet]
Enabled=false
```
