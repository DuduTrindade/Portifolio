# 📊 Etapa 01 - Importação e Tratamento de Dados

## 1. Introdução e Contexto

Nesta primeira etapa, focamos na **importação, validação e limpeza** dos dados que serão utilizados nas análises subsequentes.

**Objetivos principais:**
- Importar dados de múltiplas fontes CSV
- Realizar análise exploratória (EDA) completa
- Garantir a qualidade dos dados através de tratamentos adequados

**Tecnologias utilizadas:**
- 🛢️ `SQL Server` (SGBDR)
- 📋 `T-SQL` (para scripts de importação e tratamento)

**Escopo do projeto:**
- 7 tabelas relacionadas ao processo de vendas
- Dados históricos de 3 anos
- Processo completo de ETL (Extract, Transform, Load)

## 2. Fontes de Dados

Os dados utilizados neste projeto foram extraídos do sistema ERP da empresa e fornecidos em formato CSV.

**Estrutura de arquivos:**


| Tabela     | Registros| Descrição                     										   | 
|------------|----------|--------------------------------------------------------------------------|
|Clientes    | 18148    |Contém informações cadastrais e demográficas detalhadas de cada clientes. |
|Devoluções  | 1809     |Registra as devoluções dos produtos.
|Itens		 | 56046	|Detalha os itens vendidos em cada venda.
|Localidades | 34		|Armazena informações geográficas das lojas.			
|Lojas		 | 306	    |Contém informações sobre as lojas.
|Produtos	 | 293      |Armazena informações sobre os produtos vendidos.
|Vendas      | 25164    |Registra as vendas realizadas.
       

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


## 5. Exploração Inicial dos dados
A **Análise Exploratória de Dados (EDA** - *Exploratory Data Analysis*) é uma etapa fundamental no tratamento de dados, onde investigamos o conjunto de dados para entender suas características, identificar problemas e preparação para modelagem dos dados.

Técnicas aplicadas:

✅ Verificação de estrutura e tipos de dados

🔍 Identificação de valores ausentes (NULL)

🧹 Detecção e tratamento de duplicatas

📐 Padronização de formatos (datas, textos)

🚨 Identificação de outliers e inconsistências


 ## 5.1 Tabela Clientes

**Descrição:** Armazena informações cadastrais dos clientes da empresa.
~~~sql
-- Verificação da estrutura da tabela
SELECT TOP (20) 
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
  FROM [Vendas_Nova_Varejo].[dbo].[Clientes]
~~~


<div align="center" style="display: inline-block;">
	<img  width="700" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tbClientes.png">
</div>

<br>

**Estrutura principal:**
- `Cliente_ID`: Identificador único do cliente
- `Primeiro_nome`: Nome do cliente
- `Sobrenome`: Sobrenome do cliente
- `Email`:Endereço de e-mail do cliente
- `Genero`:M(Masculino) ou F(Feminino).
- `Data_Nascimento`: Data de nascimento no formato AAAA/MM/AA
- `Estado_Civil`:C(Casado), S(Solteiro)
- `Num_Filhos`:Número de filhos.
- `Nivel_Escolar`:(Ensino Médio Incompleto, Superior Incompleto, Ensino Médio Completo, Pós Graduação e Superior Completo).
- `Documento`:Possivelmente CPF ou RG
- `Id_Localidade`:Código numérico que pode representar cidade, estado ou região


**Problemas Encontrados:**
- ❌Nomes e sobrenomes em CAIXA ALTA
- ❌Formato de data padrão americano
- ❌Possíveis valores nulos ou duplicados

**Ações Tomadas::**

1. Normalização de nomes


>Ao analisar a tabela, identifiquei que as colunas *Primeiro_nome e Sobrenome* estão com todos os caracteres em letras maiúsculas, o que não corresponde ao formato padrão desejado.
>Para corrigir esse problema, utilizarei o comando **UPDATE** na tabela clientes, ajustando os registros para que apenas a primeira letra de cada nome e sobrenome fique em maiúscula, seguindo a convenção adequada.


 ~~~sql
BEGIN TRANSACTION;

UPDATE Clientes
	SET Primeiro_Nome = UPPER(LEFT(Primeiro_Nome, 1)) + LOWER(SUBSTRING(Primeiro_Nome, 2, LEN(Primeiro_Nome)))

UPDATE Clientes
	SET Sobrenome = UPPER(LEFT(Sobrenome, 1)) + LOWER(SUBSTRING(Sobrenome, 2, LEN(Sobrenome)))

COMMIT;

SELECT TOP 15 * FROM Clientes
~~~
<div align="center" style="display: inline-block;">
    <img  width="700" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tbClientes_maiusculo.png">
</div>

<br>

2. Padronização campo data_nascimento

>A coluna *Data_Nascimento* está armazenada no formato padrão *AAAA-MM-DD* (ano-mês-dia), que é o formato nativo do SQL Server para o tipo de dados DATE. Este formato será mantido para permitir operações e cálculos com datas sem conversões.
>Para exibição no formato brasileiro *DD-MM-AAAA* (dia-mês-ano), utilizaremos as funções **CONVERT ou FORMAT** quando necessário, mantendo o armazenamento original.

~~~sql
-- Conversão campo data de nascimento
SELECT TOP 15
    Data_Nascimento,
    CONVERT(VARCHAR, Data_Nascimento, 105) AS data_convertida,
    FORMAT(Data_Nascimento, 'dd-MM-yyyy') AS data_formatada
FROM Clientes

~~~

<div align="center" style="display: inline-block;">
    <img  width="600" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tbClientes_DataNas.png">
</div>
<br>


3. Identificação de campos nulos

>Outra validação que devemos fazer na tabela clientes é de *Identificação de valores ausentes (missing data)*, ou seja, verificar se a tabela possui algum campo com valores nulos.

~~~sql
--Identificação de valores ausentes (missing data)

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
~~~

<div align="center" style="display: inline-block;">
	<img  width="700" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tbClientes_nulos.png">
</div>
<br>

**Resultado**: ✅A tabela Clientes não possui campos com *valores nulos*.
<br>

4. Verificação de Duplicatas

>Dados duplicados podem distorcer nossas análises, por isso devemos realizar *Detecteção de duplicatas*.

~~~sql
--Detecteção duplicatas

WITH CTE_Duplicatas AS(
	SELECT 
		*
		,ROW_NUMBER() OVER(PARTITION BY ID_Cliente, Primeiro_Nome, Sobrenome, Email, Data_Nascimento, Estado_Civil,
                            Num_filhos, Nivel_Escolar, Documento, Id_Localidade
						   ORDER BY ID_Cliente) AS Rn
	FROM Clientes
)
SELECT
	*
FROM CTE_Duplicatas
WHERE Rn > 1;
~~~

<div align="center" style="display: inline-block;">
	<img  width="700" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tbClientes_nulos.png">
</div>

<br>

**Resultado**: ✅A tabela Clientes não possui campos com *valores duplicados*.
<br>

## Resultado final da Tabela Clientes


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

