# Criar certificados auto-assinados
Gerar chave privada sem senha

```
openssl genrsa -out [nome].key [1024 | 2048 | 4096]
```

Geração do CSR

   1. No mesmo diretório execute o seguinte comando:

```
openssl req -new -key [nome].key -out [nome].csr
```

   2. Após executar o comando, responda as perguntas:

      * Country Name: BR
      * State or Province Name: Seu estado por extenso e sem abreviações.
      * Locality Name: Sua cidade.
      * Organization: Nome oficial da empresa, igual ao existente no cartão do CNPJ.
      * Organizational Unit: Departamento ou setor da empresa.
      * Common Name: url onde o certificado vai ser utilizado.

      * Email Address: Não informe nada, deixe em branco.
      * A challenge password: Não informe nada, deixe em branco.
      * An optional company name: Não informe nada, deixe em branco.

Para auto assinar o certificado:

```
openssl x509 -req -days 365 -in [nome].csr -signkey [nome].key -out [nome].crt
```

Concatenar, opcionalmente, a key e o crt

```
cat [nome].key [nome].crt > [nome].pem
```

Gerar certifado no Fedora para o Openldap:
```
cp /etc/pki/tls/certs
```

Criar a chave:
```
make server.key
```

Tirar a senha da chave:
```
openssl rsa -in server.key -out server.key
```

Gerar o pedido de certificado do servidor:
```
make server.csr
```

Assinar o certificado:
```
openssl x509 -in server.csr -out server.crt -req -signkey server.key -days 3650
```

# Criação de certificado no debian

Criar uma autoridade certificadora no Debian:
```
/usr/lib/ssl/misc/CA.pl -newca
```

Criar um pedido de certificação:
```
/usr/lib/ssl/misc/CA.pl -newreq
```

Assinar o certicado criado com a chave da CA:
```
/usr/lib/ssl/misc/CA.pl -signreq
```

Temos no diretório os seguintes arquivos:

**newkey.pem** = chave privada do servidor<br>
**newreq.pem** = pedido de certificado<br>
**newcert.pem** = certificado assinado<br>

Retirar a senha do arquivo newkey.pem:
```
openssl rsa -in newkey.pem -out newkey.pem
```

Instalar o certificado da CA no sistema:
```
cp demoCA/cacert.pem /usr/share/ca-certificates/nome_da_ca.crt
```

Adicionar o **nome_da_ca.crt** no arquivo **/etc/ca-certificates.conf**

Atualizar a base de certificados:
```
update-ca-certificates
```

Para ver se o processamento do certificado está correto, debugging:
```
openssl s_client -connect example.com:636
```