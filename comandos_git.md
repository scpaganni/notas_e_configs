# Comandos do git

Configurando o git:

```
git config --global user.name "nombre_usuario"
git config --global user.email "email_id"
```

Verificando as configurações:

```
git config --list
```

Criando um repositório:

```
git init [repositório]
```

Adicionando arquivos para a Stage Área:

```
git add [arquivo]
```

Fazendo um commit:

```
git commit -m "comentário das alterações"
```

Fazendo um commit sem passar pela Stage Área:

```
git commit -a -m "comentário das alterações"
```

Verificando o status dos arquivos:

```
git status
```

Visualizar o histórico de commits:

```
git log
```

Opções do comando git log:

```
-p 	             Mostra o patch introduzido com cada commit.
--stat 	         Mostra estatísticas de arquivos modificados em cada commit.
--shortstat 	 Mostra somente as linhas modificadas/inseridas/excluídas do comando --stat.
--name-only 	 Mostra a lista de arquivos modificados depois das informações do commit.
--name-status 	 Mostra a lista de arquivos afetados com informações sobre adição/modificação/exclusão dos mesmos.
--abbrev-commit  Mostra somente os primeiros caracteres do checksum SHA-1 em vez de todos os 40.
--relative-date  Mostra a data em um formato relativo (por exemplo, “2 semanas atrás”) em vez de usar o formato de data completo.
--graph 	     Mostra um gráfico ASCII do branch e histórico de merges ao lado da saída de log.
--pretty 	     Mostra os commits em um formato alternativo. Opções incluem oneline, short, full, fuller, e format (onde você especifica seu próprio formato).
```

Retirando arquivos da stage área (áre de seleção):

```
git reset HEAD <file>
```

Desfazendo arquivo modificado:

```
git checkout -- file
```

Adicionando repositórios remotos:

```
git remote add [nomecurto] [url]
```

Visualizando os repositórios remotos:

```
git remote [-v]
```

Pegar dados dos projetos remotos sem fazer merge (apenas faz download dos dados):

```
git fetch [nome-remoto]
```

Pegar dados dos projetos remotos e fazer merge automaticamente:

```
git pull [nome-remoto]
```

Enviando dados dos projetos para os repositorios remotos:

```
git push [nome-remoto] [branch]
```

Inspecionando um remoto, vendo mais informação sobre algum remoto em particular:

```
git remote show [nome-remoto]
```

Removendo e renomeando repositórios remotos:

```
git remote rename [nome] [nome]
git remote rm [nome]
```

Listando tags:

```
git tag
```

Criando tags anotadas:

```
git tag -a v1.4 -m 'my version 1.4'
```

Criando tags assinadas:

```
git tag -s v1.5 -m 'my signed 1.5 tag'
```

Criando tags leves:

```
git tag v1.4-lw
```

Verificando tags:

```
git tag -v [nome-tag]
```

Compartilhando tags no repositório remoto:

```
git push origin [nome-tag]
```

Enviando várias tags ao mesmo tempo:

```
git push origin --tags
```

Criando um novo branching:

```
git branch [nome]
```

Para mudar para um branch existente:

```
git checkout [nome]
```

Criar um branch e mudar pra ele ao mesmo tempo:

```
git branch -b [nome]
```

Para ver o último commit em cada branch:

```
git branch -v
```

Para ver os branchs mesclados no branch em que você está:

```
git branch --merged
```

Para ver todos os branches que contém trabalho que você ainda não fez o merge:

```
git branch --no-merged
```

Adicionar github token no terminal

```
git remote add origin https://[USERNAME]:[NEW TOKEN]@github.com/[USERNAME]/[REPO].git
```

```
git remote set-url origin https://[USERNAME]:[NEW TOKEN]@github.com/[USERNAME]/[REPO].git
```

Fazer push para o repositório remoto usando o token:

```
git remote set-url origin https://<githubtoken>@github.com/<username>/<repositoryname>.git
```
