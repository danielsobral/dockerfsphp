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

machine_apache=$(docker ps -a | grep '/bin/sh -c' | cut -d " " -f1);
