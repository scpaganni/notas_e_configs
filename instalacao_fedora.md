
Instalação para virtualização no Fedora

`sudo dnf group install --with-optional virtualization guestfs-tools`

Para instalar vagrant com suporte a libvirt é necessário esses pacotes:

`sudo dnf install gcc libvirt libvirt-devel libxml2-devel make ruby-devel`

`vagrant plugin install vagrant-libvirt`

Habilitar autocomplete para o vagrant:

`vagrant autocomplete install --bash --zsh`

Apps necessários

`dnf install zsh timeshift  git neovim g++ unrar telegram-desktop lsd fira-code-fonts powerline-fonts kitty gh fd-find fzf ripgrep syncthing`

Gnome

`sudo dnf install gnome-tweaks`

Pacotes Multimedia

`sudo dnf install install gstreamer1-plugins-bad-* gstreamer1-plugins-good-* gstreamer1-plugins-base gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel`

Pacotes para remover do Kde Plasma

`sudo dnf erase akregator kaddressbook kamera kamoso kcolorpicker kde-connect konversation korganizer kmail kmines kmahjongg elisa kolourpaint kontact kmouth dragon kpat dnfdragora krdc krfb libreoffice-math elisa-player kmag kmousetool gnome-abrt kfind plasma-browser-integration`

Pacotes para remover do Xfce

`sudo dnf erase xfburn parole pragha asunder pidgin claws-mail transmission gnumeric dnfdragora system-config-printer gnome-abrt xfce4-dict`

Pacotes para instalar no Kde Plasma

`sudo dnf install strawberry mpv ffmpegthumbnailer ffmpegthumbs`

Instalação do starship terminal

`$ curl -sS https://starship.rs/install.sh | sh`

Instalação do Vscode

```bash
$ sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
```

`$ sudo dnf install code`

Habilitar Rpmfusion

`sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm`

Pacotes Flathub

Adicionar repositório flathub no sistema:

`sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo`

`flatpak install flathub com.getmailspring.Mailspring`

`flatpak install flathub net.agalwood.Motrix`

`flatpak install flathub com.bitwarden.desktop`

Instalação do Oh-my-zsh e outros plugins

`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

`git clone https://github.com/marlonrichert/zsh-autocomplete ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete`

`git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

Instalação dos temas para o kitty terminal

`git clone --depth 1 https://github.com/dexpota/kitty-themes.git ~/.config/kitty/kitty-themes`
