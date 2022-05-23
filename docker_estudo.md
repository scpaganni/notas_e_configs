Criar o container
`docker run -ti -p 4000:4000 --name jekyll --volume="$PWD:/srv/jekyll:Z" fedora`

Executar um comando dentro do container
`docker container exec jekyll sh -c "cd /srv/jekyll && /bin/jekyll serve --host 0.0.0.0"`

Inspecionar o ip do container
`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' jekyll`


*Dockerfile jekyll*

```
FROM fedora
LABEL maintainer 'Sergio Pagani <scpaganni at gmail.com.br>

RUN dnf install jekyll -y && \
    mkdir /srv/jekyll && \
    cd /srv/jekyll && \
    /bin/jekyll new blog

WORKDIR /srv/jekyll/blog
EXPOSE 4000
```

O docker possui quatro tipos de redes:
* none network
* bridge network (default)
* host network
* overlay network (swarm)

Criando um container sem rede

`docker container run -d --net none debian`

`docker container exec -it [container] ping [ip_outro_container]`

Criando um nova rede no docker

`docker network create --driver bridge rede_nova`
`docker network ls`
`docker networkd inspect rede_nova`
`docker container run -d --name [container] --net rede_nova alpine sleep 1000`

Conectando um cotainer a rede bridge

`docker network connect bridge [container]`

Executando um comando dentro do container

`docker container exec -it [container] ifconfig`

Criando container com a interface do host

`docker container run -d --name [container] --net host alpine`

O docker possui duas opções de montar volumes: tipo *bind* e tipo *volume*.

* `docker container run -d --mount type=bind,src=/home/sergio/Documentos/site,dst=/usr/share/nginx/html nginx`

Criando um volume:

* `docker volume create labredes`

`docker container run -d --mount type=volume,src=labredes,dst=/usr/share/nginx/html nginx`

Lista o volume criado:

`docker volume ls`

Por padrão, todo volume criado no docker fica em `/var/lib/docker/volumes/[nome_volume]/_data`

Remover todos os containeres parados

`docker container prune`

Criando um container para fazer backup de um volume em outro lugar:

`docker container run -ti --mount type=volume,src=labredes,dst=/site --mount type=bind,src=/home/sergio/Documentos/backup/,dst=/backup debian tar -cvf /backup/site.tar /site`

