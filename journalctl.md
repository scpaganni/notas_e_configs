Logs através do journalctl

O arquivo de configuração do `journalctl` é o arquivo `/etc/systemd/journald.conf`

Ver todas mensagens de log

`# journalctl`

Ver mensagens a partir do último boot:

`# journalctl -b`

Ver mensagens a partir de um horário:

`# journalctl -b --since "2022-11-23 15:00"`

Ver mensagens dentro de uma faixa de horário

`# journalctl -b --since "2022-11-23 15:10" --until "2022-11-23 15:30"`

Ver mensagens de uma unity

`# journalctl -u ssh`

`# journalctl -u ssh --since yesterday`

Ver somente mensagens de kernel

`# journalctl -k`

Ver somente mensagens de kernel que tenham erro

`# journalctl -k -p err`

Ver mensagens configurando o output

`# journalctl -k -o json`

`# journalctl -k -o json-pretty`

`# journalctl -k -o verbose`

Ver as mensagens da mesma forma que `tail -f`

`# journalctl -u ssh -f`

Ver o espaço ocupado pelos arquivos de log

`# journalctl --disk-usage`
