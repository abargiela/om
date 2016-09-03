# OpenMeetings

### Instale o docker

[https://docs.docker.com/engine/installation/](https://docs.docker.com/engine/installation/)

### Instale o docker-compose

```
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
```

```
 chmod +x /usr/local/bin/docker-compose
 ```


## Clone o repositório
```
git clone git@github.com:abargiela/om.git
```
Caso não tenha o git, baixe o pacote pela opção de "Download ZIP"


## Buildando o openmeetings

Acesse o diretório openmeetings

```
cd openmeetings
```

```
docker-compose build
```
```
docker-compose up
```

## Setup Inicial

Acesso no navegador o ip da sua interface(geralmente eth0, exemplo):

http://10.110.128.100:5080/openmeetings/install

Click em next

## IMPORTANTE DEIXAR A CONFIG CONFORME ABAIXO
```
choose DB Type: MySQL
Specify DB host: openmeetings_mariadb_1 (IMPORTANTE QUE SEJA EXATAMENTE ASSIM)
Specify DB port: 3306
Specify the name of the database: open311
Specify DB user: hola
Specify DB Password: 123456
```

Após terminar o setup, não necessita reiniciar a app, basta acessar:

[http://10.110.128.100:5080/openmeetings/](http://10.110.128.100:5080/openmeetings/)

PS.: Trocar para seu IP local
