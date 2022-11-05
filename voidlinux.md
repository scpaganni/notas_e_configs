Pacotes necessários:

`font-fira-otf font-awesome6  github-cli vscode mpv fzf lsd telegram-desktop`

KDE Apps

`sudo xbps-install dolphin-plugins ark partitionmanager  okular gwenview strawberry ffmpegthumbnailer ffmpegthumbs kdegraphics-thumbnailers`

Instalar o libvirt

`$ sudo xbps-install libvirt virt-manager qemu`

Habilitar o serviço

`ln -s /etc/sv/libvirtd /etc/runit/runsvdir/default`

`ln -s /etc/sv/virtlockd /etc/runit/runsvdir/default`

`ln -s /etc/sv/virtlockd /etc/runit/runsvdir/default`

Inicizalizar o serviço

`$ sudo sv up libvirtd`

`$ sudo sv up virtlockd`

`$ sudo sv up virtlogd`

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

`# xbps-query -l`

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
