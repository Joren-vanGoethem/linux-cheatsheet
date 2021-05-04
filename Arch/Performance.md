## EXT4 tuning
`/etc/fstab`
```bash
# noatime prevents the filesystem to record information about the last time a file was accessed which reduces writes of this info
/dev/sda1    /    ext4    defaults,noatime    0    1

# increasing commit interval can be dangerous because this means that the system only syncs all data/journal to physical storage every X seconds, 
# default is 5 which means if power is lost you only lose the last 5 seconds of work
/dev/sda1    /    ext4    defaults,commit=60    0    1
```