Gerar um par de chaves RSA:

`$ ssh-keygen -t rsa`

As permissões do diretório ~/.ssh são definidas como `rwx------` ou `700` em notação octal.

Para copiar a chave pública para uma máquina remota:

`$ ssh-copy-id user@hostname`

ou

`$ ssh-copy-id -i ~/.ssh/id_rsa.pub user@hostname`

Para gerar um par de chaves ECDSA:

`$ ssh-keygen -t ecdsa`

Para configurar o ssh-agent para armazenar a senha durante a sessão:

`$ ssh-add`

Autenticação de Certificado OpenSSH

O uso de criptografia de chave pública para autenticação requer a cópia da chave pública de cada cliente para cada servidor que o cliente pretende fazer.

O utilitário `ssh-keygen` suporta dois tipos de certificados: usuário e host.Os certificados de usuário autenticam os usuários nos servidores, enquanto os certificados do host autenticam os hosts do servidor aos usuários. Para que os certificados sejam usados na autenticação de usuário ou host, o daemonsshd deve ser configurado para confiar na chave pública da CA.

Gerar as chaves de assinatura do certificado SSH CA:

No servidor designado para ser o CA é necessário gerar duas chaves para assinatura dos certificados.

Para gerar a chave de assinatura do certificado de usuário:

`ssh-keygen -t rsa -f ~/.ssh/ca_user_key`

Para gerar a chave de assinatura do certificado de host:

`ssh-keygen -t rsa -f ~/.ssh/ca_host_key`

Crie o próprio certificado de host do servidor da CA assinando a chave pública do host do servidor juntamente com uma seqüência de identificação, como o nome do host, o nome de domínio totalmente qualificado ( FQDN ) do servidor da CA , mas sem o alcance. e um período de validade. O comando assume a seguinte forma:

`ssh-keygen -s ~/.ssh/ca_host_key -I certificate_ID -h -n host_name.example.com -V -start:+end /etc/ssh/ssh_host_rsa.pub`

`ssh-keygen -s ~/.ssh/ca_host_key -I host_name -h -n host_name.example.com -V -1w:+54w5d /etc/ssh/ssh_host_rsa.pub`
