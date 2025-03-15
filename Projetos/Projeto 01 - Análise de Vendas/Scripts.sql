
USE Analise_Vendas;


-- Pergunta 1: Qual é a distribuição de clientes por gênero em cada faixa etária?

/*
Faixas etárias usadas na distribuição:
[1]	0-17 anos
[2]	18-25 anos
[3]	26-35 anos
[4]	36-45 anos
[5]	46-55 anos
[6]	56-65 anos
[7]	66 anos ou mais
*/
-- CTE para calcular qual é a distribuição de clientes por gênero em cada faixa etária
WITH CTE_Distribuicao_Genero (Genero, Faixa_Etaria)
AS
(
	SELECT 
		Genero,
		-- Calcula a faixa etária com base na diferença de anos entre a data de nascimento e a data atual.
		CASE 
			WHEN  DATEDIFF(YEAR, Data_Nascimento, GETDATE()) <= 17 THEN 1
			WHEN  DATEDIFF(YEAR, Data_Nascimento, GETDATE()) BETWEEN 18 AND 25 THEN 2
			WHEN  DATEDIFF(YEAR, Data_Nascimento, GETDATE()) BETWEEN 26 AND 35 THEN 3
			WHEN  DATEDIFF(YEAR, Data_Nascimento, GETDATE()) BETWEEN 36 AND 45 THEN 4
			WHEN  DATEDIFF(YEAR, Data_Nascimento, GETDATE()) BETWEEN 46 AND 55 THEN 5
			WHEN  DATEDIFF(YEAR, Data_Nascimento, GETDATE()) BETWEEN 56 AND 65 THEN 6
			ELSE  7
		END Faixa_Etaria
	FROM Clientes
)
SELECT
	Genero,
	CASE
		WHEN Faixa_Etaria = 1 THEN '0-17'  -- Faixa 1 corresponde ao intervalo '0-17 anos'.
		WHEN Faixa_Etaria = 2 THEN '18-25' -- Faixa 2 corresponde ao intervalo '18-25 anos'.
		WHEN Faixa_Etaria = 3 THEN '26-35' -- Faixa 3 corresponde ao intervalo '26-35 anos'.
		WHEN Faixa_Etaria = 4 THEN '36-45' -- Faixa 4 corresponde ao intervalo '36-45 anos'.
		WHEN Faixa_Etaria = 5 THEN '46-55' -- Faixa 5 corresponde ao intervalo '46-55 anos'.
		WHEN Faixa_Etaria = 6 THEN '56-65'  -- Faixa 6 corresponde ao intervalo '56-65 anos'.
		ELSE '66+'						 -- Faixa 7 corresponde ao intervalo '66 anos ou mais'.
	END	Faixa_Etaria,
	COUNT(Faixa_Etaria) AS Total_Genero
FROM CTE_Distribuicao_Genero
GROUP BY Faixa_Etaria, Genero
ORDER BY Faixa_Etaria, Total_Genero DESC;




-- Pergunta 2: Distribuição Geográfica de Clientes?

SELECT 
	L.Continente,	
	L.País,	
	COUNT(C.ID_Cliente) AS Total_Clientes,
	SUM(COUNT(C.ID_Cliente)) OVER(PARTITION BY L.Continente) AS Total_Continente
FROM Clientes C INNER JOIN Localidades L ON C.Id_Localidade = L.Id_Localidade
GROUP BY L.País, L.Continente
ORDER BY L.Continente, Total_Clientes DESC;



--Pergunta 3: Qual é o motivo de devolução mais comum?

SELECT 
	Motivo_Devolucao,
	COUNT(*) AS Qtde_Totais_Devolucao
FROM Devolucoes
GROUP BY Motivo_Devolucao
ORDER BY Qtde_Totais_Devolucao DESC;




--Pergunta 4: Qual é a taxa de devolução por produto?

-- View para calcular a taxa de devolução 

CREATE VIEW vw_Taxa_Devolucao_Produtos AS
	-- -- CTE para calcular o total de devoluções por produto
	WITH Devolucoes_Totais AS (
		SELECT
			D.SKU,
			SUM(D.Qtd_Devolvida) AS Totais_Devolucao
		FROM Devolucoes D 
		GROUP BY D.SKU
	),

	-- CTE para calcular o total de vendas por produto
	Vendas_Totais AS (
		SELECT
			I.SKU,
			SUM(I.Qtd_Vendida) AS Total_Vendido
		FROM Itens I INNER JOIN Vendas V ON V.Id_Venda = I.Id_Venda
		GROUP BY I.SKU
	)

	
	SELECT 
		P.Produto AS Produto,
		P.Tipo_Produto AS Tipo_Produto,
		P.Marca AS Marca,
		VT.Total_Vendido AS Total_Vendido,
		DT.Totais_Devolucao AS Totais_Devolucao,
		(DT.Totais_Devolucao * 100.0 / VT.Total_Vendido) AS [Taxa_Devolucao%]
	FROM Produtos P 
	INNER JOIN Vendas_Totais VT ON P.SKU = VT.SKU
	INNER JOIN Devolucoes_Totais DT ON DT.SKU = P.SKU
	GROUP BY P.Produto, P.Tipo_Produto, P.Marca, VT.Total_Vendido, DT.Totais_Devolucao;


