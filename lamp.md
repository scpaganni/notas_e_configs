# Instalção do lamp no Debian
Instalar os pacotes:

```
sudo apt-get install apache2 apache2-utils php5 libapache2-mod-php5 php5-mcrypt php5-gd libssh2-php
sudo apt-get install mariadb-server php5-mysql
```

```
sudo mysql_secure_installation
```

# Instalar lamp no Fedora:


Instalar o apache:

```
dnf install httpd
systemctl enable httpd
systemctl start httpd
```

Configurar o firewall para aceitar requisições externas do apache:

```
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
```

Instalar o MySQL:

```
dnf install mariadb mariadb-server
systemctl start mariadb
systemctl enable mariadb

```
```
mysql_secure_installation
```

Instalar o PHP

```
dnf install php php-mysql php-mysqlnd php-mssql php-opcache
```

Criar a database e o usuário do MySQL 

```
mysql -u root -p
CREATE DATABASE [database];
CREATE USER [usuario]@localhost IDENTIFIED BY '[senha]';
GRANT ALL PRIVILEGES ON [database].* TO [usuario]@localhost;
FLUSH PRIVILEGES;
```

# Remover o mysql completamente no Debian:

```
sudo apt-get remove --purge mysql-server
sudo apt-get remove --purge phpmyadmin
sudo /etc/init.d/mysql stop
sudo apt-get remove --purge mysql-common
sudo rm -rf /var/lib/mysql
sudo apt-get autoremove --purge
```
