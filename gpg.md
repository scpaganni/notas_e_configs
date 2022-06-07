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

`$ gpg --armor --export [id_chave ou email] > publickey.asc`

Para baixar uma chave do servidor

`$ gpg --recv-keys [id_chave] `

Atualizar as chaves no chaveiro

`$ gpg --refresh-keys`

Enviar uma chave para o servidor

`$ gpg --send-keys [id_chave]`

Para importar uma chave para nosso chaveiro

`$ gpg --import [nome_da_chave]`

Para importar a chave privada é necessário criar o diretório `~/.gnupg/private-keys-v1.d` se esse não exister.

Para editar uma chave 

`$ gpg --edit-key [id_chave]`

Para pesquisar uma chave

`$ gpg --search-keys [pesquisa]`

`$ gpg --search-keys [pesquisa] --keyserver keyserver.ubuntu.com --keyserver pgp.mit.edu`

Para criptografar um documento

`$ gpg --output [nome_arq].gpg --encrypt --recipient [chave_publica_destinatário] [nome_arq]`

Para descriptografar

`$ gpg --output [nome-arq] --decrypt [nome_arq].gpg`

É possível também criptografar um documento com uma chave simétrica diferente da chave privada

`$ gpg --output [nome_arq].gpg --symmetric [nome_arq]`

Assinar documento sem criptografar o mesmo

`$ gpg --clearsign [nome_arq]`

### Referências
[](https://gnupg.org/gph/en/manual.html#INTRO)
