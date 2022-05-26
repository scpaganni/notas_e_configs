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

#### Exemplos de Dockerfile

```
# Instalação do Apache 
FROM debian

RUN apt-get update && apt-get install -y apache2 && apt-get clean
ENV APACHE_LOCK_DIR="/var/lock"
ENV APACHE_PID_FILE="/var/run/apache2.pid"
ENV APACHE_RUN_USER="www-data"
ENV APACHE_RUN_GROUP="www-data"
ENV APACHE_LOG_DIR="/var/log/apach2"

COPY /site/. /var/www/html

LABEL description="WebServer"

WORKDIR /var/www/html

VOLUME /var/www/html
EXPOSE 80

ENTRYPOINT ["/usr/sbin/apachectl"]
CMD ["-D", "FOREGROUND"]
```

Criando um registry local

`docker container run -d -p 5000:5000 --name registry registry:2`

Colocando tag no container

`docker image tag apache localhost:5000/myapache:1.0`

Salvando a imagem do apache em um registry local

` docker image push localhost:5000/myapache:1.0 `

Para recuperar a imagem salva

` docker image pull localhost:5000/myapache:1.0`

