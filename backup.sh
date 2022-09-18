#!/usr/bin/env sh

###############################################################################
#############################     VARIÁVEIS       #############################

# Diretório aonde os backups serão salvos
BACKUP_DIR="/var/backup_sistema"

# Diretórios para fazer backup
SOURCE="
/var/www/html
/home/
/etc/
"

# Formato de hora para utilizar no nome do backup
# Nosso padrão é: ddmmYYYY
DATE="$(date +%d%m%Y)"

# Nome do arquivo final
FINAL="backup-$DATE.tar.gz"

# Automaticamente a cada "X" dias os backups mais antigos serão apagados
KEEP_DAY="7"

###############################################################################
#############################     TESTES          #############################

[ ! -d $"$BACKUP_DIR" ] && mkdir "$BACKUP_DIR"

###############################################################################
#############################      INICIO         #############################

# tar [OPÇÕES] [ARQUIVO FINAL] [DIRETÓRIOS PARA BACKUPS]
tar -cpzf "$BACKUP_DIR/$FINAL" $SOURCE

 # Deleta arquivos com mais de "X" dias
 find $BACKUP_DIR -mtime +"$KEEP_DAY" -delte
