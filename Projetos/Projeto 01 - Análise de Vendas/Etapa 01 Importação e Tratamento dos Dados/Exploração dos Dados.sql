-- Etapa 01: Importa��o e Tratamento dos Dados

-- Explora��o dos Dados

-- ========= Tabela Clientes

-- Verifica��o da estrutura da tabela
SELECT TOP (10) [ID_Cliente]
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




-- Padroniza��o do formato campos: Primeiro_Nome e Sobrenome

BEGIN TRANSACTION;

UPDATE Clientes
	SET Primeiro_Nome = UPPER(LEFT(Primeiro_Nome, 1)) + LOWER(SUBSTRING(Primeiro_Nome, 2, LEN(Primeiro_Nome)))

UPDATE Clientes
	SET Sobrenome = UPPER(LEFT(Sobrenome, 1)) + LOWER(SUBSTRING(Sobrenome, 2, LEN(Sobrenome)))

COMMIT;

SELECT TOP 10 * FROM Clientes;


-- Convers�o campo data de nascimento
SELECT TOP 15
    Data_Nascimento,
    CONVERT(VARCHAR, Data_Nascimento, 105) AS data_convertida,
    FORMAT(Data_Nascimento, 'dd-MM-yyyy') AS data_formatada
FROM Clientes


--Identifica��o de valores ausentes (missing data)

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


--Detecte��o duplicatas

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


-- Tabela Devolu��es

SELECT TOP (15) [Data_Devolucao]
      ,[Id_Loja]
      ,[SKU]
      ,[Qtde_Devolvida]
      ,[Motivo_Devolucao]
  FROM [Vendas_Nova_Varejo].[dbo].[Devolucoes]



