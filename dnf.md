# Gerenciamento de pacotes

Atualizar o sistema:

`# dnf upgrade`

Atualizar um único pacote:

`# dnf upgrade package_name`

Procurar um pacote:

`# dnf search package_name`

Listar todos os pacotes instalados e disponíveis:

`# dnf list all`

Listar apenas os pacotes instalados:

`# dnf list installed`

Listar todos os pacotes disponíveis em todos os repositórios habilitados:

`# dnf list available`

Listar todos os grupos de pacote:

`# dnf group list`

Listar o repositório ID, nome e número de pacotes que ele fornece para cada habilitado repositório:

`# dnf repolist`

Listar os pacotes do repositório especificado:

`# dnf repository-packages repo_id list`

Exibir informações sobre um pacote:

`# dnf info package_name`

Instalar um pacote:

`# dnf install package_name`

Instalar um grupo de pacotes:

`# dnf group install group_name`

ou

`# dnf group install groupid`

ou

`# dnf install @group`

Exemplos:

```
# dnf group install "KDE Plasma Workspaces"
# dnf group install kde-desktop-environment
# dnf install @kde-desktop-environment

```

Remover um pacote:

`# dnf remove package_name`

Remover um grupo de pacotes:

```
# dnf group remove group_name
# dnf remove @group
```

Exemplos:

```
~]# dnf group remove "KDE Plasma Workspaces"
~]# dnf group remove kde-desktop-environment
~]# dnf remove @kde-desktop-environment
```

Exibir a lista de transações feitas com dnf:

`# dnf history list`

Para exibir transações em um determinado intervalo:

`# dnf history list start_id end_id`

Para desfazer uma transação:

`# dnf history undo id`

Para refazer uma transação:

`# dnf history redo id`

Para listar as opções de configuração e os repositórios:

`# dnf config-manager --dump`

Adicionar um repositório:

`# dnf config-manager --add-repo http://www.example.com/example.repo`

Habilitar um repositório:

`# dnf config-manager --set-enabled repository`

Desabilitar um repositório:

`# dnf config-manager --set-disabled repository`