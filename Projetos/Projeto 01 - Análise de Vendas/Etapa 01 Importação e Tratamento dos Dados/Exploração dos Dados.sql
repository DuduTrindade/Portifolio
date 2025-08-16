-- Etapa 01: Importação e Tratamento dos Dados

-- Exploração dos Dados

-- ================== Tabela Clientes ================================

-- Verificação da estrutura da tabela
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




-- Padronização do formato campos: Primeiro_Nome e Sobrenome

BEGIN TRANSACTION;

UPDATE Clientes
	SET Primeiro_Nome = UPPER(LEFT(Primeiro_Nome, 1)) + LOWER(SUBSTRING(Primeiro_Nome, 2, LEN(Primeiro_Nome)))

UPDATE Clientes
	SET Sobrenome = UPPER(LEFT(Sobrenome, 1)) + LOWER(SUBSTRING(Sobrenome, 2, LEN(Sobrenome)))

COMMIT;

SELECT TOP 10 * FROM Clientes;





-- Conversão campo data de nascimento

SELECT TOP 15
    Data_Nascimento,
    CONVERT(VARCHAR, Data_Nascimento, 105) AS data_convertida,
    FORMAT(Data_Nascimento, 'dd-MM-yyyy') AS data_formatada
FROM Clientes





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


-- ================== Tabela Devoluções ================================

SELECT TOP (15) 
       [Data_Devolucao]
      ,[Id_Loja]
      ,[SKU]
      ,[Qtde_Devolvida]
      ,[Motivo_Devolucao]
  FROM [Vendas_Nova_Varejo].[dbo].[Devolucoes]




--Identificação de valores ausentes (missing data)

SELECT 
    *
FROM Devolucoes
WHERE
    [Data_Devolucao] IS NULL OR
    [Id_Loja]IS NULL OR
    [SKU]IS NULL OR
    [Qtde_Devolvida]IS NULL OR
    [Motivo_Devolucao]IS NULL;



--Detecteção duplicatas
WITH CTE_Duplicados_Devolucoes AS(
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY Data_Devolucao, Id_Loja,SKU, Qtde_Devolvida, Motivo_Devolucao
                          ORDER BY Data_Devolucao) AS RN
    FROM Devolucoes
)

SELECT
    *
FROM CTE_Duplicados_Devolucoes
WHERE RN > 1;


-- Selecionando
SELECT
    *
FROM Devolucoes
WHERE
    Data_Devolucao = '2022-05-05' AND 
    Id_Loja = 200 AND 
    SKU = 'HL170' AND 
    Qtde_Devolvida = 1 AND
    Motivo_Devolucao = 'Produto com defeito'


-- Apagando
WITH CTE_Duplicados_Devolucoes AS(
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY Data_Devolucao, Id_Loja,SKU, Qtde_Devolvida, Motivo_Devolucao
                          ORDER BY Data_Devolucao) AS RN
    FROM Devolucoes
)

DELETE FROM CTE_Duplicados_Devolucoes
WHERE RN > 1;


-- ================== Tabela Itens ================================

SELECT TOP (15) 
       [Id_Venda]
      ,[Ordem_Compra]
      ,[Data_Venda]
      ,[SKU]
      ,[ID_Cliente]
      ,[Quantidade_Vendida]
  FROM [Vendas_Nova_Varejo].[dbo].[Itens];


-- Identificação de valores ausentes (NULL)
SELECT
    *
FROM Itens
WHERE Id_Venda IS NULL OR
      Ordem_Compra IS NULL OR
      Data_Venda IS NULL OR
      SKU IS NULL OR
      ID_Cliente IS NULL OR
      Quantidade_Vendida IS NULL;


--Detecteção duplicatas
WITH CTE_Duplicados_Itens AS(
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY Id_Venda,  Ordem_Compra, Data_Venda, SKU, ID_Cliente, Quantidade_Vendida
                        ORDER BY Id_Venda) AS RN
    FROM Itens
)
SELECT
    *
FROM CTE_Duplicados_Itens
WHERE RN > 1;




-- ================== Tabela Localidades ================================

SELECT TOP (15) [ID_Localidade]
      ,[Pais]
      ,[Continente]
FROM [Vendas_Nova_Varejo].[dbo].[Localidades]


-- ================== Tabela Lojas ================================

SELECT TOP (10) [ID_Loja]
      ,[Nome_Loja]
      ,[Quantidade_Colaboradores]
      ,[Tipo]
      ,[id_Localidade]
      ,[Gerente_Loja]
      ,[Documento_Gerente]
  FROM [Vendas_Nova_Varejo].[dbo].[Lojas];


-- Identificação de valores ausentes (NULL)

SELECT
    *
FROM Lojas
WHERE ID_Loja IS NULL OR
      Nome_Loja IS NULL OR
      Quantidade_Colaboradores IS NULL OR
      Tipo IS NULL OR
      id_Localidade IS NULL OR
      Gerente_Loja IS NULL OR
      Documento_Gerente IS NULL;

--Detecteção duplicatas
WITH CTE_Duplicado_Lojas AS(
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY ID_Loja, Nome_Loja, Quantidade_Colaboradores, Tipo, id_Localidade,
                            Gerente_Loja, Documento_Gerente ORDER BY Nome_Loja) AS RN
    FROM Lojas
)

SELECT
    *
FROM CTE_Duplicado_Lojas
WHERE RN > 1;












