### Check available disks & partitions
```bash
sfdisk -l
# OR
# simpler overview of devices, partitions and UUID
lsblk -o NAME,UUID 
```
### Create new partition
```bash
fdisk /dev/sda # change sda to your device name

# press n to make a new partition
# choose p for a primary and e for extended partition, default is p
# choose a partition number, best to keep default
# choose FIRST and LAST sector (if not using default be sure to leave enough sectors for your needs)
# use W to save changes and quit
# use q to discard changes and quit
```
### Format partition
```bash
mkfs.ext4 /dev/sda1 # change sda1 to your partition name
```
### Temporary Mount partition
```bash
mkdir /mnt/data1 # or choose another location
mount /dev/sdb1 /mnt/data1 # mount the partition to this specific location
### this is NOT persistent after reboot ###
```
### PERISTENT mount using fstab
*`boot might fail if drives from fstab configuration are missing`*
```bash
cat /etc/mtab
# copy the line corresponding to your mounted partition
# example: /dev/sdb1 /mnt/data1 ext4 rw,relatime 0 0
blkid # this will show all partitions and their UUID's
# change /dev/sdb 1 with it's UUID
# result: UUID=122cd907-2051-454f-8b90-c32405ac529c /mnt/data1 ext4 rw,relatime 0 0
sudo nano /etc/fstab # add your resulting line to fstab
```
### Unmount partition
```bash
umount /dev/sdb1 /mnt/data1
```
### copy partition table to other drive
```bash
sfdisk -d /dev/sdb | sfdisk --force /dev/sdc
# this will create the same partitions on /dev/sdc as on /dev/sdb
```
### mdadm create RAID
*`to create ext4 partition follow formatting instructions using /dev/md0`*

*`follow mount instruction to mount this raid partition under your desired mountpoint. device name md0 might change after reboot if it is not in fstab`*
```bash
#change level for other raid types
mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sdb1 /dev/sdc1 
```
### check raid configurations
```bash
cat /proc/mdstat
# Personalities : [raid0] 
# md0 : active raid0 sdc1[1] sdb1[0]
#       41906176 blocks super 1.2 512k chunks
# unused devices: <none>

#after reboot:
# Personalities : [raid0] [linear] [multipath] [raid1] [raid6] [raid5] [raid4] [raid10] 
# md127 : active raid0 sdc1[1] sdb1[0]
#       41906176 blocks super 1.2 512k chunks 
# unused devices: <none>
```
### stop raid set and recreate using new drive
```bash
mdadm --stop /dev/md0
mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sdb1 /dev/sdd1
```
### mdadm extras
```bash
mdadm --detail /dev/md0 # details about drives and status
Mdadm /dev/md0 -f /dev/sdb # mark drive as faulty
mdadm /dev/md0 -r /dev/sdb # remove drive from raid array
Mdadm –manage /dev/md0 –add /dev/sdc # add drive to raid
```
