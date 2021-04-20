# Configuração do bind9

Exemplo de configuração de serviços no bind

```
 srvce.prot.owner-name  ttl  class   rr  pri  weight port target
_http._tcp.example.com.       IN    SRV  0    5      80   www.example.com.
```

service = http (80), https (443), pop (110), smtp (25), imap (445), ldap (389), ftp (21), ssh (22), telnet (23), rpc (135) and others

protocolName = tcp or udp

priority = digit, lowers get first priority

weight = digit, higher get used often

portNO = the digit relevant to the service name listed above


Exemplo de configuração de zona direta

```
$TTL    604800
@       IN      SOA     debian.labredes.linux. root.labredes.linux. (
                              2         ; Serial
                         604800         ; Refresh
                          86400         ; Retry
                        2419200         ; Expire
                         604800 )       ; Negative Cache TTL
;
labredes.linux.                 IN      NS      debian.labredes.linux.
labredes.linux.                 IN      A       10.5.5.1
debian                          IN      A       10.5.5.1
_ldap._tcp.labredes.linux.              SRV 0 0 389 debian.labredes.linux.
_kerberos._udp.labredes.linux.          SRV 0 0 88 debian.labredes.linux.
_ldap._tcp.dc._msdcs.labredes.linux.    SRV 0 0 389 debian.labredes.linux.
_kerberos._udp.dc._msdcs.labredes.linux. SRV 0 0 88 debian.labredes.linux.
_kpasswd._udp.labredes.linux.           SRV 0 0 464 debian.labredes.linux.
```

Exemplo de configuração da zona reversa

```
$ORIGIN 1.0.10.in-addr.arpa.
$TTL 86400
@     IN     SOA    dns1.example.com.     hostmaster.example.com. (
                    2001062501 ; serial
                    21600      ; refresh after 6 hours
                    3600       ; retry after 1 hour
                    604800     ; expire after 1 week
                    86400 )    ; minimum TTL of 1 day

      IN     NS     dns1.example.com.
      IN     NS     dns2.example.com.

20    IN     PTR    alice.example.com.
21    IN     PTR    betty.example.com.
22    IN     PTR    charlie.example.com.
23    IN     PTR    doug.example.com.
24    IN     PTR    ernest.example.com.
25    IN     PTR    fanny.example.com.
```

Exemplo de configuração da zona direta

```
$ORIGIN example.com.
$TTL 86400
@     IN     SOA    dns1.example.com.     hostmaster.example.com. (
                    2001062501 ; serial
                    21600      ; refresh after 6 hours
                    3600       ; retry after 1 hour
                    604800     ; expire after 1 week
                    86400 )    ; minimum TTL of 1 day

      IN     NS     dns1.example.com.
      IN     NS     dns2.example.com.

      IN     MX     10     mail.example.com.
      IN     MX     20     mail2.example.com.

             IN     A       10.0.1.5

server1      IN     A       10.0.1.5
server2      IN     A       10.0.1.7
dns1         IN     A       10.0.1.2
dns2         IN     A       10.0.1.3

ftp          IN     CNAME   server1
mail         IN     CNAME   server1
mail2        IN     CNAME   server2
www          IN     CNAME   server2
```