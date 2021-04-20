Provisionamento do samba4

samba-tool domain provision --option="interfaces=lo eth1" --option="bind interfaces only=yes" --use-rfc2307 --use-ntvfs --function-level=2008_R2 --interactive

Provisionamento adicional do samba4 no dominio

samba-tool domain join <DOMINIO> DC -U Administrator --realm=<REINO> --dns-backend=<TIPO-DNS> --use-ntvs --workgroup=<GRUPO>

Exemplo de Configuração:
samba-tool domain provision --use-rfc2307 \
--dns-backend=BIND9_DLZ \
--workgroup=ADS \
--function-level=2008_R2 \
--site=master \
--domain=ADS \
--sid=S-1-5-21-974500379-1975925619-3590964749 \
--host-name=ad1 \
--host-ip=192.168.0.20 \
--realm=SAMPLE.DOM\
--adminpass=<pwd> \
--ldapadminpass=<pwd> \
--krbtgtpass=<pwd>

then Join second new freshly setup ad2 with 
samba-tool domain join SAMPLE.DOMDC -Uadministrator \
 --realm=SAMPLE.DOM\
 --dns-backend=BIND9_DLZ \
 --workgroup=ADS \
 --site=master \
 --server=ad1.SAMPLE.DOM\
 --password=<pwd>

Teste de conectividade com o servidor Samba
smbclient -L localhost -U%
smbclient //localhost/netlogon -UAdministrator -c 'ls'

Teste de DNS

host -t SRV _ldap._tcp.samdom.example.com.

host -t SRV _kerberos._udp.samdom.example.com.

host -t A dc1.samdom.example.com.

Mudando o level domain:

samba-tool domain level raise --domain-level 2008_R2 --forest-level 2008_R2 

confirm doman level:
samba-tool domain level show 

Criação de nova senha do Administrador:
samba-tool user setpassword administrator

Criando usuários:
samba-tool user add [usuario]

Deletando usuários:
samba-tool user delete [usuario]

Habilitar usuários:
samba-tool user enable [usuario]

Desabilitar usuários:
samba-tool user disable [usuario]

Tempo de expiração da senha:
samba-tool setexpiry [usuario] --days=10
samba-tool setexpiry [usuario] --noexpiry

Criando grupos:
samba-tool group add [grupo]

Deletando grupos:
samba-tool group delete [group]

Adicionando usuários a um grupo
samba-tool group addmembers [grupo] [usuario,usuario]

Removendo usuários de um grupo
samba-tool group removemembers [grupo] [usuario,usuario]

Listar grupos:
samba-tool group list

Listar usuários
samba-tool user list

Listar usuários de um grupo
samba-tool group listmembers [grupo]

Listar GPO
samba-tool gpo listall


Instalação dos Pacotes do Kerberos
krb5-admin-server krb5-config krb5-kdc krb5-user

Criando um realm
krb5_newrealm

Pacotes necessários quando não se compila o samba4
libnss-winbind ldb-tools

Remover uma entrada no DNS:
samba-tool dns delete <server> <zone> <name> <A|AAAA|PTR|CNAME|NS|MX|SRV|TXT> <data>

Criando uma zone reversa no DNS:
samba-tool dns zonecreate <server> <reverse-network-ip-part>.in-addr.arpa -U Administrator

Adicionando um registro no DNS reverso:
samba-tool dns add <server> <zone> <host-part> PTR <domain-name>

Listando os membros de um grupo:
samba-tool group listmembers <groupname> [options]

Adicionando um usuário a um grupo:
samba-tool group addmembers <groupname> <user1,user2>