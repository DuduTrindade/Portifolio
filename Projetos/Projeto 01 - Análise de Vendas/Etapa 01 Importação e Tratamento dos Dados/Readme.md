# 📊 Análise de Vendas - Importação e Tratamento de Dados

## 1. Introdução e Contexto

Este projeto faz parte de uma análise completa de dados de vendas de uma rede varejista. Nesta primeira etapa, focamos na **importação, validação e limpeza** dos dados que serão utilizados nas análises subsequentes.

**Objetivos principais:**
- Estruturar um banco de dados relacional no SQL Server
- Importar dados de múltiplas fontes CSV
- Realizar análise exploratória (EDA) completa
- Garantir a qualidade dos dados através de tratamentos adequados

**Tecnologias utilizadas:**
- 🛢️ SQL Server (SGBDR)
- 📋 T-SQL (para scripts de importação e tratamento)

**Escopo do projeto:**
- 7 tabelas relacionadas ao processo de vendas
- Dados históricos de 3 anos
- Processo completo de ETL (Extract, Transform, Load)

## 2. Fontes de Dados

Os dados utilizados neste projeto foram extraídos do sistema ERP da empresa e fornecidos em formato CSV, contendo:

**Estrutura de arquivos:**

<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tb.png">
</div>

Os dados que utilizaremos estão dispostos em formato de arquivos csv extraídos do sistema da empresa. Esses dados serão importados para dentro do SQL Server, aonde realizarei toda a parte de tratamento e limpeza dos dados. Aqui está o <a href="https://github.com/DuduTrindade/Portifolio/tree/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/dados">Link</a> dos arquivos.






O primeiro passo antes da importação dos dados é a criação do banco de dados no SQL Server. Para este projeto, o banco foi nomeado como Vendas_Nova_Varejo. Em seguida, prosseguimos com a criação das tabelas utilizando o comando **CREATE TABLE** nome_tabela, onde cada tabela é estruturada de acordo com os dados a serem importados.

Para importar os dados dos arquivos CSV para dentro das tabelas do banco, utilizarei o comando **BULK INSERT**.

Esse comando é usado para importar dados de arquivos externos (como .csv, .txt, etc.) diretamente para uma tabela do banco de dados de forma rápida e eficiente.


Aqui está o <a href="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/Importacao%20dos%20Dados.sql">Link</a> do script de importação dos dados:

<div align="center" style="display: inline-block;">
	<img  width="700" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tb_import.png">
</div>


## Exploração Inicial dos dados
A **Análise Exploratória de Dados (EDA** - *Exploratory Data Analysis*) é uma etapa fundamental no tratamento de dados, onde investigamos o conjunto de dados para entender suas características, identificar problemas e preparação para modelagem dos dados.

Passos a serem executados:

- ✅Verificação dos dados 

- ✅Identificação de valores ausentes (missing data). 

- ✅Detecteção duplicatas 

- ✅Padronização de datas, textos (uppercase/lowercase)

- ✅Limpeza de Espaços e Caracteres Inválidos


 ## Tabela Clientes


<div align="center" style="display: inline-block;">
	<img  width="700" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c1.png">
</div>

<br>

Ao analisar a tabela, identifiquei que as colunas *Primeiro_nome e Sobrenome* estão com todos os caracteres em letras maiúsculas, o que não corresponde ao formato padrão desejado.

Para corrigir esse problema, utilizarei o comando **UPDATE** na tabela clientes, ajustando os registros para que apenas a primeira letra de cada nome e sobrenome fique em maiúscula, seguindo a convenção adequada.

<div align="center" style="display: inline-block;">
	<img  width="700" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tb_clientes_nome_sobrenome_update.png">
</div>

<br>

A coluna *Data_Nascimento* está armazenada no formato padrão *AAAA-MM-DD* (ano-mês-dia), que é o formato nativo do SQL Server para o tipo de dados DATE. Este formato será mantido para Permitir operações e cálculos com datas sem conversões.
Para exibição no formato brasileiro *DD-MM-AAAA* (dia-mês-ano), utilizaremos a função **CONVERT** quando necessário, mantendo o armazenamento original.


<br>

Outra validação que devemos fazer na tabela clientes é de *Identificação de valores ausentes (missing data)*, ou seja, verificar se a tabela possui algum campo com valores nulos.

<div align="center" style="display: inline-block;">
	<img  width="550" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tb_clientes_nulo.png">
</div>

<br>

***Resultado***: A tabela Clientes não possui campos com *valores nulos*.

<br>

Dados duplicados podem distorcer nossas análises, por isso devemos realizar *Detecteção de duplicatas*.

<div align="center" style="display: inline-block;">
	<img  width="600" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tb_clientes_duplicado.png">
</div>

<br>

***Resultado***: A tabela Clientes não possui campos com *valores duplicados*.

Limpeza de Espaços e Caracteres Inválidos



## **Tabela Devoluções**

<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c2.png">
</div>

## **Tabela Itens**
<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c3.png">
</div>

## **Tabela Localidades**
<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c4.png">
</div>

## **Tabela Lojas**
<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c5.png">
</div>

## **Tabela Produtos**
<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c6.png">
</div>

## **Tabela Vendas**
<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c7.png">
</div>

## Limpeza dos dados
Agora iremos verificar como os dados estão dispostos em cada tabela do banco de dados. Trataremos os seguintes pontos:


- Tratamento de dados ausentes: Remoção ou preenchimento (imputação por média, mediana ou algoritmos).

- Correção de inconsistências: Padronização de datas, textos (uppercase/lowercase), unidades de medida.

- Remoção de duplicatas e dados irrelevantes.

- Filtragem de outliers (quando necessário).
