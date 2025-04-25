
-- limpeza.sql
-- Etapas de limpeza e tratamento de dados no SQL Server

-- 1. Criação do banco de dados e da tabela
CREATE DATABASE Vendas
COLLATE Latin1_General_CI_AS;

--Criando a tabela
CREATE TABLE Vendas_fatura(
	Num_Fatura VARCHAR(20),
	Data_Fatura VARCHAR(40),
	Id_Cliente VARCHAR(20),
	Pais VARCHAR(50),
	Quantidade VARCHAR(20),
	Valor VARCHAR(20)
)

-- Código para importar os dados do arquivo csv para a tabela Vendas_fatura

BULK INSERT Vendas_fatura
FROM 'C:\Users\Edutr\OneDrive\Documentos\SQL Server Management Studio\vendas-por-fatura.csv'
WITH (
    FORMAT = 'CSV',              -- A partir do SQL Server 2022 (opcional)
    FIRSTROW = 2,                -- Ignora o cabeçalho
    FIELDTERMINATOR = ',',       -- Delimitador de colunas
    ROWTERMINATOR = '\n',        -- Delimitador de linhas
    CODEPAGE = '65001',          -- Suporte a UTF-8
    TABLOCK
);
sp_help Vendas_fatura_backup

-- 2. Backup da tabela original
SELECT * 
	INTO Vendas_fatura_Backup
FROM Vendas_fatura;


-- 3. Remoção de duplicatas
-- 3.1. Identificando dados Duplicados
WITH CTE_Diplicados AS (
	SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY Num_fatura, Data_fatura, Id_cliente,
						 Pais, Quantidade, Valor ORDER BY Data_fatura) AS rn
	FROM Vendas_fatura
) 
SELECT
	*
FROM CTE_Diplicados
WHERE rn > 1


-- 3.2.	Remoção de duplicatas

WITH CTE_Duplicados AS (
	SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY Num_fatura, Data_fatura, Id_cliente,
						 Pais, Quantidade, Valor ORDER BY Data_fatura) AS Row_num
	FROM Vendas_fatura
) 
DELETE 
FROM CTE_Duplicados
WHERE Row_num > 1

-- 4. Remoção de registros com valores nulos em ID_Cliente

-- 4.1 Verificar linhas com dados ausentes

SELECT 
	* 
FROM Vendas_fatura
WHERE Num_Fatura IS NULL OR
	 Data_Fatura IS NULL OR
	 Id_Cliente IS NULL OR
	 Pais IS NULL OR
	 Quantidade IS NULL OR
	 Valor IS NULL


-- 4.2 Apagando linhas nulas/vazias

DELETE 
FROM Vendas_fatura
WHERE Id_Cliente IS NULL;


-- 5. Remoção de valores negativos

-- 5.1 Coluna Valor
UPDATE Vendas_fatura
SET Valor = REPLACE(Valor, '-', '')
WHERE Valor LIKE '-%'

-- 5.2 Coluna Quantidade
UPDATE Vendas_fatura
SET Quantidade = REPLACE(Quantidade, '-', '')
WHERE Quantidade LIKE '-%'




-- 6. Limpeza da coluna Num_fatura

UPDATE Vendas_fatura
SET Num_Fatura = REPLACE(Num_Fatura, 'C', '')
WHERE Num_Fatura LIKE 'C%';


-- 7. Separação da data e hora da coluna Data_fatura

-- 7.1 Criar uma nova coluna para horas
ALTER TABLE Vendas_fatura
	ADD Hora_fatura VARCHAR(20);

-- 7.2 Hora da fatura
UPDATE Vendas_fatura
SET Hora_fatura = CONVERT(VARCHAR,SUBSTRING(Data_fatura, CHARINDEX(' ', Data_fatura), 9), 108)

-- 7.3 Data da fatura
UPDATE Vendas_fatura
SET Data_fatura = SUBSTRING(Data_fatura, 1,CHARINDEX(' ',Data_fatura))



-- 8. Padronização dos tipos de dados

SELECT * FROM Vendas_fatura

ALTER TABLE Vendas_fatura
	ALTER COLUMN Num_fatura INT;

ALTER TABLE Vendas_fatura
	ALTER COLUMN Data_fatura VARCHAR(20);

ALTER TABLE Vendas_fatura
	ALTER COLUMN Id_Cliente INT;

ALTER TABLE Vendas_fatura
	ALTER COLUMN Pais VARCHAR(40);

ALTER TABLE Vendas_fatura
	ALTER COLUMN Quantidade INT;

UPDATE Vendas_fatura
SET Valor = REPLACE(Valor, ',', '.')

ALTER TABLE Vendas_fatura
	ALTER COLUMN Valor FLOAT;

ALTER TABLE Vendas_fatura
	ALTER COLUMN Hora_fatura VARCHAR(20);




BEGIN TRANSACTION
ROLLBACK
COMMIT;






