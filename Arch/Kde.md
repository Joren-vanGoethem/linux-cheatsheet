## install Xorg
```bash
pacman -S xorg-server xorg-init

Xorg :0 -configure

cp /root/xorg.conf.new /etc/X11/xorg.conf
```

## Alternatively install Wayland
```bash
pacman -S wayland
```

## install KDE Packages
```bash
pacman -S plasma-meta # or plasma-desktop for minimal setup
# for wayland users ALSO install:
pacman -S plasma-wayland-session # also add egl-wayland if you use nvidia
```

## kde configuration with X11
`~/.xinitrc`
```bash
export DESKTOP_SESSION=plasma
exec startplasma-x11
```

## kde configuration with wayland
```bash
sddm --example-config > /etc/sddm.conf
nano /etc/sddm.conf
# look for `Session=` and add plasma.desktop
# enabling auto login is also possible for a specific user
systemctl start sddm
```

## autostart before login
**there has to be a non-root user enabled, make sure to give this user sudo permissions**
```bash
systemctl enable sddm.service
```

## autostart after login
`~/.profile`
```bash
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec systemctl start sddm.service
fi
```