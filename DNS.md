# DNS

Packages required `bind9 bind9utils bind9-doc`

## Bind9 Config

`/etc/default/bind9`
```conf
# run resolvconf?
RESOLVCONF=no

# startup options for the server
OPTIONS="-4 -u bind" # listen on IPv4 only
```

## Forwarders

`/etc/bind/named.conf.options`
```conf
# uncomment or adjust the config file accordingly

# goodclients can be any name
acl goodclients {
    192.168.20.0/24;
    localhost;
    localnets;
};

options {
    directory "/var/cache/bind";

    recursion yes;
    # goodclients referenced
    allow-query { goodclients; };

    forwarders {
        1.1.1.1;
        8.8.8.8;
        8.8.4.4;
    };
    forward only;

    # ...
};
```
Do not forget `;`

## Local DNS

`/etc/bind/named.conf.local`
```conf
zone "mctinternal.be" {
    type master;
    file "/etc/bind/zones/mctinternal.be";
};

zone "20.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/reverse/rev.20.168.192";
};
```

`/etc/bind/zones/mctinternal.be`
```
;
; BIND data for mctinternal.be
;
$TTL 3h
@       IN      SOA     ns1.mctinternal.be. admin.mctinternal.be. (
        1
        3h
        1h
        1w
        1h
    )
;
@       IN      NS      ns1.mctinternal.be.
@       IN      NS      ns2.mctinternal.be.

mctinternal.be. IN      A       192.168.20.20
ns1     IN      A       192.168.20.30
ns2     IN      A       192.168.20.31
www     IN CNAME        mctinternal.be.
```

`/etc/bind/zones/reverse/rev.20.`
```
;
; BIND reverse file for 20.168.192.in-addr.arp
;
$TTL 604800
@       IN      SOA     ns.mctinternal.be. admin.mctinternal.be. (
        1
        3h
        1h
        1w
        1h
    ) 
;
@       IN      NS      ns1.mctinternal.be.
@       IN      NS      ns2.mctinternal.be.

10      IN      PTR     database.mctinternal.be.
20      IN      PTR     webserver.mctinternal.be.
30      IN      PTR     dhcpdns.mctinternal.be.
254     IN      PTR     firewall.mctinternal.be.
```
