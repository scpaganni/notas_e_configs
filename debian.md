# Comandos referente ao debian

Remover arquitetura i386:

```
dpkg -l | grep :i386 | cut -s -d ' ' -f3 | xargs apt-get remove -y
dpkg --remove-architecture i386
apt-get update
```

Importar Chaves:

```
gpg --keyserver subkeys.pgp.net --recv [chave]
gpg --export --armor [chave] | apt-key add -
```

Listar pacotes instalados:

`dpkg --get-selections "*"`

Identificar pacotes retidos pelo aptitude com:

`aptitude search "~ahold"`

Caso você queira verificar quais pacotes você tem retidos pelo apt-get, você deve usar:

`dpkg --get-selections | grep 'hold$'`

Gravando uma sessão de atualização:

`script -t 2>~/upgrade-jessie-etapa.hora -a ~/upgrade-jessie-etapa.script`

Caso você tenha usado a opção -t para o script, você pode usar o programa scriptreplay para reproduzir toda a sessão:

`scriptreplay ~/upgrade-jessie-etapa.hora ~/upgrade-jessie-etapa.script`

O apt-get pode exibir informações detalhadas sobre o espaço em disco necessário para a instalação. Antes de executar a atualização, você pode ver essa estimativa executando:

`apt-get -o APT::Get::Trivial-Only=true dist-upgrade`

Caso você tenha o popularity-contest instalado, você pode usar o popcon-largest-unused para listar os pacotes que você não usa.

Para eliminar alguns dos pacotes problemáticos:

```
apt-get -f install
dpkg --configure --pending
```

Expurgar pacotes todos os pacotes removidos:

`apt-get purge $(dpkg -l | awk '/^rc/ { print $2 }')`

O programa debsums faz a checagem das somas md5 de pacotes instalados no sistema a partir do diretório **/var/lib/dpkg/info**.

```
debsums -a: verifica a integridade de todos os arquivos do sistema.
debsums -e: verifica apenas os arquivos de configuração.
debsums -c: lista no stdout apenas os arquivos modificados.
debsums -l: lista os arquivos que não possuem o md5sum.
debsums -s: lista somente os erros, é uma opção silenciosa.
```
