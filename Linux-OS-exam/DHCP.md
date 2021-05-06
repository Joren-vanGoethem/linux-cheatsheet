# DHCP

Package required `isc-dhcp-server`

## Network Interface

`/etc/network/interfaces`
```conf
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug ens33
iface ens33 inet static
        address 192.168.20.30/24
        gateway 192.168.20.254
```

## DHCP Config

`/etc/dhcp/dhcpd.conf`
```conf
subnet 192.168.20.0 netmask 255.255.255.0 {
        range 192.168.20.100 192.168.20.200; # IPv4 lease range 100 - 200
        option routers 192.168.20.254; # gateway
        option domain-name "mctinternal.be";
        option domain-name-servers 192.168.20.30; # DNS server
}
```
