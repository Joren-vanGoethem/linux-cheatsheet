# Installation

## partition disks
```bash
fdisk -l
#partition a root partition and a swap partition
# IF using a eufi enabled bios create an extra partition of about 1Gb, format this partition using FAT32
mkfs.ext4 /dev/rootpartition
mkswap /dev/swappartition

mount /dev/rootpartition /mnt
swapon /dev/swappartition

#eufi partition
pacman -S dosfstools
mkfs.msdos -F 32 /dev/bootpartition
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

## install grub NON-EUFI
```bash
pacman -S grub 
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
pacman -S dhcpcd

echo 'hostname' >> /etc/hostname

echo '127.0.0.1 localhost' >> /etc/hosts
echo '::1 localhost' >> /etc/hosts

nano /etc/systemd/network/ens33.network
# add this to the file
# [Match]
# name=ens33
# [Network]
# DHCP=yes

systemctl enable dhcpcd
systemctl disable systemd-networkd
systemctl disable systemd-resolved
```

