<h1>📥Etapa 01 - Importação e Tratamento dos Dados</h1> 

Os dados que utilizaremos estão dispostos em formato de arquivos csv extraídos do sistema da empresa. Esses dados serão importados para dentro do SQL Server, aonde realizarei toda a parte de tratamento e limpeza dos dados. Aqui está o <a href="https://github.com/DuduTrindade/Portifolio/tree/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/dados">Link</a> dos arquivos.

Os arquivos são compostos pelas seguintes tabelas:

<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tb.png">
</div>



O primeiro passo antes da importação dos dados é a criação do banco de dados no SQL Server. Para este projeto, o banco foi nomeado como Vendas_Nova_Varejo. Em seguida, prosseguimos com a criação das tabelas utilizando o comando **CREATE TABLE** nome_tabela, onde cada tabela é estruturada de acordo com os dados a serem importados.

Para importar os dados dos arquivos CSV para dentro das tabelas do banco, utilizarei o comando **BULK INSERT**.

Esse comando é usado para importar dados de arquivos externos (como .csv, .txt, etc.) diretamente para uma tabela do banco de dados de forma rápida e eficiente.


Aqui está o <a href="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/Importacao%20dos%20Dados.sql">Link</a> do script de importação dos dados:

<div align="center" style="display: inline-block;">
	<img  width="700" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tb_import.png">
</div>

~~~sql
-- 1 Passo: Criação do banco de dados

CREATE DATABASE Vendas_Nova_Varejo COLLATE Latin1_General_CI_AS;

USE Vendas_Nova_Varejo;

-- 2 Passo: Criação das tabelas e Importação dos arquivos csv 

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

BULK INSERT Clientes
FROM 'C:\Users\Edutr\OneDrive\Área de Trabalho\dados\Clientes.csv'
WITH (
    FORMAT = 'CSV',              -- A partir do SQL Server 2022 (opcional)
    FIRSTROW = 2,                -- Ignora o cabeçalho
    FIELDTERMINATOR = ';',       -- Delimitador de colunas
    ROWTERMINATOR = '\n',        -- Delimitador de linhas
    CODEPAGE = '65001',          -- Suporte a UTF-8
    TABLOCK
);

-- Tabela Devolução
CREATE TABLE Devolucoes(
     Data_Devolucao     DATE 
    ,Id_Loja            SMALLINT    
    ,SKU                NVARCHAR(10) 
    ,Qtde_Devolvida     SMALLINT 
    ,Motivo_Devolucao   NVARCHAR(50)     
);

BULK INSERT Devolucoes
FROM 'C:\Users\Edutr\OneDrive\Área de Trabalho\dados\Devolucoes.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
);

-- Tabela Itens

CREATE TABLE Itens(
     Id_Venda               NVARCHAR(10)
    ,Ordem_Compra           TINYINT
    ,Data_Venda             DATE
    ,SKU                    NVARCHAR(5)
    ,ID_Cliente             SMALLINT
    ,Quantidade_Vendida     TINYINT
     PRIMARY KEY(Id_Venda,Ordem_Compra)
);

BULK INSERT Itens
FROM 'C:\Users\Edutr\OneDrive\Área de Trabalho\dados\Itens.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
);

-- Tabela Localidades
CREATE TABLE Localidades(
     ID_Localidade   TINYINT 
    ,Pais            NVARCHAR(30)
    ,Continente      NVARCHAR(30)
);

BULK INSERT Localidades
FROM 'C:\Users\Edutr\OneDrive\Área de Trabalho\dados\Localidades.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
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

BULK INSERT Lojas
FROM 'C:\Users\Edutr\OneDrive\Área de Trabalho\dados\Lojas.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
);

-- Tabela Produtos
CREATE TABLE Produtos(
    SKU               NVARCHAR(5) 
   ,Produto           NVARCHAR(60)
   ,Marca             NVARCHAR(30)
   ,Tipo_Produto      NVARCHAR(30)    
   ,Preco_Unitario    DECIMAL(10,2)
   ,Custo_Unitario    DECIMAL(10,2)
   ,Observacao        NVARCHAR(100)
);

BULK INSERT Produtos
FROM 'C:\Users\Edutr\OneDrive\Área de Trabalho\dados\Produtos.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
);


-- Tabela Vendas

CREATE TABLE Vendas(
     Id_Venda      NVARCHAR(10) 
    ,Data_Venda    DATE
    ,ID_Cliente    SMALLINT
    ,ID_Loja       SMALLINT
);

BULK INSERT Vendas
FROM 'C:\Users\Edutr\OneDrive\Área de Trabalho\dados\Vendas.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
);




## Exploração Inicial dos dados

## Tratamento dos dados
Agora iremos verificar como os dados estão dispostos em cada tabela do banco de dados. Trataremos os seguintes pontos:


- Identificação de duplicatas
- Padronização de formatos (datas)
- Identificação dos valores ausentes (nulos)
- Correção de erros e inconsistências