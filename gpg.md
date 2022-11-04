Instalar o pacote GnuGP2

`# apt install gnupg2`

`# dnf install gnupg2`

Gerar as chaves

`$ gpg --full-generate-key`

Listar as chaves

`$ gpg --list-keys`

`$ gpg -k`

`$ gpg --list-secret-keys `

Para ver o fingerprint de uma chave:

`$ gpg --fingerprint`

```
/root/.gnupg/pubring.kbx
------------------------
pub   rsa3072 2022-10-16 [SC] [expires: 2022-10-21]
      0A72 7A72 8EBC DF48 A780  94AC 64A8 9A4E 375B 648C
uid           [ultimate] Sergio Pagani <scpaganni@gmail.com>
sub   rsa3072 2022-10-16 [E] [expires: 2022-10-21]
```

Os últimos quatro campos (16 caracteres) são o fingerprint da chave.

Criar um certificado de revogação:

`$ gpg --output revocation.crt --gen-revoke 64a89a4e375b648c`

Exportar uma chave pública

`$ gpg --output [nome_arq] --armor --export 64a89a4e375b648c`

Exportar uma chave pública no formato ASC

`$ gpg --armor --export 64a89a4e375b648c > [nome_arq].asc`

Exportar uma chave privada

`$ gpg --export-secret-keys --armor 64a89a4e375b648c > [nome_arq]`

Para baixar uma chave do servidor

`$ gpg --recv-keys [id_chave] `

Atualizar as chaves no chaveiro

`$ gpg --refresh-keys`

Enviar uma chave para o servidor

`$ gpg --send-keys [id_chave]`

Para importar uma chave para nosso chaveiro

`$ gpg --import [nome_arq]`

Para importar a chave privada é necessário criar o diretório `~/.gnupg/private-keys-v1.d` se esse não exister.

Para editar uma chave 

`$ gpg --edit-key [id_chave]`

Para pesquisar uma chave

`$ gpg --search-keys [pesquisa]`

`$ gpg --search-keys [pesquisa] --keyserver keyserver.ubuntu.com --keyserver pgp.mit.edu`

Para criptografar um documento com a chave pública do destinatário

`$ gpg --output [nome_arq].gpg --encrypt --recipient [chave_publica_destinatário] [nome_arq]`

Para descriptografar

`$ gpg --output [nome-arq] --decrypt [nome_arq].gpg`

É possível também criptografar um documento com uma chave simétrica diferente da chave privada

`$ gpg --output [nome_arq].gpg --symmetric [nome_arq]`

Assinar documento sem criptografar o mesmo de forma que continue legível

`$ gpg --clear-sign [nome_arq]`

Verificando a assinatura de um documento

`$ gpg --verify [nome_arq]`

### Referências
[](https://gnupg.org/gph/en/manual.html#INTRO)
