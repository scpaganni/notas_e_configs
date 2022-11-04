*Selinux* fornece um controle de acesso mandatório que, ao contrário do 
seu equivalente (DAC), dá ao administrador controle total do que é
permitido no sistema e o que não é. Ele faz isso através de políticas impostas por meio do kernel do Linux.

- usa rótulos para identificar recursos
- difere dos outros controles de acesso
- impõe regras de segurança através de arquivos de política

Sistemas de contrle de acesso obrigatórios, como o Selinux, são suportados no kernel Linux por meio do *Linux Security Modules (LSM)*.

Para ver a lista de módulos LSM ativas no sistema

```console
# cat /sys/kernel/security/lsm
lockdown,capability,yama,selinux,bpf,landlock Yama
```

Para ver as ACLs aplicadas a um arquivo:

```console
# getfacl /etc/dnf/dnf.conf
getfacl: Removing leading '/' from absolute path names
# file: etc/dnf/dnf.conf
# owner: root
# group: root
user::rw-
group::r--
other::r--
```

Quando o SELinux precisa decidir se deve permitir ou negar uma ação específica, ele toma uma
decisão com base no contexto tanto do sujeito (que está iniciando a ação) quanto do objeto (que é o
alvo da ação). Esses contextos (ou partes do contexto) são mencionados nas regras de política que o
SELinux impõe. O contexto de um processo é o que identifica o processo para o SELinux:

Para ver o contexto d usuário atual

```
~ id -Z
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
```

