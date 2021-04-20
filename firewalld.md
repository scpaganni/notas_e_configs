Obtém o status de firewalld:

`# firewall-cmd --state`

Recarrega o firewall sem perder informações de estado:

`# firewall-cmd --reload`

Obtém uma lista de todas as zonas suportadas:

`# firewall-cmd --get-zones`

Obtém uma lista de todos os serviços suportados:

`# firewall-cmd --get-services`

Obtém uma lista de todos os icmptypes suportados:

`# firewall-cmd --get-icmptypes`

Lista todas as zonas com seus recursos habilitados:

`# firewall-cmd --list-all-zones`

Lista uma zona com seus recursos habilitados. Se a zona for omitida, a zona padrão será usada:

`# firewall-cmd [--zone=<zone>] --list-all`

Obtém a zona padrão definida para conexões de rede:

`# firewall-cmd --get-default-zone`

Defini a zona padrão:

`# firewall-cmd --set-default-zone=<zone>`

Obtém as zonas ativas:

`#  firewall-cmd --get-active-zones`

Obtém uma zona relacionada à interface:

`# firewall-cmd --get-zone-of-interface=<interface>`

Adicionar uma interface a uma zona:

`# firewall-cmd [--zone=<zone>] --add-interface=<interface>`

Mudar a zona a que pertence uma interface:

`# firewall-cmd [--zone=<zone>] --change-interface=<interface>`

Remover uma interface de uma zona:

`# firewall-cmd [--zone=<zone>] --remove-interface=<interface>`

Consulta se uma interface está em uma zona:

`# firewall-cmd [--zone=<zone>] --query-interface=<interface>`

Lista os serviços habilitados em uma zona:

`# firewall-cmd [--zone=<zone>] --list-services`

Ativar um serviço em um zona por um período de tempo:

`# firewall-cmd [--zone=<zone>] --add-service=<service> [--timeout=<seconds>]`

Remover um serviço de uma zona:

`# firewall-cmd [--zone=<zone>] --remove-service=<service>`

Consulta se um serviço está habilitado em uma zona:

`# firewall-cmd [--zone=<zone>] --query-service=<service>`

Habilita uma combinação de porta ou range de portas e protocolo em uma zona:

`# firewall-cmd [--zone=<zone>] --add-port=<port>[-<port>]/<protocol> [--timeout=<seconds>]`

Remove uma conexão de porta e protocolo de uma zona:

`# firewall-cmd [--zone=<zone>] --remove-port=<port>[-<port>]/<protocol>`

Ativa tipos de mensagem ICMP em uma zona:

`# firewall-cmd [--zone=<zone>] --add-icmp-block=<icmptype>`

Remove tipos de mensagem ICMP em uma zona:

`# firewall-cmd [--zone=<zone>] --remove-icmp-block=<icmptype>`

Consulta tipos de mensagem ICMP em uma zona:

`# firewall-cmd [--zone=<zone>] --query-icmp-block=<icmptype>`

Ativa o reencaminhamento de porta ou mapeamento de portas em uma zona:

`# firewall-cmd [--zone=<zone>] --add-forward-port=port=<port>[-<port>]:proto=<protocol> { :toport=<port>[-<port>] | :toaddr=<address> | :toport=<port>[-<port>]:toaddr=<address> }`

Desativa o reencaminhamento de porta ou mapeamento de portas em uma zona:

`# firewall-cmd [--zone=<zone>] --remove-forward-port=port=<port>[-<port>]:proto=<protocol> { :toport=<port>[-<port>] | :toaddr=<address> | :toport=<port>[-<port>]:toaddr=<address> }`
