
-- Etapa 01: Importação e Tratamento dos Dados

--  ============  IMPORTANDO OS DADOS ===================

-- 1 Passo: Criação do banco de dados

CREATE DATABASE Vendas_Nova_Varejo COLLATE Latin1_General_CI_AS;

USE Vendas_Nova_Varejo;

-- 2 Passo: Criação das tabelas e Importação dos arquivos csv 

--- Tabela Clientes
CREATE TABLE Clientes(
     ID_Cliente         SMALLINT PRIMARY KEY
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
FROM 'C:\Caminho\Para\Arquivo\Clientes.csv'
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
FROM 'C:\Caminho\Para\Arquivo\Devoluções.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
);

-- Adiciona uma nova coluna Id_Devolucao como chave primária
ALTER TABLE Devolucoes
    ADD Id_Devolucao SMALLINT PRIMARY KEY IDENTITY(1,1);


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
FROM 'C:\Caminho\Para\Arquivo\Itens.csv'
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
     ID_Localidade   TINYINT PRIMARY KEY
    ,Pais            NVARCHAR(30)
    ,Continente      NVARCHAR(30)
);

BULK INSERT Localidades
FROM 'C:\Caminho\Para\Arquivo\Localidades.csv'
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
     ID_Loja                    SMALLINT PRIMARY KEY
    ,Nome_Loja                  NVARCHAR(40)
    ,Quantidade_Colaboradores   SMALLINT
    ,Tipo                       NVARCHAR(20)
    ,id_Localidade              TINYINT
    ,Gerente_Loja               NVARCHAR(20)
    ,Documento_Gerente          NVARCHAR(20)
);

BULK INSERT Lojas
FROM 'C:\Caminho\Para\Arquivo\Lojas.csv'
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
    SKU               NVARCHAR(5) PRIMARY KEY
   ,Produto           NVARCHAR(60)
   ,Marca             NVARCHAR(30)
   ,Tipo_Produto      NVARCHAR(30)    
   ,Preco_Unitario    DECIMAL(10,2)
   ,Custo_Unitario    DECIMAL(10,2)
   ,Observacao        NVARCHAR(100)
);

BULK INSERT Produtos
FROM 'C:\Caminho\Para\Arquivo\Produtos.csv'
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
     Id_Venda      NVARCHAR(10) PRIMARY KEY
    ,Data_Venda    DATE
    ,ID_Cliente    SMALLINT
    ,ID_Loja       SMALLINT
);

BULK INSERT Vendas
FROM 'C:\Caminho\Para\Arquivo\Vendas.csv'
WITH (
    FORMAT = 'CSV',              
    FIRSTROW = 2,                
    FIELDTERMINATOR = ';',       
    ROWTERMINATOR = '\n',        
    CODEPAGE = '65001',          
    TABLOCK
);



-- ================  TRATAMENTO DOS DADOS ========================

-- Verificar dados duplicados

SELECT TOP (100) 
       [ID_Cliente]
      ,[Primeiro_Nome]
      ,[Sobrenome]
      ,[Email]
      ,[Genero]
      ,[Data_Nascimento]
      ,[Estado_Civil]
      ,[Num_Filhos]
      ,[Nivel_Escolar]
      ,[Documento]
      ,[Id_Localidade]
  FROM [Vendas_Nova_Varejo].[dbo].[Clientes];


WITH CTE_Duplicatas AS(
	SELECT 
		*
		,ROW_NUMBER() OVER(PARTITION BY ID_Cliente, Primeiro_Nome, Sobrenome, Email, Data_Nascimento									
						   ORDER BY ID_Cliente) AS Rn
	FROM Clientes
)
SELECT
	*
FROM CTE_Duplicatas
WHERE Rn > 1;








-- Verificar valores nulos


SELECT
    *
FROM Clientes
WHERE 
    ID_Cliente      IS NULL OR
    Primeiro_Nome   IS NULL OR
    Sobrenome       IS NULL OR
    Email           IS NULL OR
    Genero          IS NULL OR
    Data_Nascimento IS NULL OR
    Estado_Civil    IS NULL OR
    Num_Filhos      IS NULL OR
    Nivel_Escolar   IS NULL OR
    Documento       IS NULL OR
    Id_Localidade   IS NULL;


-- Remover Espaços vazios

BEGIN TRANSACTION;

UPDATE Clientes
    SET Primeiro_Nome   = TRIM(Primeiro_Nome),
        Sobrenome       = TRIM(Sobrenome),     
        Email           = TRIM(Email),          
        Genero          = TRIM(Genero),         
        Estado_Civil    = TRIM(Estado_Civil),      
        Nivel_Escolar   = TRIM(Nivel_Escolar),  
        Documento       = TRIM(Documento);



-- Validação dos tipos dos dados

SELECT 
    column_name AS 'Nome da Coluna',
    data_type AS 'Tipo de Dado'
FROM 
    information_schema.columns
WHERE 
    table_name = 'Clientes'
    AND table_schema NOT IN ('information_schema', 'pg_catalog')
ORDER BY 
    ordinal_position;






