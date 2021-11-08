# Installation

## partition disks
```bash
fdisk -l

# create 3 partitions using fdisk /dev/device
boot partition - 1GB # IF using a eufi enabled bios create a partition of about 1Gb, format this partition using FAT32
main partition - leftover space
swap partition - a few gb up to the amount of ram you have (which would be overkill)

fdisk /dev/osdrivename

#partition a root partition and a swap partition
mkfs.ext4 /dev/rootpartition
mkswap /dev/swappartition

mount /dev/rootpartition /mnt
swapon /dev/swappartition

#eufi partition
pacman -S dosfstools
mkfs.msdos -F 32 /dev/bootpartition
```

## get a network connection
```bash
iwctl station wlan0 get-networks
iwctl station wlan0 connect 'ssid'
```

## install base & linux kernel and firware
```bash
pacstrap /mnt base linux linux-firmware
```

## generate fstab 
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

## root into new system
```bash
arch-chroot /mnt
```

## change root Password
```bash
passwd
```

## install needed stuff
```bash
pacman -S dhcpcd iwd git grub
```

## install grub for NON-EUFI !!!
```bash
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
```

## install grub EUFI
`not tested yet`
```bash
pacman -S grub efibootmgr
mkdir /boot/efi
mount /dev/bootpartition /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
```

## cpu Microcode updates
* ### amd
```bash
pacman -S amd-ucode
```
* ### intel
```bash
pacman -S intel-ucode
```

## network configuration 
```bash
echo 'hostname' >> /etc/hostname

echo '127.0.0.1 localhost' >> /etc/hosts
echo '::1 localhost' >> /etc/hosts

systemctl enable dhcpcd
```

