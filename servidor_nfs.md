# Configuração do Servidor NFS

Um servidor NFS mantém uma tabela de sistemas de arquivos físicos locais que são acessíveis aos clientes NFS. Cada sistema de arquivos nesta tabela é referido como um sistema de arquivos exportado , ou `export` , para abreviar

Há duas maneiras de configurar um servidor NFS

* Editando manualmente o arquivo de configuração nfs `/etc/exports`
* pela linha de comando usando `exportfs`

O arquivo `/etc/exports`controla quais pastas serão exportadas para clientes remotos e especifica as opções. Uma entrada padrão tem a seguinte estrutura:

`export host(opções)`

ou quando houver vários hosts:

`export host1(options1) host2(options2) host3(options3)`

As opções podem ser:

`sync/async`: envia informações de forma síncrona ou assíncrona;
`atime/noatime - diratime/nodiratime -relatime/norelatime`: ativa/desativa atualizações para tempo de acesso de inode;
`dev/nodev`: permite ou bloqueia dispositivos especiais no sistema de arquivos;
`exec/noexec`: permite ou bloqueia arquivos executáveis;
`suid/nosuid`: permite ou bloqueia o uso do stick bit de usuário;
`ro/rw`: apenas leitura ou leitura e gravação;
`root_squash/no_root_squash`: Isso evita ou permite que usuários root conectados remotamente tenham privilégios de root local; 
`all_squash/no_all_squash`: Mapeia todos os uids e gids para o usuário anônimo. Útil para diretórios FTP públicos exportados por NFS, diretórios de spool de notícias, etc. A opção oposta é no_all_squash , que é a configuração padrão.
`anonuid/anongid`: Essas opções definem explicitamente o uid e o gid da conta anônima. Essa opção é útil onde você pode desejar que todas as solicitações pareçam ser de um único usuário.

# Instalação NFS Server no CentOS

`dnf install nfs-utils`

Habilitar o serviço na inicialização

`systemctl enable nfs-server`

Startar o serviço e verificar o status

`systemctl start nfs-server`

`systemctl status nfs-server`

Montamos, para início automático, no `/etc/fstab` um segundo disco como storage em `/srv/nfs`:

```
#
# /etc/fstab
# Created by anaconda on Sat Mar 26 13:14:02 2022
#
# Accessible filesystems, by reference, are maintained under '/dev/disk/'.
# See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info.
#
# After editing this file, run 'systemctl daemon-reload' to update systemd
# units generated from this file.
#
UUID=1e0ceb29-8731-4bea-af1b-15a79e234898 /                       btrfs   subvol=root,compress=zstd:1 0 0
UUID=c10d864d-62f4-4c86-a118-5e7ca3ddcaed /boot                   ext4    defaults        1 2
UUID=93D9-2FC1          /boot/efi               vfat    umask=0077,shortname=winnt 0 2
UUID=1e0ceb29-8731-4bea-af1b-15a79e234898 /home                   btrfs   subvol=home,compress=zstd:1 0 0

# Montagem do Storage
UUID=2EF35D8E759997B6   /srv/nfs    ext4    defaults 0 0
```
Vamos dar permissão total para a pasta `/srv/nfs`, caso contrário não conseguiremos gravar informações dentro da pasta e também alteraremos o usuário e grupo dono da pasta:

`# chmod -R 777 /srv/nfs`

`# chown -R nobody:nobody /srv/nfs`

O arquivo `/etc/exports` no nosso servidor tem a seguinte configuração:

```
# NFSv4 Pseudo Filesystem
/srv/nfs 192.168.1.0/24(fsid=0,rw,root_squash,no_subtree_check,crossmnt)

# Pastas Exportadas
/srv/nfs/backups 192.168.1.0/24(rw,root_squash)

```

Para exportar o sistema de arquivos basta rodar o comando:

`# exports -a`

Para visualizar:

`# exportfs -v`

Para verificar no host client se temos as pastas exportadas basta rodar o comando:

`# showmount -e ip_do_servidor`

Por último devemos liberar as regras no firewall. Para o NFSv4 é preciso apenas rodar o seguinte comando:

`# firewall-cmd --add-service=nfs --permanent`
`# firewall-cmd --reload`

Se houver hosts clientes com o NFSv3 é preciso liberar outros serviços também

`# firewall-cmd --add-service={nfs3,mountd,rpc-bind} --permanent`
`# firewall-cmd --reload`


### Leituras adicionais:

https://help.ubuntu.com/community/SettingUpNFSHowTo

https://www.unixmen.com/setting-nfs-server-client-centos-7/

https://linuxize.com/post/how-to-install-and-configure-an-nfs-server-on-centos-8/

https://man7.org/linux/man-pages/man5/nfsmount.conf.5.html

https://debian-handbook.info/browse/pt-BR/stable/sect.nfs-file-server.html

https://docs.fedoraproject.org/en-US/Fedora/14/html/Storage_Administration_Guide/ch-nfs.html