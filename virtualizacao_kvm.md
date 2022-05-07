# [ EM CONSTRUÇÃO ]
#### Recursos usados para virtualização no Linux

- **kvm**: o KVM consiste de um módulo de kernel carregável, `kvm.ko`, e requer uma CPU com extensões de virtualização, encontradas na maioria das CPUs. Essas extensões são chamadas de Intel VT ou AMD-V. Ele é uma acelerador ou ativador dessas extensões de virtualização fornecidas pelo processador para que sejam fortemente acopladas à arquitetura da CPU.

- **qemu**: Para emulações de E/S, o KVM usa um software de usuário, QEMU; este é um programa userland que faz emulação de hardware. O QEMU emula o processador e uma longa lista de dispositivos periféricos, 
como disco, rede, VGA, PCI, USB, portas seriais/paralelas e assim por diante para construir uma peça completa de hardware virtual no qual o sistema operacional convidado pode ser 
instalado. Esta emulação é alimentada por KVM.

- **libvirt**: é uma API de código aberto que fornece um kit de ferramentas para gerenciar plataformas de virtualização: KVM, Xen, LXC, VMWare ESX, Virtuozzo, etc.

- **virt-manager**: o `virt-manager` é uma interface gráfica para gerenciar máquinas virtuais por meio da `libvirt`.

- **virsh**: interface de linha de comando para a `libvirt`.

Para verificar se você tem suporte à CPU, execute o seguinte comando:

`$ egrep '^flags.*(vmx|svm)' /proc/cpuinfo`

Para instalar os pacotes do grupo de virtualização execute o seguinte comando:

`# sudo dnf install @virtualization`

Depois da instalação dos pacotes, é necessário habilitar no boot e startar o serviço `libvirtd`

`# systemctl enable libvirtd`

`# systemctl start libvirtd`

Para gerenciar máquinas virtuais como usuário comum esse usuário precisa ser adicionado ao grupo `libvirt`:

`# usermod -aG libvirt usuario`

#### Suporte de rede

Por padrão, libvirt criará uma rede privada para seus convidados na máquina host. Essa rede privada usará uma sub-rede 192.168.xx e não poderá ser acessada diretamente da rede em que a máquina host está. No entanto, os convidados virtuais podem usar a máquina host como um gateway e podem se conectar por meio dela. Se você precisar fornecer serviços em seus convidados que podem ser acessados por outras máquinas em sua rede host, você pode usar as regras de DNAT do iptables para encaminhar em portas específicas ou pode configurar um ambiente em ponte.

Consulte a página de configuração de rede libvirt para obter mais informações sobre como configurar uma rede bridge.

O pool de armazenamento padrão do `libvirt` está localizado em `/var/lib/libvirt/images`

#### Instalando uma máquina virtual no KVM

Neste exemplo temos uma iso do AlmaLinux em `/var/lib/libvirt/images/AlmaLinux-8.5-x86_64-minimal.iso`. Precisamos usar o seguinte comando para criar a máquina virtual e começar a instalação.

`# virt-install --virt-type=kvm --name=AlmaLinux --vcpus=1 --memory=2048 --os-variant=rhel8.5 --cdrom=/var/lib/libvirt/images/AlmaLinux-8.5-x86_64-minimal.iso --network=default --disk size=20 --graphics=vnc`

Podemos também fazer uma instalação utilizando um arquivo `kickstart`. No exemplo abaixo pegamos o arquivo `kickstart` gerado na instalação anterior, colocamos o arquivo num servidor web e fizemos algumas alterações para automatizar o processo.


```conf
# Arquivo kickstart usado para instalação
#version=RHEL8
# Use graphical install
graphical

repo --name="Minimal" --baseurl=file:///run/install/sources/mount-0000-cdrom/Minimal

%packages
@^minimal-environment
kexec-tools

%end

# Keyboard layouts
keyboard --xlayouts='br'
# System language
lang pt_BR.UTF-8

# Network information
network  --bootproto=dhcp --device=enp1s0 --ipv6=auto --activate
network  --hostname=localhost.localdomain

# Use CDROM installation media
cdrom

# Run the Setup Agent on first boot
firstboot --enable

ignoredisk --only-use=vda
autopart
# Partition clearing information
clearpart --none --initlabel

# System timezone
timezone America/Porto_Velho --isUtc --nontp

# Root password
rootpw --iscrypted $6$v.fEkPrLYWWmOR98$dmArACi65Uilk02./1b/R2502k4Hd34Y.QIb24aie27ySNn.dqtb5wQEAS7x9eNW1yCMnFrShhufDux.Fv0ph.

%addon com_redhat_kdump --enable --reserve-mb='auto'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end
```

`# virt-install --virt-type=kvm --name=AlmaLinuxSrv --vcpus=1 --memory=2048 --os-variant=rhel8.5 --location=/var/lib/libvirt/images/AlmaLinux-8.5-x86_64-minimal.iso --network=default --disk size=20 --graphics=vnc -x "ks=http://192.168.122.226/anaconda-ks.cfg"`

Para obter uma lista dos sistemas operacionais convidados compatíveis, execute o seguinte comando:

`# osinfo-query os`

Para exportar a configuração de rede padrão do kvm para um arquivo xml:

`virsh net-dumpxml default > labredes.xml`

```
<network>
  <name>default</name>
  <uuid>01e3bc5d-7634-4692-8e46-a621a6aed8d5</uuid>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:8b:59:b4'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
```

Podemos também criar uma nova rede editando esse arquivo: basta renomear a rede, gerar um novo uuid e mac:

```
<network>
  <name>labredes</name> 
  <uuid>6b82f1b8-9b01-46c4-9695-1c0205d960dc</uuid>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='virbr1' stp='on' delay='0'/>
  <mac address='00:E0:4C:0B:94:77'/>
  <ip address='192.168.2.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.2.2' end='192.168.2.254'/>
    </dhcp>
  </ip>
</network>
```

Importando o novo arquivo:

`# virsh net-define labredes.xml`

Startar a nova rede:

`# virsh net-start labredes`

Para disponibilizar permanentemente:

`# virsh net-autostart labredes`

Verificar se as redes estão carregadas:

`# virsh net-list`

É possível também criar uma rede isolada, exemplo:

```
<network>
  <name>scpaganni</name>
  <uuid>3b5df993-e2d8-415f-8af7-680af5c108ef</uuid>
  <bridge name='virbr2' stp='on' delay='0'/>
  <mac address='00:16:3e:0b:5d:85'/>
  <domain name='scpaganni'/>
  <ip address='192.168.3.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.3.2' end='192.168.3.254'/>
    </dhcp>
  </ip>
</network>
```

Importando o novo arquivo:

`# virsh net-define scpaganni.xml`

Startar a nova rede:

`# virsh net-start scpaganni`

Para disponibilizar permanentemente:

`# virsh net-autostart scpaganni`

Verificar se as redes estão carregadas:

`# virsh net-list`

Ao abir o virt manager, temos todas as redes listadas que criamos

![Imgur](https://i.imgur.com/ALzs8jI.png)

Com a máquina virtual ligada podemos anexar uma interface de rede a ela, informando qual rede será usada:

`# virsh attach-interface --domain AlmaLinux --source scpaganni --type network --model virtio --config --live`

#### Leituras


https://www.redhat.com/pt-br/topics/virtualization/what-is-KVM#o-que-%C3%A9-kvm

https://wiki.debian.org/KVM

https://docsdoraproject.org/en-US/quick-docs/getting-started-with-virtualization/
