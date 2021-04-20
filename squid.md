# Configuração simples do squid
```
http_port 3128
visible_hostname [Nome Servidor]

acl todos src all
acl localhost src 127.0.0.1/32

##########Configuracao do Cache##########

cache_mem 128 MB
maximum_object_size_in_memory 64 KB
maximum_object_size 512 MB
minimum_object_size 0 KB
cache_swap_low 90
cache_swap_high 95
cache_dir ufs /var/spool/squid3 2048 16 256
cache_access_log /var/log/squid3/access.log
refresh_pattern ^ftp: 15 20% 2280
refresh_pattern ^gopher: 15 0% 2280
refresh_pattern . 15 20% 2280
##########Fim do Cache##########

acl SSL_ports port 443 563
acl Safe_ports port 80			#http
acl Safe_ports port 21			#ftp
acl Safe_ports port 443 563	#https, snews
acl Safe_ports port 70			#gopher 
acl Safe_ports port 210			#wais
acl Safe_ports port 280			#http-mgmt
acl Safe_ports port 488			#gss-http
acl Safe_ports port 591			#filemaker
acl Safe_ports port 777			#multiling http
acl Safe_ports port 901			#swat
acl Safe_ports port 1025-65535	#portas altas

##########Autenticacao##########

auth_param basic realm Servidor_Proxy (Digite Usuário e Senha )
auth_param basic program /usr/lib/squid3/basic_ncsa_auth /etc/squid3/htpasswd-users
acl autenticados proxy_auth REQUIRED

##########Bloqueio de Sites##########
acl listadebloqueio url_regex -i "/etc/squid3/listadebloqueio"
http_access deny listadebloqueio
##########Fim do Bloqueio##########

http_access allow autenticados


acl purge method PURGE
acl CONNECT method CONNECT

http_access allow manager localhost
http_access deny manager
http_access allow purge localhost
http_access deny purge
http_access deny !Safe_ports

acl redelocal src 192.168.1.0/24
http_access allow localhost
http_access allow redelocal

http_access deny todos
```