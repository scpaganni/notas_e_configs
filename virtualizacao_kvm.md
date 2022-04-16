# [ EM CONSTRUÇÃO ]
#### Recursos usados para virtualização no Linux

- **kvm**: o KVM consiste de um módulo de kernel carregável, `kvm.ko`, e requer uma CPU com extensões de virtualização, encontradas na maioria das CPUs. Essas extensões são chamadas de Intel VT ou AMD-V. 

- **qemu**:

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

#### Leituras

https://www.redhat.com/pt-br/topics/virtualization/what-is-KVM#o-que-%C3%A9-kvm

https://wiki.debian.org/KVM
