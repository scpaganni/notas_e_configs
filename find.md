# Find

Para remover diretórios e arquivos vazios (tamanho zero) de seu diretório pessoal
(ou de qualquer outro lugar), utilize o comando find com as seguintes diretivas:

`# find . -empty`

O comando acima irá localizar tanto arquivos quanto diretórios. Para localizar apenas arquivos, utilize o comando:

`# find . -type f -empty`

Para localizar apenas diretórios:

`# find . -type d -empty`

Para remover os arquivos encontrados:

`# find . -type d -empty | xargs rm`

Para remover os arquivos ou diretórios vazios, apenas no diretório corrente:

`# find . -maxdepth 1 -type d -empty | xargs rmdir`

ou

`# find . -maxdepth 1 -type f -empty | xargs rm`