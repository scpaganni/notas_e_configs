### Tipos de virtualização

- Virtualização de desktops 
- Virtualização de servidor
- Virtualização de aplicativos
- Virtualização de rede
- Virtualização de armazenamento

Ferramentas para gerenciar virtualização em grande escala:

- OpenStack
- OpenShift
- Ansible
- Elasticsearch
- Logstash
- Kibana

Tipos de virtualização levando em conta o objeto da virtualização:

- Virtualização completa: Software e Hardware
- Paravirtualização: 
- Vitualização Híbrida
- Virtualização baseada em contêiner

O `hypervisor/vmm` é um software responsável por monitorar e controlar máquinas virtuais. é responsável por garantir diferentes tarefas de gerenciamento de virtualização, como fornecimento de hardware virtual, gerenciamento do ciclo de vida de máquinas virtuais, migração de máquinas virtuais, alocação de recursos em tempo real, definição de políticas para gerenciamento de máquinas virtuais e assim por diante. O VMM/hipervisor também é responsável por controlar com eficiência os recursos da plataforma física, como tradução de memória emapeamento de E/S. Uma das principais vantagens do software de virtualização é sua capacidade de executar vários convidados operando no mesmo sistema físico ou hardware.

Os hypervisors podem ser de dois tipos:

- bare-metal: instalado diretamente no hardware
- hosted: dependem do SO subjacente para suas operações 

Atualmente existem três projetos de núvem de código aberto que usam a virtualização do Linux para construir soluções de IaaS (Infraestrutura como Serviço)

- OpenStack
- CloudStack
- Eucalyptus

### Requisitos de hardware para virtualização

### Requisitos de software para virtualização

### Redes Libvirt

O Linux tem muitos tipos diferentes de interfaces de rede, alguns dos quais são o seguinte:

- bridge: interface de camada 2 para rede
- bond: combina interfaces físicas de rede em uma interface lógica
- team: nova implementação da bond, porém não cria uma inteface lógica
- macvlan: cria vários endereços MAC em uma interface físca (cria subinterfaces) na camada 2
- ipvlan: ao contrário do macvlan, o ipvlan usa o mesmo endereço mac e multiplexa na camada 3
- macvtap/iptvtap: Drivers mais recentes que devem simplificar a rede virtual combinando TUN, TAP e bridge como um único módulo
- vxlan: 
- veth, ipoib, gretap, gre, geneve, ipip, sit, ip6tnl e outros

Temos também três modos básicos de rede libvirt:

- nat: esse é o default, nossa máquina está atrás de um switch virtual numa rede totalmente isolada
- roteada: significa que a máquina virtual está diretamente ligada a rede física por meio de um switch virtual
- isolado: a máquina virtual está ligada a um switch virtual porém não há tráfego de rede para fora, as máquinas não se comunicam nem com o host nem com a internet

### Usando Redes TUN/TAP

Para uma virtualização eficiente alguns arquivos devem existir no host físico:

- /dev/kvm: os drivers kvm criam uma dispositivo de caractere `/dev/kvm` no host para facilitar o acesso direto ao hardware para as máquinas virtuais
- /dev/vhost-net: server como interface para configurar a instância do vhost-net. Não ter este dispositivo reduz o desempenho da máquina virtual
- /dev/net/tun: usado para criar o dispositivo TUN/TAP para facilitar a conectividade de rede para uma máquina virtual.

O que acontece quando precisamos que nossa comunicação ocorra no espaçao do usuário?

É aqui que entram os dispositivos TUN/TAP, fornecendo fluxo de pacotes para
programas de espaço do usuário.
O TUN emula um dispositivo L3 criando um túnel de comunicação, algo como um túnel ponto aponto. Ele é ativado quando o driver tuntap é configurado no modo tun.
Ao ativá-lo, quaisquer dados recebidos de um descritor (o aplicativo que o configurou) serão dados na forma de pacotes IP regulares (como o caso mais usado). Além disso, quando você enviadados, eles são gravados no dispositivo TUN como pacotes IP normais.
Esse tipo de interface às vezes é usado em testes, desenvolvimento e depuração para fins de simulação.
A interface TAP basicamente emula um dispositivo Ethernet L2. Ele é ativado quando o drivertuntap é configurado no modo de toque. Ao ativá-lo, diferentemente do que acontece com a interface TUN (Camada 3), você obtém pacotes Ethernet brutos de Camada 2, incluindo ARP/ Pacotes RARP e tudo mais. Basicamente, estamos falando de uma conexão Ethernet de Camada 2 'virtualizada.

Esses conceitos são importantes porque usando esses tipos de configurações podemos criar conexões do host para uma máquina virtual sem criar um switch libvirt. Vamos ver como ocorre no backend essa configuração.

No Fedora o comando `brctl` está no pacote `bridge-utils`

Verificando se o módulo bridge está funcionando:

`# lsmod | grep bridge`

Criar uma interface bridge com o nome *teste*

`# brctl addbr teste`

Verificar se a bridge foi criada:

`# brctl show`

Verificar se o módulo TUN/TAP foi carregado no kernel:

