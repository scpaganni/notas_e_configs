# Locale e keyboard

Configurações de localidade de todo o sistema são armazenadas no arquivo /etc/locale.conf, que é lido na inicialização pelo daemon systemd.

Mostrar o locale atualmente instalado

```
# localectl status
   System Locale: LANG=pt_BR.UTF-8
       VC Keymap: br
      X11 Layout: br
```

Listagem dos locales disponíveis:

```
# localectl list-locales
en_AG
en_AG.utf8
en_AU
en_AU.iso88591
en_AU.utf8
en_BW
en_BW.iso88591
en_BW.utf8

output truncated
```

Setando um Locale:

`# localectl set-locale LANG=locale`

`# localectl set-locale LANG=en_GB.utf8`

Listar os layouts de teclado:

`# localectl list-keymaps`

Setando um keymap no console e no X11

`# localectl set-keymap map`

`# localectl set-x11-keymap map`

Se você quiser que o layout do X11 seja diferente do layout do console, use a opção _--no-convert_.

`# localectl --no-convert set-x11-keymap map`

Use:
- localectl(1) — The manual page for the localectl command line utility documents how to use this tool to configure the system locale and keyboard layout.
- loadkeys(1) — The manual page for the loadkeys command provides more information on how to use this tool to change the keyboard layout in a virtual console.
