# Comandos aleatórios
Descobrir ip público pelo terminal:

`# curl ifconfig.me`

Compartilhando um diretório rapidamente via web:

```
python -m http.server
python -m SimpleHTTPServer
```

Criar arquivo de atualizações usando **tar** para restaurar depois:

`# tar -cf backups.tar /var/cache/apt/archives`

Para restaurar:

`# tar -xf backups.tar --directory /`

O comando `tar` apenas empacota arquivos, não os comprime: Para comprimir podemos usar o parâmetro `-z` (comprimi com gzip); ou `-j` (comprimi com bzip2).

Baixar vídeo em formato ogg usando o youtube-dl:

`alias ogg='youtube-dl --extract-audio --audio-format vorbis'`

Baixar playlist completa:

`youtube-dl -t https://www.youtube.com/playlist?list=`

Verificar o fingerprint da chave ssh do servidor:

`# ssh-keygen -E md5 -lf /path/to/ssh/key`

Este alias permite entrar no diretório e listar o conteúdo automaticamente:

```
alias lcd=changeDirectory
  function changeDirectory {
    cd $1 ; ls -la
  }
```

Data de instalação do sistema:

`# ls -lct /etc | tail -1 | awk '{print $7, $6, $8}'`

Limpar os comentário do squid.conf:

`# cat squid.conf.old | grep -v -E '^#' | uniq > squid.conf`

Descobrir o UUID de uma partição e escrever no /etc/fstab:

`# tune2fs -l /dev/sdxx | grep -i uuid | tee -a /etc/fstab`

Montar compartilhamento samba remotamente via linha de comando:

`# mount -t cifs //ip_do_servidor/diretorio /diretorio_de_montagem -o username=usuario`

Montar compartilhamento nfs remotamente via linha de comando:

`# mount -t nfs ip_do_servidor:/diretorio /diretorio_de_montagem`

Gerar um UUID para interface de rede:

`# uuidgen <DEVICE>`

Atualizando o grub:

`# grub2-mkconfig -o /boot/grub2/grub.cfg`

# Comandos para fazer NAT em roteadores Cisco

Para fazer o NAT em Roteadores Cisco:

Definir as zonas inside e outside

```
ESW1(config)#interface serial 1/1
ESW1(config-if)#ip nat inside
ESW1(config)#interface fastEthernet 0/0
ESW1(config-if)#ip nat outside
```

Criar uma ACL:
`ESW1(config)#access-list 1 permit any`

Habilitar o NAT propriamente dito:

`ESW1(config)#ip nat inside source list 1 interface fastEthernet 0/0 overload`

# Selinux

`# getsebool -a`

`# system_u:object_r:usr_t:s0`

Mudando o contexto do diretório /usr/share/phplapadmin/htdocs

`# semanage fcontext -a -t httpd_sys_content_t "/usr/share/phpldapadmin/htdocs(/.*)?"`

Permitir a conexão do httpd com ldap de forma permanente:

`# setsebool -P httpd_can_connect_ldap 1`

Restaurar o contexto de um arquivo

`# restorecon -vvFR /nome_do_arquivo`

# Packt Tracer

Para Instalar em sistemas x86 Debian based:

```
sudo dpkg –add-architecture i386
sudo apt-get install libnss3-1d:i386 libqt4-qt3support:i386 libssl1.0.0:i386 libqtwebkit4:i386 libqt4-scripttools:i386
```

1.  wget http://www.labcisco.com.br/app/Cisco-PT-711-x64.tar
2. tar -xvzf Cisco-PT-620.tar.gz
3. cd PacketTracer71Student
4. ./install


* Na tela seguinte aparecerá o acordo de licença do software. Pressione ENTER até a porcentagem chegar a 100%. (com cuidado)
* Digite Y para aceitar os termos.
* O instalador solicitará a local onde o Packet Tracer deverá ser instalado. Pressione ENTER para manter o default (/opt/pt). (preferencialmente)
* Os arquivos serão copiados. Caso haja algum pacote/aplicativo do Gnu Linux que necessite ser atualizado, não se preocupe, o instalador fará isso automaticamente.
* Na sequência o sistema informará que será necessário criar um link simbólico chamado “packettracer” para que o Packet Tracer possa ser iniciado facilmente. Pressione Y.
* Por fim, aparecerá uma mensagem informando que o Packet Tracer 7.1 foi instalado com sucesso.


# Habilitar interface bridge no boxes (Fedora 35)

Para obter a interface de rede `virbr0` é necessário a instalação do pacote `libvirt-daemon-config-network`

`sudo dnf install libvirt-daemon-config-network`

e habilitar o socket de rede

`sudo systemctl enable --now virtnetworkd-ro.socket`

# Comandos para localização de arquivos

`locate` `which` `whereis` `find`

* O comando `whereis` encontra apenas arquivos executáveis, arquivos de documentação e código fonte

# Comandos para manipulção de textos

`grep``tee` `sed` `awk`

# Testar o arquivo de configuração com netplan
A partir do Ubuntu 20.04 alterar a configuração de rede envolve editar a configuração YAML do arquivo localizado em `/etc/netplan`. Como boa prática, devemos sempre fazer um backup do arquivo de configuração atual
antes de fazer alterações.

`sudo netplan try`

Para aplicar as configurações é preciso executar

`sudo netplan apply`

Após criar um template de máquina virtual com `# virt-sysprep -d [dominio] as chaves em `/etc/ssh` são excluídas. Para recriar as chaves é só fazer o seguinte comando:

`# ssh-keygen -A -N`

# Apgar tabela de particionamento de um hd

`# wipefs /dev/sdx`
