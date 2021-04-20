# Configuração do DHCP

```
#
# Sample configuration file for ISC dhcpd for Debian
#

ddns-update-style none;
#default-lease-time 600;
#max-lease-time 7200;
authoritative;

log-facility local7;

subnet 10.5.5.0 netmask 255.255.255.0 {
  range 10.5.5.10 10.5.5.50;
  option domain-name "labredes.linux";
  option domain-name-servers 10.5.5.1;
  option netbios-name-servers 192.168.1.100;
  option routers 10.5.5.1;
  option broadcast-address 10.5.5.255;
  option ntp-servers 10.5.5.1;
  default-lease-time 600;
  max-lease-time 7200;
  interface eth1;
}
```

