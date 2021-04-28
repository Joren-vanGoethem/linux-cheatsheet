# IP Tables

## Allow Forwarding on firewall machine

```bash
nano /etc/sysctl.conf

# search for ip_forward and uncomment this
# net.ipv4.ip_forward=1

sudo sysctl -p

# verify if this is set to 1
cat /proc/sys/net/ipv4/ip_forward
```

### Remove All Rules

```bash
sudo iptables -F

# to remove a specific rule
sudo iptables -L --line-numbers
sudo iptables -D INPUT <line_number>
```

### Dropping all packets

*`Note: any open connections to your VM will be dropped and network connection will be unusable.`*
```bash
sudo iptables -A INPUT -j DROP
sudo iptables -A OUTPUT -j DROP
sudo iptables -A FORWARD -j DROP
```

### Allow Connections to localhost

```bash
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
```

### Manage your firewall from a remote machine from a LAN address

SSH Access
```bash
sudo iptables -A INPUT -p tcp -s 172.16.134.0/24 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
```

### Restore Connection from your firewall to internet

```bash
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
```

#### Allow ping packets

```bash
sudo iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
sudo iptables -A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT
```

#### Move drop rules to bottom

Idealy create a bash script and execute this after modifying the rules.
```bash
sudo iptables -D INPUT -j DROP
sudo iptables -D OUTPUT -j DROP
sudo iptables -D FORWARD -j DROP
sudo iptables -A INPUT -j DROP
sudo iptables -A OUTPUT -j DROP
sudo iptables -A FORWARD -j DROP
```

#### Saving Rules to disk

```bash
sudo iptables-save > /etc/iptables/rules.v4
```