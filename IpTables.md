# IP Tables

## Allow Forwarding on firewall machine

```bash
nano /etc/sysctl.conf

# search for ip_forward and uncomment this
# net.ipv4.ip_forward=1

sysctl -p

# verify if this is set to 1
cat /proc/sys/net/ipv4/ip_forward
```

### Remove All Rules

```bash
iptables -F
iptables -t nat -F

# to remove a specific rule
iptables -L --line-numbers
iptables -D INPUT <line_number>
```

### Dropping all packets

*`Note: any open connections to your VM will be dropped and network connection will be unusable.`*
```bash
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
iptables -A FORWARD -j DROP
```

### Allow Connections to localhost

```bash
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
```

### Manage your firewall from a remote machine from a LAN address

SSH Access
```bash
# allow lan connected machine to ssh into firewall
iptables -A INPUT -p tcp -s 172.16.134.0/24 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT 
# allow outward communication when incoming state is established (NEW only on input)
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT 
```

### Bridging WAN and LAN interfaces

`ens33`: our WAN
`ens37`: our LAN

```bash
iptables -A FORWARD -i ens37 -o ens33 -j ACCEPT
iptables -A FORWARD -i ens33 -o ens37 -m state --state ESTABLISHED, RELATED -j ACCEPT
iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE
```

### Restore Connection from your firewall to internet

```bash
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
```

#### Allow ping packets

```bash
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
```

#### Move drop rules to bottom

Idealy create a bash script and execute this after modifying the rules.
```bash
iptables -D INPUT -j DROP
iptables -D OUTPUT -j DROP
iptables -D FORWARD -j DROP
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
iptables -A FORWARD -j DROP
```

#### Saving Rules to disk

```bash
iptables-save > /etc/iptables/rules.v4
```

### ctstate types
* **NEW** -- meaning that the packet has started a new connection, or otherwise associated with a connection which has not seen packets in both directions.

* **ESTABLISHED** -- meaning that the packet is associated with a connection which has seen packets in both directions.

* **RELATED** -- meaning that the packet is starting a new connection, but is associated with an existing connection, such as an FTP data transfer, or an ICMP error.



