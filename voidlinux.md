Alterando o tamanho da janela quando instalado na máquina virtual

`$ xrandr --output Virtual-1 --mode 1920X1080`

Após instalar o sistema é necessário rodar o seguinte 
comando para sincronizar e atualizar

`# xbps-install -Su`

Para instalar repositórios

`# xbps-install void-repo-nonfree`

`# xbps-install void-repo-multilib`

`# xbps-install void-repo-multilib-nonfree`

Pesquisar pacotes instalados no sistema

`# xbps-query [nome-do-pacote]`

Pesquisar pacotes nos repositórios

`# xbps-query -Rs [nome-do-pacote]`

Remover um pacote instalado sem as dependências

`# xbps-remove [nome-do-pacote]`

Remover um pacote instalado com as dependências

`# xbps-remove -R [nome-do-pacote]`

Remover dependências orfãs do sistema

`# xbps-remove -o`

Para alterar os mirrors no Void Linux é necessário

`# mkdir -p /etc/xbps.d`
`# cp /usr/share/xbps.d/*repository*.conf /etc/xbps.d`

Depois é só entrar no diretório `/etc/xbps.d` e editar o arquivos
coloando o repositóro desejado
