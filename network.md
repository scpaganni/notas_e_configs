# Configurações de Rede

O serviço de rede padrão, a partir do Fedora 22, é o **NetworkManager**. Para instalar e habilitar caso não esteja disponível no sistema:

```
# dnf install NetworkManager
# systemctl status NetworkManager
# systemctl start NetworkManager
# systemctl enable NetworkManager
```
Os usuários não interagem diretamente com o serviço do sistema **NetworkManager**. Para isso pode-se usar:
- *nmcli*: ferramenta de linha de comando
- *control-center*: ferramenta gráfica
- *nm-connection-editor*: ferramenta gráfica disponível para certas tarefas especializadas não tratadas pelo *control-center*.

O diretório */etc/sysconfig* é um local para arquivos de configuração e scripts. A maioria das configurações de rede são armazenadas nele, com exceção de VPN, banda larga móvel e conexões PPPoE que são armazenadas em subdiretórios do */etc/NetworkManager/*.
O arquivo */etc/sysconfig/network* é para configurações globais. Informações para VPNs, banda larga móvel e conexões PPPoE são armazenadas em */etc/NetworkManager/system-connections/*.
Após editar um arquivo de configuração em */etc/sysconfig/network-scripts/* é preciso informar ao **NetworkManager** para ler os arquivos de configuração:

`# nmcli connection reload`

ou

`# nmcli con load /etc/sysconfig/network-scripts/ifcfg-ifname`

Para colocar em down uma interface de rede:

`# nmcli dev disconnect interface-name`

Para colocar em up:

`# nmcli con up interface-name`

Exemplo de configuração para uma interface de rede:

```conf
#IP Estático

HWADDR=08:00:27:29:72:8C	                   # MAC Address.			
TYPE=Ethernet
BOOTPROTO=none                               # Nenhum protocolo de inicialização deve ser usado.
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
NAME=enp0s8
DEVICE=enp0s8                                # Nome do dispositivo físico.
UUID=44d41e88-b0c0-4326-91ce-b0d7d59cadd2
ONBOOT=yes
PEERDNS="no"	                               # Impede que o serviço de rede atualize o /etc/resolv.conf.
DNS1=ip_address	                             # Configura a interface para usar este endereço como DNS.
DNS2=ip_address	                             # Configura a interface para usar este endereço como DNS.
IPADDR=172.16.0.1
PREFIX=16
GATEWAY=172.16.0.1
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes
IPV6_PRIVACY=no
ZONE=""                                      # Defini a zona a qual a interface será associada.
```

```conf
# IP Dinâmico

HWADDR="08:00:27:CB:99:55"                   # MAC Address.
TYPE="Ethernet"
BOOTPROTO="dhcp"                             # O protocolo DHCP deve ser usado na inicialização.
DEFROUTE="yes"                               # Defini que o GATEWAY deve ser especificado via DHCP.
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
NAME="enp0s3"
DEVICE="enp0s3"                               # Nome do dispositivo físico.
UUID="0256e8be-baa3-4c50-b941-d3c41242f6ce"
ONBOOT="yes"
PEERDNS="yes"	                                # Aceita que o serviço de rede atualize o /etc/resolv.conf.
PEERROUTES="yes"
IPV6_PEERDNS="yes"
IPV6_PEERROUTES="yes"
ZONE=""                                       # Defini a zona a qual a interface será associada.
```

Pode-se, também usar o comando *ip* para configurar uma interface. O comando tem o seguinte formato:

```
# ip addr [ add | del ] address dev ifname
# ip address add 192.168.2.223/24 dev eth1
# ip address add 192.168.4.223/24 dev eth1
```

Para configurar uma rota usando o comando *ip*:

```
# ip route [ add | del | change | append | replace ] destination-address
# ip route add 192.0.2.1 via 10.0.0.1 [dev ifname]
# ip route add 192.0.2.0/24 via 10.0.0.1 [dev ifname]
```
Para configurar rotas estáticas que sejam persistentes após um reinício do sistema, elas devem ser colocadas em arquivos de configuração por interface no diretório */etc/sysconfig/network-scripts/*. O nome do arquivo deve ser no formato **route-ifname**. Pode-se configurar o arquivo com dois tipos de comando:

- usando o formato do comando *ip* com seus argumentos;
- usando o formato *Network/Netmask* com suas diretivas.

```
default via 192.168.0.1 dev eth0
10.10.10.0/24 via 192.168.0.10 dev eth0
172.16.1.10/32 via 192.168.0.10 dev eth0
```

```conf
ADDRESS0=10.10.10.0
NETMASK0=255.255.255.0
GATEWAY0=192.168.0.10
ADDRESS1=172.16.1.10
NETMASK1=255.255.255.0
GATEWAY1=192.168.0.10
```

## Nmcli

A ferramenta de linha de comando *nmcli* pode ser usada por usuários e scripts para controlar o **NetworkManager**. O formato básico de um comando é o seguinte:

`nmcli OPTIONS OBJECT { COMMAND | help }`

Para mostrar o status geral do **NetworkManager**:

`nmcli general status`

Para controlar o log do **NetworkManager**:

`nmcli general logging`

Para mostrar todas as conexões:

`nmcli connection show`

Para mostrar apenas as conexões ativas:

`nmcli connection show --active`

Para mostrar dispositivos reconhecidos pelo **NetworkManager** e seu estado:

`nmcli device status`

O *nmcli* pode ser usado para iniciar e/ou parar qualquer interface:

```
nmcli con up id bond0
nmcli con up id port0
nmcli dev disconnect bond0
nmcli dev disconnect eth0
```

É possível usar o modo interativo do *nmcli* para configurar uma conexão da seguinte forma:

```
nmcli connection edit
Tipos de conexões válidos: generic, 802-3-ethernet (ethernet), pppoe, 802-11-wireless (wifi), wimax, gsm, cdma, infiniband, adsl, bluetooth, vpn, 802-11-olpc-mesh (olpc-mesh), vlan, bond, team, bridge, bond-slave, team-slave, bridge-slave, no-slave, tun, ip-tunnel, macvlan, vxlan
Digite o tipo de conexão:
```

Se já souber qual tipo de conexão deseja editar é possível passá-la diretamente no comando e ir direto ao prompt *nmcli*:

`nmcli con edit [id | uuid | path] ID`

Veja: `man 1 nmcli`

Para listar as conexões de rede atualmente disponíveis, emita um comando da seguinte maneira:

`nmcli con show`

Visualizar os dispositivos disponíveis:
`nmcli device status`

Para adicionar um perfil do tipo ethernet com endereçamento dinâmico via DHCP use o seguinte comando:

`nmcli connection add type ethernet con-name connection-name ifname interface-name`

Exemplo:

`nmcli con add type ethernet con-name my-office ifname eth0`
