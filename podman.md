Mapear a pasta atual para dentro do nginx:

`# podman run -d --name site -p 8080:80 --volume="$PWD:/usr/share/nginx/html:Z" nginx`

