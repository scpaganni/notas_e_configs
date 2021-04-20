# Instalacação OpenVPN

Criação das chaves pré-compartilhadas:
```
openvpn --genkey --secret <nome_da_chave.key>
```

A chave deve ser compartilhada entre os servidores

Configurações no VPN01:

```
dev tun0
remote 203.0.113.2
ifconfig 10.0.0.1 10.0.0.2
secret static.key
script-security 3
up route.sh
keep alive 10 120
comp-lzo
persist­-key
persist­-tun
verb 3
```

Configurações no VPN02:
```
dev tun0
remote 192.0.2.2
ifconfig 10.0.0.2 10.0.0.1
secret static.key
script-security 3
up route.sh
keepalive 10 120
comp-lzo
persist-­key
persist­-tun
verb 3
```

Para criar uma VPN simples, no cliente execute o seguinte comando:

```
openvpn --remote 192.168.1.1 --dev tun0 --ifconfig 10.0.0.1 10.0.0.2
```

no servidor:

```
openvpn --remote 192.168.1.202 --dev tun0 --ifconfig 10.0.0.2 10.0.0.1
```

Ativar a VPN manualmente para debug:

```
openvpn --config /etc/openvpn/<arquivo>.conf
```

# Configuração utilizando PKI:

No servidor:

```
port 1194
proto udp
dev tun0
server 10.0.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "route 172.16.10.0 255.255.255.0"
keepalive 20 120
tls-server
tls-auth keys/static.key
dh keys/dh2048.pem
ca keys/ca.crt
cert keys/vpn01.crt
key keys/vpn01.key
comp-lzo
persist-key
persist-tun
float
verb 3
log openvpn.log
status status.log
```

No cliente:
```
dev tun0
proto udp
port 1194
client
remote 192.0.2.2
pull
keepalive 20 120
tls-client
tls-auth keys/static.key
dh keys/dh2048.pem
ca keys/ca.crt
cert keys/vpn02.crt
key keys/vpn02.key
comp-lzo
persist-key
persist-tun
float
verb 3
log openvpn.log
status status.log
```