SELECT 
	* 
FROM vw_Taxa_Devolucao_Produtos
ORDER BY [Taxa_Devolucao%] DESC;



-- Calcular o percentual total da taxa de devolução de produtos por tipo_produto

SELECT
		Tipo_Produto,		
		SUM(Totais_Devolucao) / SUM(Total_Vendido) * 100
		[Taxa_Devolucao%]
FROM vw_Taxa_Devolucao_Produtos
GROUP BY Tipo_Produto
ORDER BY [Taxa_Devolucao%] DESC


-- Calcular o percentual total da taxa de devolução de produtos por Marca

SELECT
		Marca,		
		SUM(Totais_Devolucao) / SUM(Total_Vendido) * 100
		[Taxa_Devolucao%]
FROM vw_Taxa_Devolucao_Produtos
GROUP BY Marca 
ORDER BY [Taxa_Devolucao%] DESC


-- Pergunta 5: Produtos Mais Vendidos

-- TOP 10 Produtos mais vendidos
 SELECT TOP 10
	DENSE_RANK() OVER(ORDER BY SUM(I.Qtd_Vendida * P.Preço_Unitario) DESC) AS [Rank],
	I.SKU,
	P.Produto AS Nome,
	SUM(I.Qtd_Vendida * P.Preço_Unitario) AS Total_Vendido
FROM Produtos P INNER JOIN Itens I ON P.SKU = I.SKU
GROUP BY I.SKU, P.Produto	
ORDER BY Total_Vendido DESC;


-- Pergunta 6: Análise Temporal de Vendas.

-- CTE para calcular o total de vendas por: ano e mês
WITH CTE_Vendas AS (
SELECT
	YEAR(V.Data_Venda) AS Ano,	
	MONTH(V.Data_Venda) AS Mes,
	SUM(I.Qtd_Vendida * P.Preço_Unitario) AS Vendas_Mes	
FROM Vendas V INNER JOIN Itens I ON V.Id_Venda = I.Id_Venda
INNER JOIN Produtos P ON P.SKU = I.SKU
GROUP BY YEAR(V.Data_Venda), MONTH(V.Data_Venda)
)
SELECT
	Ano,	
	Mes, 
	Vendas_Mes,		
	SUM(Vendas_Mes) OVER(PARTITION BY Ano ORDER BY Mes) AS Vendas_Acumulada
FROM CTE_Vendas
ORDER BY Ano, Mes;




-- Pergunta 7: Vendas por Continente e Tipo de Loja?

WITH Receita_Total_Continente AS
(
	SELECT
		LC.Continente,
		L.Tipo,
		SUM(I.Qtd_Vendida * P.Preço_Unitario)AS Total_Continente
	FROM Vendas V
	INNER JOIN Itens I ON I.Id_Venda = V.Id_Venda
	INNER JOIN Produtos P ON P.SKU = I.SKU
	INNER JOIN Lojas L ON L.ID_Loja = V.ID_Loja
	INNER JOIN Localidades LC ON LC.ID_Localidade = L.id_Localidade
	GROUP BY LC.Continente, L.Tipo
)
SELECT 
	 R.Continente,
	 R.Tipo AS Tipo_Loja,	 
	 FORMAT(R.Total_Continente,	'C0') AS Valor,
	 FORMAT(SUM(R.Total_Continente) OVER(PARTITION BY R.Continente), 'C0') AS Total_Continente	
FROM Receita_Total_Continente R;




-- Pergunta 8: Concentração de Lojas

SELECT 
	LC.Continente,
	LC.País,
	COUNT(1) AS Num_Lojas
FROM LOJAS LJ INNER JOIN Localidades LC ON LJ.id_Localidade = LC.ID_Localidade
GROUP BY LC.Continente, LC.País
ORDER BY LC.Continente, Num_Lojas DESC;


-- Pergunta 9: Categorias de Produtos
WITH CTE_Total_Tipo AS (
    SELECT 
        P.Tipo_Produto,
        SUM(P.Preço_Unitario * I.Qtd_Vendida) AS Total_Tipo
    FROM Produtos P 
    INNER JOIN Itens I ON P.SKU = I.SKU
    GROUP BY P.Tipo_Produto
),
CTE_Total_Geral_Tipo AS (
    SELECT 
        SUM(P.Preço_Unitario * I.Qtd_Vendida) AS Total_Geral
    FROM Produtos P 
    INNER JOIN Itens I ON P.SKU = I.SKU
)
SELECT
    TT.Tipo_Produto AS Tipo_Produto,
    TT.Total_Tipo  AS Vendas_R$,
	(TT.Total_Tipo / TG.Total_Geral) * 100 AS Porcentagem_Total_Produtos
FROM CTE_Total_Tipo TT
CROSS JOIN CTE_Total_Geral_Tipo TG
ORDER BY Porcentagem_Total_Produtos DESC;