`# lsmod | grep tun`

Criar um dispositivo tap chamado *vm-vnic*:

`# ip tuntap add dev vm-vnic mode tap`

Adicionar a interface *vm-vnic* ao dispositivo *teste*

`# brctl addif teste vm-vnic`

`# brctl show`

Para remover *vm-vnic* de *teste*

`# brctl delif teste vm-vnic`

Excluir a interface tap

`# ip tuntap del dev vm-vnic mode tap`

Remover a bridge *teste*:

`# brctl delbr teste`

Essas são as mesmas etapas que o libvirt executou no back-end ao habilitar ou desabilitar a rede para uma máquina virtual.

### Macvtap

Este módulo funciona como uma combinação dos módulos tap e macvlan. Já explicamos o que o módulo tap faz. O módulo macvlan nos permite criar redes virtuais que são fixadas em uma interfacede rede física (geralmente, chamamos essa interface de interface ou dispositivo inferior). A combinação de tap e macvlan nos permite escolher entre quatro modos diferentes de operação, chamados Virtual Ethernet Port Aggregator (VEPA), bridge, private e passthru.

Para configuração de rede em grandes ambientes temos o open vswitch.

### Armazenamento libvirt

Temos três maneiras mais comuns de conseguir armazenamento:

- em nível de bloco: iscsi e fibre channel;
- em nível de compartilhamento: nfs;
- em nível de objeto: ceph, glusterfs

**Aprender sobre stratis**

