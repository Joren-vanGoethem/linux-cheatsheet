## required, but alternatives can also be used
```bash
pacman -S konsole git base-devel
```

## optional 
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