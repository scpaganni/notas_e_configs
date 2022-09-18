### Checklist para configuração de VPS Debian

- [ ] Atualizar sistema
- [ ] Trocar Timezone
- [ ] Trocar senha do root
- [ ] Criar usuário comum
- [ ] Alterar a porta padrão 22
- [ ] Desativar login do root
- [ ] Desativar senhas vazias
- [ ] Desativar encaminhamento do X11
- [ ] Ativar tempo de inativdade
- [ ] Ativar tentativas de acesso
- [ ] Instalar o pacote `unanttended-upgrades` para atualizações de segurança automáticas
- [ ] Instalação e configuração do fail2ban

Os arquivos de configuração do fail2ban são: `/etc/fail2ban/fail2ban.conf` e `/etc/fail2ban/jail.conf` 
É importante renomear os dois arquivos para que numa atualização do debian as configurações não sejam sobreescritas: `/etc/fail2ban/fail2ban.local` e `/etc/fail2ban/jail.local` 

- [ ] Configuração do firewall 
- Negar todo o tráfego de saída (outgoing)
- Negar todo o tráfedo de entrada (incoming)
- Abrir as portas necessárias

- [ ] Instalação e configuração do Apache
- O  arquivo de configuração de segurança do apache fica em `/etc/apache2/conf-available/security.conf`
- Outra configuração importante fica em `/etc/apache2/apache2.conf`

- [ ] Instalação do pacote `python3-certbot-apache` para geração de certificados autoassinados 
- [ ] Gerar os certificados com `certbot --apache`
- [ ] Gerar os certificados sem precisar de e-mail `certbot --apache --register-unsafely-without-email`
- Para fazer essa configuração é necessário ter um domínio disponível, não funciona em localhost.

- [ ] Instalação do `mariadb-server`
- [ ] Executar o script de segurança `mysql_secure_installation`
- [ ] Instalar os pacotes `php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip`
- [ ] Criação do banco de dados para o wordpress
- [ ] Criação de usuário e senha para trabalhar com o banco de dados
- [ ] Habilitar o módulo `rewrite` do apache `a2enmod rewrite`
- [ ] Testar a configuração do apache `apache2ctl configtest`
- [ ] Instalar o wordpress `curl -O https://wordpress.org/latest.tar.gz`
- [ ] Alterar o usuário/grupo em `/var/www/html/` para `www-data:www-data`
- [ ] Alterar as permissões dos arquivos `find . -type f -exec chmod 640 {} \;`
- [ ] Alterar as pemissões dos diretórios `find . -type d -exec chmod 750 {} \;`
- [ ] Gerar chave secreta para colocar no arquivo de configuração `wp-config.php` usando o comando `curl -s https://api.wordpress.org/secret-key/1.1/salt/`
- [ ] Configurar o arquivo `wp-config.php` com usuário, senha e tabela criada anteriormente
- [ ] Definir o método `define ('FS_METHOD', 'direct');` no arquivo `wp-config.php`
- [ ] Instalar e configurar `postix mailutils` para enviar e-mails locais
- [ ] Instalar e configurar o `logwatch` para visualizar relatórios diários de logs do sistema
- [ ] Configurar backups 
Os backups podem ser
- Completo
- Incremental
- Diferencial
- Espelhado
