# 📊 Etapa 01 - Importação e Tratamento de Dados

## 1. Introdução e Contexto

Nesta primeira etapa, focamos na **importação, validação e limpeza** dos dados que serão utilizados nas análises subsequentes.

**Objetivos principais:**
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


**Metadados das tabelas:**

| Tabela       | Registros| Descrição                     | Chave Primária   |
|--------------|----------|-------------------------------|------------------|
| Clientes     | 1.5k     | Cadastro de clientes          | Cliente_ID       |
| Devoluções   | 200      | Registro de devoluções        | Devolucao_ID     |
| [...]        | [...]    | [...]                        | [...]           |


## 3. Criação do Banco de Dados

### 3.1 Modelagem Inicial
Antes da importação, criei a estrutura do banco de dados no SQL Server com o nome `Vendas_Nova_Varejo`, seguindo um modelo relacional que reflete o negócio:

~~~sql
CREATE DATABASE Vendas_Nova_Varejo COLLATE Latin1_General_CI_AS;
GO

USE Vendas_Nova_Varejo;
GO

~~~

### 3.2 Scripts de Criação de Tabelas

Para cada tabela, criei a estrutura com os tipos de dados apropriados:
~~~sql
--- Tabela Clientes
CREATE TABLE Clientes(
     ID_Cliente         SMALLINT 
    ,Primeiro_Nome      NVARCHAR(30) 
    ,Sobrenome          NVARCHAR(30) 
    ,Email              NVARCHAR(40) 
    ,Genero             NCHAR(1) CHECK(Genero IN('M', 'F')) 
    ,Data_Nascimento    DATE 
    ,Estado_Civil       NCHAR(1) CHECK(Estado_Civil IN('C', 'S')) 
    ,Num_Filhos         TINYINT 
    ,Nivel_Escolar      NVARCHAR(40) 
    ,Documento          NVARCHAR(20) 
    ,Id_Localidade      TINYINT 
);

-- Tabela Devolução
CREATE TABLE Devolucoes(
     Data_Devolucao     DATE 
    ,Id_Loja            SMALLINT    
    ,SKU                NVARCHAR(10) 
    ,Qtde_Devolvida     SMALLINT 
    ,Motivo_Devolucao   NVARCHAR(50)     
);

CREATE TABLE Itens(
     Id_Venda               NVARCHAR(10)
    ,Ordem_Compra           TINYINT
    ,Data_Venda             DATE
    ,SKU                    NVARCHAR(5)
    ,ID_Cliente             SMALLINT
    ,Quantidade_Vendida     TINYINT
     PRIMARY KEY(Id_Venda,Ordem_Compra)
);

CREATE TABLE Localidades(
     ID_Localidade   TINYINT 
    ,Pais            NVARCHAR(30)
    ,Continente      NVARCHAR(30)
);

-- Tabela Lojas
CREATE TABLE Lojas(
     ID_Loja                    SMALLINT 
    ,Nome_Loja                  NVARCHAR(40)
    ,Quantidade_Colaboradores   SMALLINT
    ,Tipo                       NVARCHAR(20)
    ,id_Localidade              TINYINT
    ,Gerente_Loja               NVARCHAR(20)
    ,Documento_Gerente          NVARCHAR(20)
);

CREATE TABLE Produtos(
    SKU               NVARCHAR(5) 
   ,Produto           NVARCHAR(60)
   ,Marca             NVARCHAR(30)
   ,Tipo_Produto      NVARCHAR(30)    
   ,Preco_Unitario    DECIMAL(10,2)
   ,Custo_Unitario    DECIMAL(10,2)
   ,Observacao        NVARCHAR(100)
);


CREATE TABLE Vendas(
     Id_Venda      NVARCHAR(10) 
    ,Data_Venda    DATE
    ,ID_Cliente    SMALLINT
    ,ID_Loja       SMALLINT
);
~~~

## 4. Importação dos Dados

### 4.1 Método de Importação
Utilizei o comando `BULK INSERT` do SQL Server por ser:
- Eficiente para grandes volumes de dados
- Permite controle preciso sobre o formato dos arquivos
- Execução rápida comparada a métodos alternativos

### 4.2 Processo de Carga
Para cada tabela, executei um comando similar a:

~~~sql
BULK INSERT Clientes
FROM 'C:\caminho\Clientes.csv'
WITH (
    FORMAT = 'CSV',              -- A partir do SQL Server 2022 (opcional)
    FIRSTROW = 2,                -- Ignora o cabeçalho
    FIELDTERMINATOR = ';',       -- Delimitador de colunas
    ROWTERMINATOR = '\n',        -- Delimitador de linhas
    CODEPAGE = '65001',          -- Suporte a UTF-8
    TABLOCK
);

BULK INSERT Devolucoes
FROM 'C:\caminho\Devolucoes.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
);

BULK INSERT Itens
FROM 'C:\caminho\Itens.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
);

BULK INSERT Localidades
FROM 'C:\caminho\Localidades.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
);

BULK INSERT Lojas
FROM 'C:\caminho\Lojas.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
);

BULK INSERT Produtos
FROM 'C:\caminho\Produtos.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
);

BULK INSERT Vendas
FROM 'C:\caminho\Vendas.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
);

~~~


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
