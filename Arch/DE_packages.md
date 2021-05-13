## required
```bash
pacman -S konsole git base-devel
```

## "optional"
```bash
pacman -S dolphin
```

## install yay
```bash
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R Username:Username ./yay
cd yay
makepkg -si
```

## packages using yay

[visual-studio-code-bin](https://aur.archlinux.org/packages/visual-studio-code-bin/?O=10&PP=10)
[google-chrome](https://aur.archlinux.org/packages/google-chrome/)
[curl](https://aur.archlinux.org/packages/curl-git/)
[dhcpcd-ui](https://aur.archlinux.org/packages/dhcpcd-ui/)
[wpa_supplicant_gui](https://aur.archlinux.org/packages/wpa_supplicant_gui/)