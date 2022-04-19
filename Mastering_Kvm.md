# Tipos de virtualização

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

#### Requisitos de hardware para virtualização

#### Requisitos de software para virtualização

## Redes Libvirt

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
