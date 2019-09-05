#!/bin/bash

echo " 
ID	NOME
1	CASHIER - IBIS
2	Compr. Bancários
3	Pro Juris
4	NFCE - IBIS - IMP.
5	TESOURARIA - SFA
6	NFS EMAIL - SAND.
7	Ordem Compra
8	Disciplina Atrasada
9	Email Chamados
10	APP % - NOVA
11	NFS - IBIS - NDD
12	NFCE - IBIS - INTEG.
13	IMPORTAÇÃO CARTÃO
14	GERAÇÃO BOLETO


"

read -e -p "API Host: " -i "http://172.29.10.6:8800" HOST

read -p "ID's dos serviços(separados por espaço | 0-todos): "  ids

read -e -p "Opção (1-Ativar | 0-Desativar): " -i "1" op

if [ "$ids" -eq "0" ]
then

	if [ "$op" -eq "1" ]
	then
		curl -X PUT "$HOST/parametros-integracao/servicos/ativar"
	elif [ "$op" -eq "0" ]
	then
		curl -X PUT "$HOST/parametros-integracao/servicos/desativar"
	fi

else

	IFS=', ' read -r -a idArray <<< "$ids"

	for id in "${idArray[@]}"
	do
		curl -X PUT "$HOST/parametros-integracao/servicos/situacao?id=$id&situacao=$op"
	done

fi

