# Comandos do LVM
Criar o PV:
```
pvcreate /dev/sdb1
pvcreate /dev/sdb2
pvcreate /dev/sdb3
pvcreate /dev/sdc1
pvcreate /dev/sdc2
pvcreate /dev/sdc3
```

Visualizar informações do PV:
```
pvs
pvdisplay
```

Criar o VG:
```
vgcreate <nome_do_vg> <devices_do_vg>
vgcreate vg01 /dev/sdb1 /dev/sdb2
vgcreate vg02 /dev/sdb3 /dev/sdc1
vgcreate vg03 /dev/sdc2
```

Visualizar informações do VG:
```
vgs
vgdisplay
```

Ativar um VG:
```
vgchange -a y <nome_do_volume>
```

Remover um VG:
```
vgchange -a n <nome_do_volume>
vgremove <nome_do_volume>
```

Adicionar um PV a um VG existente:
```
vgextend <nome_do_volume> <devices>
vgextend vg03 /dev/sdc3
```

Removendo um PV de um VG existente:
```
vgreduce <nome_do_volume> <device>
vgredure vg01 /dev/sdb1
```

Criar o LV:
```
lvcreate -L <tamanho> -n <nome_do_lv> <grupo_lv>
lvcreate -L 3GB -n lv01 vg01
vcreate -L 3GB -n lv02 vg01
lvcreate -L 2.99 -n lv03 vg02
lvcreate -L 2GB -n lv04 vg02
lvcreate -L 3GB -n lv05 vg03
```

Visualizar informações do LV
```
lvs
lvdisplay
lvscan
```

Formatar o sistema de arquivos:
```
mkfs -t ext4 /dev/vg01/lv01
mkfs -t ext4 /dev/vg01/lv02
mkfs.ext4 /dev/vg02/lv03
mkfs.ext4 /dev/vg02/lv04
mkfs.ext4 /dev/vg03/lv05
```

Expandir o LV:
```
lvextend -L 6.99GB /dev/vg03/lv05
resize2fs -p /dev/vg03/lv05
```

Verificar se não houve erros:
```
e2fsck -f /dev/vg03/lv05
```

Diminur o LV:
```
resize2fs -p /dev/vg03/lv05 2.5GB
lvreduce -L 2.5GB /dev/vg03/lv05
e2fsck -f /dev/vg03/lv05
```

Remover um LV:
```
lvremove /dev/<nome_do_vg>/<nome_do_lv>
```

