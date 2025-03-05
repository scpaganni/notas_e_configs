Habilitar Rpmfusion

`sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm`

Pacotes para remover do Kde Plasma

`sudo dnf remove akregator kaddressbook kamera kamoso kcolorpicker kde-connect konversation korganizer kmail kmines kmahjongg elisa kolourpaint kontact kmouth dragon kpat dnfdragora krdc krfb libreoffice-math elisa-player kmag kmousetool gnome-abrt kfind plasma-browser-integration`

Pacotes para instalar no Kde Plasma

`sudo dnf install strawberry mpv ffmpegthumbnailer ffmpegthumbs`

Pacotes Multimedia

`sudo dnf install gstreamer1-plugins-bad-* gstreamer1-plugins-good-* gstreamer1-plugins-base gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel`

Apps necessários

`dnf install zsh git neovim g++ unrar telegram-desktop lsd fira-code-fonts powerline-fonts kitty gh fd-find fzf ripgrep syncthing bat lsd duf tldr`

Instalação da Impressora Epson:

`sudo dnf install epson-inkjet-printer-escpr`

Instalação do Libreoffice:

`sudo dnf install libreoffice libreoffice-langpack-pt-BR`

Instalação do Calibre:

`sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin`

Instalação do Chrome:

`sudo dnf install google-chrome-stable`

Instalação do Vscode

```bash
$ sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
```

`$ sudo dnf install code`

Gnome

`sudo dnf install gnome-tweaks`

Pacotes para remover do Xfce

`sudo dnf erase xfburn parole pragha asunder pidgin claws-mail transmission gnumeric dnfdragora system-config-printer gnome-abrt xfce4-dict`

Instalação para virtualização no Fedora (virtmanager e libvirt)

`sudo dnf group install --with-optional virtualization guestfs-tools`

Habilitar a `libvirt` na inicialização do sistema:

`sudo systemctl enable --now libvirtd`

Para instalar vagrant com suporte a libvirt é necessário esses pacotes:

`sudo dnf install gcc libvirt libvirt-devel libxml2-devel make ruby-devel`

`vagrant plugin install vagrant-libvirt`

Habilitar autocomplete para o vagrant:

`vagrant autocomplete install --bash --zsh`

Instalação do starship terminal

`$ curl -sS https://starship.rs/install.sh | sh`

Instalação do yadm

`sudo curl -fLo /usr/local/bin/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && sudo chmod a+x /usr/local/bin/yadm`

Pacotes Flathub

Adicionar repositório flathub no sistema:

`sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo`

`flatpak install flathub net.agalwood.Motrix`

`flatpak install flathub rocks.koreader.KOReader`

`flatpak install flathub md.obsidian.Obsidian`

`flatpak install flathub com.bitwarden.desktop`

`flatpak install flathub io.freetubeapp.FreeTube`

`flatpak install flathub com.brave.Browser`

`flatpak install flathub com.ticktick.TickTick`

Instalação do Oh-my-zsh e outros plugins

`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

`git clone https://github.com/marlonrichert/zsh-autocomplete ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete`

`git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

Instalação dos temas para o kitty terminal

`git clone --depth 1 https://github.com/dexpota/kitty-themes.git ~/.config/kitty/kitty-themes`
