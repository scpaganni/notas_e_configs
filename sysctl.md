# Hardening no Kernel Linux

As seguintes modificacoes devem ser feita no arquivo: **/etc/sysctl.conf**

Proteção contra ataques ICMP
```
net.ipv4.icmp_echo_ignore_broadcasts = 1
```

Proteção contra mensagens de erro de ICMP.<br>
As vezes roteadores enviam respostas invalidas de broadcast ICMP. Esse comando evita fazer log de mensagens de warning desnecessarias do kernel.
```
net.ipv4.icmp_ignore_bogus_error_responses = 1
```

Habilitar syncookies para protecao de ataques SYN Flood:
```
net.ipv4.tcp_syncookies = 1
```

Manter log de pacotes suspeitos como spoofed, source-routed, e redirect:
```
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.log_martians = 1
```

Dropar pacotes com opcoes de Strict Source Route (SSR) ou Loose Source Routing (LSR):
```
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0
```

Habilitar verificação de origem de pacotes por ‘reversed path. Opção recomendada por RFC1812:
```
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
```

Garantir que ninguem consegue alterar as tabelas de rotas. Proteção contra spoof de rede.
```
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
```

Modo "host only". Desabilita redirecionamento de pacotes. <br>
**ATENCAO**: Nao habilitar essa opção se o seu Servidor funciona como router.
```
net.ipv4.ip_forward = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
```

Habilitar proteçao execshild contra worms, ataques automatizados e outros:
```
kernel.exec-shield = 1
kernel.randomize_va_space = 1
```

Melhoria para IPv6:
```
net.ipv6.conf.default.router_solicitations = 0
net.ipv6.conf.default.accept_ra_rtr_pref = 0
net.ipv6.conf.default.accept_ra_pinfo = 0
net.ipv6.conf.default.accept_ra_defrtr = 0
net.ipv6.conf.default.autoconf = 0
net.ipv6.conf.default.dad_transmits = 0
net.ipv6.conf.default.max_addresses = 1
```

Aumentar o limite de arquivos abertos:
```
fs.file-max = 65535
```

Aumentar o numero de PIDs
```
kernel.pid_max = 65536
```

Aumentar o numero máximo de portas para conexões IP para TCP e UDP. <br>
Opção importante para quem tem um servidor para banco de dados Oracle
```
net.ipv4.ip_local_port_range = 2000 65000
```

Aumentar o buffer maximo TCP
```
net.ipv4.tcp_rmem = 4096 87380 8388608
net.ipv4.tcp_wmem = 4096 87380 8388608
```

Aumentar o auto tuning de buffer TCP - min, default, e max em bytes.<br>
Definir maximo para pelo menos 4MB.<br>
Opção essencial se voce tiver conexao de alta velocidade.<br>
```
net.core.rmem_max = 8388608
net.core.wmem_max = 8388608
net.core.netdev_max_backlog = 5000
net.ipv4.tcp_window_scaling = 1
```