[Stratis](https://stratis-storage.github.io/)

Para instalar o `stratis` no AlmaLinux

`# dnf install stratisd stratis-cli`

Habiliar na inicialização e startar o serviço

`# systemctl enable --now stratisd`

Vamos usar o seguinte cenário para fazer nossos testes

![Imgur](https://i.imgur.com/lruzTum.png)

Criar um pool de armazenamento com RAID10

`# mdadm --create /dev/md0 --verbose --level=10 --raid-devices=4 /dev/vdb /dev/vdc /dev/vdd /dev/vde`

```
# lsblk
NAME               MAJ:MIN RM  SIZE RO TYPE   MOUNTPOINT
sr0                 11:0    1 1024M  0 rom    
vda                252:0    0   20G  0 disk   
├─vda1             252:1    0    1G  0 part   /boot
└─vda2             252:2    0   19G  0 part   
  ├─almalinux-root 253:0    0   17G  0 lvm    /
  └─almalinux-swap 253:1    0    2G  0 lvm    [SWAP]
vdb                252:16   0    2G  0 disk   
└─md0                9:0    0    4G  0 raid10 
vdc                252:32   0    2G  0 disk   
└─md0                9:0    0    4G  0 raid10 
vdd                252:48   0    2G  0 disk   
└─md0                9:0    0    4G  0 raid10 
vde                252:64   0    2G  0 disk   
└─md0                9:0    0    4G  0 raid10 
vdf                252:80   0    2G  0 disk
```

`stratis pool create LabRaid /dev/md0`

`# stratis pool add-cache LabRaid /dev/vdf`

`stratis fs create LabRaid LabRaidXFS`

`mkdir /mnt/LabRaidXFS`

```
# stratis fs
Pool Name   Name         Used      Created             Device                            UUID                                
LabRaid     LabRaidXFS   546 MiB   Apr 22 2022 19:27   /dev/stratis/LabRaid/LabRaidXFS   d41cbb3b-471e-447e-b8ba-beda8421afd0
```

Montanto sistema de arquivos XFS para exportação NFS

`# mount /dev/stratis/LabRaid/LabRaidXFS /mnt/LabRaidXFS`

Vamos ver agora como usar um pool de armazenamento de uma perspectiva da libvirt

A libvirt gerencia seus próprios pools de armazenamento, suporta cargas de diferentes tipos de pool de armazenamento.
Por padrão a `libvirt` já possui um pool de armazenamento predefinido localizado em `/var/lib/libvirt/images`, nesse local ficam todos os dados das máquinas virtuais instaladas localmente

Vamos instalar nosso servidor NFS e exportar `/mnt/LabRaidXFS`

`# dnf install nfs-utils`

`# systemctl enable --now nfs-server`

```
# cat /etc/exports
/mnt/LabRaidXFS 192.168.122.0/24(rw,sync,root_squash)
```

`# exportfs -r`

Esse é o arquivo de configuração que foi feito quando montamos nosso pool via virt-manager

![](https://i.imgur.com/jmiedgi.png)

```
<pool type="netfs">
  <name>pool</name>
  <uuid>d3d2c59a-3f60-4b51-9dbc-5923ba79b6ce</uuid>
  <capacity unit="bytes">1098974756864</capacity>
  <allocation unit="bytes">7697858560</allocation>
  <available unit="bytes">1091276898304</available>
  <source>
    <host name="192.168.122.62"/>
    <dir path="/mnt/LabRaidXFS"/>
    <format type="auto"/>
  </source>
  <target>
    <path>/var/lib/libvirt/images/pool</path>
    <permissions>
      <mode>0755</mode>
      <owner>0</owner>
      <group>0</group>
      <label>system_u:object_r:nfs_t:s0</label>
    </permissions>
  </target>
</pool>
```

#### Armazenamento iSCSi e SAN

Usa a pilha tcp/ip
A eficiência é comprometida por dois motivos:

- O iSCSI encapsula comandos SCSI em pacotes IP regulares, o que significa segmentação e sobrecarga, pois os pacotes IP têm um cabeçalho bastante grande, o que significa menos eficiência.
- Pior ainda, é baseado em TCP, o que significa que há números de sequência e retransmissões, o que pode levar a enfileiramento e latência, e quanto maior o ambiente, mais você sente que esses efeitos afetam o desempenho de sua máquina virtual.

#### Terminologia

- iqn: nome exclusino do iniciador (cliente)
- fqdn: 
- lun: capacidade de armazenamento exportado. Por exemplo, podemos ter um dispositivo iSCSI com três luns diferentes - lun0 com 20GB, lun1 com 40GB e lun2 com 60GB. Todos eles hospedados no mesmo destino iSCSI do sistema de armazenamento. Podemos então configurar o destino iSCSI para aceitar um iqn para ver todos os luns, outro iqn para ver apenas o lun1 e outro iqn para ver apenas o lun2.

Existem três possibilidades para iSCSI no Linux em termos de qual back-end de armazenamento usar.Poderíamos usar um sistema de arquivos comum (como XFS), um dispositivo de bloco (um disco rígido) ou LVM.

### [FAZER LAB PAG 146 A 200]

### Gluster e Ceph como backend de armazenamento para KVM

- Gluster: Gluster é um sistema de arquivos distribuído que é frequentemente usado para cenários de alta disponibilidade. Suasprincipais vantagens em relação a outros sistemas de arquivos são o fato de que é escalável, pode usar replicação esnapshots, pode funcionar em qualquer servidor e pode ser usado como base para armazenamento compartilhado—porexemplo, via NFS e SMB. Ele foi desenvolvido por uma empresa chamada Gluster Inc., que foi adquirida pela RedHatem 2011. No entanto, ao contrário do Ceph, é um serviço de armazenamento de arquivos, enquanto o Ceph oferecearmazenamento baseado em blocos e objetos. Armazenamento baseado em objeto para dispositivos baseados embloco significa armazenamento binário direto, diretamente para um LUN. Não há sistemas de arquivos envolvidos, o queteoricamente significa menos sobrecarga, pois não há sistema de arquivos, tabelas de sistema de arquivos e outrasconstruções que possam retardar o processo de E/S.

## [FAZER LAB PAG 146 A 200]

- Ceph: 
O Ceph pode atuar como armazenamento baseado em arquivo, bloco e objeto. Mas, na maioria das vezes, geralmente ousamos como armazenamento baseado em bloco ou em objeto. Novamente, este é um software de código aberto projetadopara funcionar em qualquer servidor (ou máquina virtual). Em seu núcleo, o Ceph executa um algoritmo chamado ControlledReplication Under Scalable Hashing (CRUSH).

Em termos de arquitetura o Ceph possui três serviços principais:

- ceph-mon: usando para monitoramento de cluster, mapas crush e mapas do `object storage daemon`

- ceph-osd: trata do armazenamento, replicação e recuperação de dados reais. Requer pelo menos dois nós.

- ceph-mds: servidor de metadados, usado quando o ceph precisa de acesso ao sistema de arquivos.

[LABORATÓRIO PAG 156 A 162]

#### Protocolos de exibição gráfica da máquina virtual

- VNC
- SPICE
- noVNC
- RDP

Para fazer os gráficos funcionarem em máquinas virtuais, o QEMU precisa fornecer dois componentespara suas máquinas virtuais: um adaptador gráfico virtual e um método ou protocolo para acessar os gráficos a partirdo cliente. Vamos discutir esses dois conceitos, começando com um adaptador gráfico virtual. A versão mais recentedo QEMU possui oito tipos diferentes de adaptadores gráficos virtuais/emulados. Todos eles têm algumas semelhançase diferenças, que podem ser em termos de recursos e/ou resoluções suportadas ou outros detalhes mais técnicos.

- tcx
- cirrus
- std
- vmware
- qxl
- virtio
- cg3
- none

#### Protocolos de exibição mais comuns

- vnc
- spice
- novnc

#### Modificar imagens de disco da VM 
Modificar imagens da VM usando o pacote `libguestfs-tools`, no Fedora é apenas `libguestfs`. Esse pacote é um conjunto de utilitários para trabalhar com imagens de discos das VMs

Os principais comandos presentes nesse pacote incluem:
- guestfish
- virt-builder
- virt-builder-repository
- virt-copy-in
- virt-copy-out
- virt-customize
- virt-df
- virt-edit
- virt-filesystem
- virt-rescue
- virt-sparsify
- virt-sysprep
- virt-v2v
- virt-p2v

#### Tipos de clonagem

- clonagem completa
- clonagem linkada

#### Tipos de snaphots

- snapshots interno
- snapshots externo
