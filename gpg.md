Instalar o pacote GnuGP2

`# apt install gnupg2`

`# dnf install gnupg2`

Gerar as chaves

`$ gpg --gen-key`

Listar as chaves

`$ gpg --list-keys`

`$ gpg --list-secret-keys `

Exportar uma chave pública

`$ gpg --output public.gpg  --export [id_chave ou email]`

Exportar uma chave pública no formato ASC

`gpg --armor --export [id_chave ou email] > publickey.asc`
