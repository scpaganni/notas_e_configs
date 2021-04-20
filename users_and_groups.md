# Usuários e Grupos

Diretórios Importantes:

_/etc/passwd_

_/etc/shadow_

_/etc/login.defs_

Comandos Importantes:

| Utilities  | Description |
|------------|-------------|
| id	       | Displays user and group IDs.|
|useradd, usermod, userdel|	Standard utilities for adding, modifying, and deleting user accounts.|
|groupadd, groupmod, groupdel|	Standard utilities for adding, modifying, and deleting groups.|
|gpasswd|	Standard utility for administering the /etc/group configuration file.|
|pwck, grpck|	Utilities that can be used for verification of the password, group, and associated shadow files.|
|pwconv, pwunconv|	Utilities that can be used for the conversion of passwords to shadow passwords, or back from shadow passwords to standard passwords.|
|grpconv, grpunconv|	Similar to the previous, these utilities can be used for conversion of shadowed information for group accounts.|

Adicionando um Usuário:

`# useradd [options] username`

c "comentário" = Geralmente usado para especificar o nome completo
-d home_directory = diretório home para ser usado em vez do padrão /home/user
-e data = Data para a conta para ser desativado no formato AAAA-MM-DD
-f dias = Número de dias após a senha expirar até que a conta está desativada
-g group_name = nome do grupo padrão do usuário
-G group_list = lista de grupos ao qual o usuário é membro
-m = cria o diretório home se não existir
-M = não cria o diretório home
-N = não cria um grupo privado pra o usuário
-p senha = senha criptografada
-r = Cria uma conta do sistema com um UID inferior a 1000 e sem um diretório home.
-s = especifica o shell de login do usuário
-u uid = ID de usuário para o usuário, que deve ser único e maior que 999.

Adicionando um Grupo:

`# groupadd [options] group_name`

Ativando Expiração das Senhas:

`# chage [options] username`

-d dias = Especifica o número de dias desde 1 de janeiro de 1970 a senha foi alterada.
-E data = Especifica a data em que a conta será bloqueada, no formato AAAA-MM-DD. Em vez da data, o número de dias desde 1 de Janeiro, de 1970, pode também ser usado.
-I = Especifica o número de dias inativos após a expiração de senha antes de bloquear a conta. Se o valor for  0, a conta não é bloqueada após a senha expirar.
-l = Lista as configurações de conta de envelhecimento atuais.
-m dias = Especifique o número mínimo de dias após o qual o usuário pode alterar a senha. Se o valor for  0, a senha não expira.
-M dias = Especifique o número máximo de dias em que a senha é válida. Quando o número de dias especificado nesta opção mais o número de dias especificado com o -d opção é menos do que o dia atual, o usuário deve mudar a senha antes de usar a conta.
-W dias = Especifica o número de dias antes da data de expiração de senha para avisar o usuário.

Informações Adicionais:

- useradd(8) — The manual page for the useradd command documents how to use it to create new users.
- userdel(8) — The manual page for the userdel command documents how to use it to delete users.
- usermod(8) — The manual page for the usermod command documents how to use it to modify users.
- groupadd(8) — The manual page for the groupadd command documents how to use it to create new groups.
- groupdel(8) — The manual page for the groupdel command documents how to use it to delete groups.
- groupmod(8) — The manual page for the groupmod command documents how to use it to modify group membership.
- gpasswd(1) — The manual page for the gpasswd command documents how to manage the /etc/group file.
- grpck(8) — The manual page for the grpck command documents how to use it to verify the integrity of the /etc/group file.
- pwck(8) — The manual page for the pwck command documents how to use it to verify the integrity of the /etc/passwd and /etc/shadow files.
- pwconv(8) — The manual page for the pwconv, pwunconv, grpconv, and grpunconv commands documents how to convert shadowed information for passwords and groups.
- id(1) — The manual page for the id command documents how to display user and group IDs.
- group(5) — The manual page for the /etc/group file documents how to use this file to define system groups.
- passwd(5) — The manual page for the /etc/passwd file documents how to use this file to define user information.
- shadow(5) — The manual page for the /etc/shadow file documents how to use this file to set passwords and account expiration information for the system.
