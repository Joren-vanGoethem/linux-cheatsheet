### check network connectivity
```bash
ip a
# if you have an ip address try 
ping <default gateway> 
ping 8.8.8.8
```
### DNS server
```bash
cat /etc/resolv.conf
```
### Default Gateway
```bash
ip r
```
### (de-)activation of NIC
```bash
ifup <NIC>
ifdown <NIC>
```
### configure network adapter
```bash
nano /etc/network/interfaces
# and configure as following
iface ensXX inet static
    address 192.168.0.100       # IP address
    netmask 255.255.255.0       # network mask
    network 192.168.0.0         # network IP
    broadcast 192.168.0.255     # broadcast address
# OR
iface ensXX inet static
    address 192.168.0.100/24    # IP address
    gateway 192.168.0.254       # Defualt Gateway
```

### restart networking service after changes
```bash
systemctl restart networking
```
