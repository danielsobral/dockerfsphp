#!/usr/bin/env bash

machine_apache='';
pasta_principal='';
pasta_projeto='';

echo "Qual o nome da pasta de armazenamento raiz do docker?";
read principal;
pasta_principal=$principal
diretorio_atual=$(pwd);

if [ -d $diretorio_atual/$pasta_principal ];
then
        echo "Diretório com o nome $pasta_principal já existe";
	exit 1;
else
        mkdir $diretorio_atual/$pasta_principal;
        echo "Diretório $pasta_principal criado com sucesso";
fi

cd $diretorio_atual/$pasta_principal;

echo "Qual o nome da pasta do seu projeto?"
read projeto
pasta_projeto=$projeto
diretorio_raiz=$(pwd);

if [ -d $diretorio_raiz/$pasta_projeto ];
then
	echo "Diretório com o nome $pasta_projeto já existe";
	exit 1;
else
	mkdir $diretorio_raiz/$pasta_projeto;
	echo "Diretório $pasta_projeto criado com sucesso";
fi

cd $diretorio_raiz/$pasta_projeto;

if [ ! -f $diretorio_raiz/$pasta_projeto/Dockerfile -a ! -f $diretorio_raiz/$pasta_projeto/docker-compose.yml ];
then
        echo "Realizando o download dos arquivos DockerFile e docker-compose.yml";
	git clone https://github.com/danielsobral/dockerfsphp.git && \
	echo "Download concluído!"
	mv $diretorio_raiz/$pasta_projeto/dockerfsphp/* $diretorio_raiz/$pasta_projeto/ && \
	rm -rf $diretorio_raiz/$pasta_projeto/dockerfsphp
fi

mkdir $diretorio_raiz/$pasta_projeto/db_data;
rm $diretorio_raiz/$pasta_projeto/docker-build.sh

echo "==================================================="
echo "==== Iniciando a construção dos containers PHP ===="
echo "==================================================="
sleep 5
docker build . -t danielsobralnascimento/webserver:1.0 && \
docker compose up -d && \
machine_apache=$(docker ps -a | grep '/bin/sh -c' | cut -d " " -f1) && \
docker exec $machine_apache composer create-project --prefer-dist laravel/laravel blog && \
echo "====================================================================="
echo "==== Construção dos containers finalizada #Bora Codar em PHP! :) ===="
echo "====================================================================="
