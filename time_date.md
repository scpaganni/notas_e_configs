# Time e Date

Exibição de Data e Hora Atuais:

```
# timedatectl
      Local time: qui 2017-05-25 20:31:25 -04
  Universal time: sex 2017-05-26 00:31:25 UTC
        RTC time: sex 2017-05-26 00:31:25
       Time zone: America/Porto_Velho (-04, -0400)
 Network time on: yes
NTP synchronized: yes
 RTC in local TZ: no
```

Alterando a Hora Atual:

`# timedatectl set-time HH:MM:SS`

`# timedatectl set-time 23:26:00`

Alterando a Data Atual:

`# timedatectl set-time YYYY-MM-DD`

`# timedatectl set-time "2013-06-02 23:26:00"`

Alterando o Time Zone:

`# timedatectl list-timezones`

`# timedatectl set-timezone time_zone`

`# timedatectl set-timezone Europe/Prague`

Sincronizando o Relógio do Sistema com um Servidor Remoto:

`# timedatectl set-ntp yes|no`

Usando o comando _date_:

`# date`

`# date --utc`

`# date +"format"`

|  Flags |                             Descrição                                                                 |
|--------|-------------------------------------------------------------------------------------------------------|
| %H     |	The hour in the HH format (for example, 17).                                                         |
| %M     |	The minute in the MM format (for example, 30).                                                       |
| %S     |	The second in the SS format (for example, 24).                                                       |
| %d     |	The day of the month in the DD format (for example, 16).                                             |
| %m     |	The month in the MM format (for example, 09).                                                        |
| %Y     |	The year in the YYYY format (for example, 2013).                                                     |
| %Z     |	The time zone abbreviation (for example, CEST).                                                      |
| %F     |	The full date in the YYYY-MM-DD format (for example, 2013-09-16). This option is equal to %Y-%m-%d.  |
| %T     |	The full time in the HH:MM:SS format (for example, 17:30:24). This option is equal to %H:%M:%S       |

Alterando a Hora Atual:

`# date --set HH:MM:SS`

`# date --set HH:MM:SS --utc`

`# date --set 23:26:00`

Alterando a Data Atual:

`# date --set YYYY-MM-DD`

`# date --set 2013-06-02 23:26:00`

Visualizando a Data e Hora Atual com o comando _hwclock_:

`# hwclock`

Configurando a Data e a Hora:

`# hwclock --set --date "dd mmm yyyy HH:MM"`

`# hwclock --set --date "21 Oct 2014 21:17" --utc`

Definindo o Relógio de Hardware a partir da Hora Atual do Sistema:

`# hwclock --systohc`

Definindo a Hora Atual do Sistema a partir do Relógio do de Hardware:

`# hwclock --hctosys`

- timedatectl(1) — The manual page for the timedatectl command line utility documents how to use this tool to query and change the system clock and its settings.
- date(1) — The manual page for the date command provides a complete list of supported command line options.
- hwclock(8) — The manual page for the hwclock command provides a complete list of supported command line options.
