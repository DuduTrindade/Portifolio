


## Introdução

No cenário atual, onde os dados são frequentemente comparados ao petróleo pela sua capacidade de gerar valor e impulsionar decisões estratégicas, a análise eficiente de informações tornou-se um pilar fundamental para empresas que desejam se manter competitivas e ágeis em um mercado cada vez mais dinâmico. Dentre as diversas áreas de aplicação da análise de dados, o setor de vendas destaca-se como um dos mais críticos, pois oferece insights profundos sobre o comportamento do consumidor, tendências de mercado e oportunidades de otimização de estratégias comerciais. Nesse contexto, o SQL (Structured Query Language) emerge como uma ferramenta indispensável, permitindo a extração, manipulação e análise de grandes volumes de dados de forma rápida, precisa e escalável.

Este projeto tem como foco a análise de dados de uma empresa fictícia de varejo que atua nos segmentos de eletrônicos e vestuário. Com um portfólio diversificado que inclui desde dispositivos móveis, computadores e acessórios tecnológicos de ponta até camisas, casacos e relógios, a empresa possui uma presença global, operando em múltiplos continentes por meio de canais online e lojas físicas. Seu público-alvo abrange desde consumidores individuais até pequenas e grandes empresas, o que demanda uma abordagem analítica abrangente e detalhada.

Ao longo desta análise, utilizarei o SQL como principal ferramenta para explorar e interpretar os dados de vendas, buscando responder a perguntas estratégicas que podem orientar decisões empresariais fundamentais. Desde a identificação dos produtos mais vendidos e a avaliação do desempenho por região ou canal de vendas, até a análise das taxas de devolução e a segmentação de clientes mais valiosos, cada consulta SQL será projetada para extrair insights acionáveis. Esses insights, por sua vez, servirão como base para a implementação de ações concretas que visam melhorar a eficiência operacional, aumentar a satisfação do cliente e impulsionar o crescimento sustentável da empresa.

Combinando o poder do SQL com uma abordagem analítica estruturada, este projeto não apenas demonstra a importância da análise de dados no contexto empresarial, mas também ilustra como a tecnologia pode ser utilizada para transformar dados brutos em conhecimento estratégico, capacitando organizações a tomar decisões mais informadas e assertivas. Retornar ao [início.](https://github.com/DuduTrindade/Portifolio/tree/main/Projetos#projetos)


## Estrutura do Conjunto de Dados

O conjunto de dados é composto pelas seguintes tabelas:
*	**Clientes**: Contém informações demográficas dos clientes.
*	**Devoluções**: Registra as devoluções de produtos.
*	**Itens**: Detalha os itens vendidos em cada venda.
*	**Localidades**: Armazena informações geográficas das lojas.
*	**Lojas**: Contém informações sobre as lojas.
*	**Produtos**: Armazena informações sobre os produtos vendidos.
*	**Vendas**: Registra as vendas realizadas.

Nesta análise estou utilizando o Sistema de Gerenciamento de Banco de Dados (SGBD) SQL Server da Microsoft. Abaixo segue a imagem do Diagrama Entidade Relacionamento e seus respectivos relacionamentos.

<div align="center" style="display: inline-block;">
	<img  width="680" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/Diagrama.png">
</div>



#### Tabela de Clientes

<div style="display: inline-block;">
	<img width="800" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/TABELAS%20CLIENTES.png">
</div>


Descrição: Esta tabela contém informações dos clientes. Segue abaixo os campos:

*	**Id_cliente**: Identificador único do cliente.
*	**Primeiro_nome**: Primeiro nome do cliente.
*	**Sobrenome**: Sobrenome do cliente.
*	**Email**: Endereço de e-mail do cliente.
*	**Gênero**: Gênero do cliente.
*	**Data_nascimento**: Data de nascimento do cliente.
*	**Estado_civil**: Estado civil do cliente (solteiro, casado, etc.).
*	**Num_filhos**: Número de filhos do cliente.
*	**Documento**: Documento de identificação do cliente.
*	**Id_localidade**: Identificador da localidade do cliente.

#### Tabela de Devoluções

<div style="display: inline-block;">
	<img width="500" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/TABELA%20DEVOLU%C3%87%C3%95ES.png">
</div>


Descrição: Esta tabela registra as devoluções de produtos. Segue abaixo os campos:

*	**Data_devolucao**: Data em que a devolução foi realizada.
*	**Id_Loja**: Identificador da loja onde a devolução foi realizada.
*	**SKU**: Código do produto devolvido.
*	**Qtde_Devolvida**: Quantidade de itens devolvidos.
*	**Motivo_Devolucao**: Motivo pelo qual o produto foi devolvido.
*	**Id_Devolução**: Identificador da devolução

#### Tabela de Itens

<div style="display: inline-block;">
	<img width="300" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/TABELA%20ITENS.png">
</div>




Descrição: Esta tabela detalha os itens vendidos em cada transação. Segue abaixo os campos:

*	**Id_item**: Identificador único de cada item vendido.
*	**Id_venda**: Identificador da venda associada ao item.
*	**SKU**: Código do produto.
*	**Qtde_vendida**: Quantidade vendida do item.

#### Tabela de Localidades

<div style="display: inline-block;">
	<img width="300" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/TABELA%20LOCALIDADES.png">
</div>



Descrição: Armazena informações geográficas. Segue abaixo os campos:

*	**Id_localidade**: Identificador único de cada localidade
*	**País**: nome do país
*	**Continente**: nome do continente

#### Tabela de Lojas

<div style="display: inline-block;">
	<img width="650" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/TABELA%20LOJAS.png">
</div>



Descrição: Esta tabela contém informações detalhadas sobre as lojas da empresa, essenciais para a análise de desempenho e gestão operacional. Segue os campos:

*	**Id_loja**: Identificador único de cada loja.
*	**Nome_loja**: Nome da loja.
*	**Quantidade_Colaboradores**: Número de colaboradores que trabalham na loja.
*	**Tipo**: Tipo de loja (por exemplo, física, online ou híbrida).
*	**Id_localidade**: Identificador da localidade onde a loja está situada, facilitando a correlação com dados geográficos.
*	**Gerente_Loja**: Nome do gerente responsável pela loja.
*	**Documento_Gerente**: Documento de identificação do gerente da loja.


#### Tabela de Produtos

<div style="display: inline-block;">
	<img width="650" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/TABELA%20PRODUTOS.png">
</div>



Descrição: Armazena informações sobre os produtos vendidos. Segue abaixo os campos: 

*	**SKU**: Código único do produto, utilizado para identificação e rastreamento.
*	**Produto**: Nome do produto.
*	**Marca**: Marca do produto.
*	**Tipo_Produto**: Categoria ou tipo do produto.
*	**Preco_Unitario**: Preço unitário do produto.
*	**Custo_Unitario**: Custo unitário do produto.
*	**Observação**: Campo para observações adicionais sobre o produto.

#### Tabela de Vendas

<div style="display: inline-block;">
	<img width="300" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/TABELA%20VENDAS.png">
</div>



Descrição: Esta tabela registra todas as vendas realizadas, fornecendo um histórico completo das transações de venda.

*	**Id_venda**: Identificador único de cada venda.
*	**Data_venda**: Data em que a venda foi realizada.
*	**Id_cliente**: Identificador do cliente que realizou a compra.
*	**Id_loja**: Identificador da loja onde a venda foi efetuada.

## Análise Explorativa dos Dados

Nesta etapa, realizaremos uma análise exploratória das tabelas disponíveis para entender como os dados estão organizados e identificar as informações mais relevantes. Essa análise é fundamental para obter insights e preparar o terreno para futuras análises mais aprofundadas.


### Perguntas Sugeridas

1) **Distribuição de Clientes por Gênero e Faixa Etária**: Segmentar os clientes por gênero e faixa etária para entender a proporção dos dados.
2) **Distribuição Geográfica de Clientes**: Relacionar a tabela de Clientes com a tabela de Localidades para entender a distribuição geográfica de clientes por País e Continente
3) **Motivos de Devolução dos Produtos**: Analisar os principais motivos de devolução.
4) **Taxa de Devoluções**: Calcular a frequência de devoluções por produtos e lojas
5) **Produtos Mais Vendidos**: Identificar os produtos mais vendidos.
6) **Análise Temporal de Vendas**: Calcular a quantidade vendida por mês, trimestre e ano.
7) **Vendas por Continente e Tipo de Loja**: Calcular a receita total de vendas por continente e tipo de loja
8) **Concentração de Lojas**: Identificar regiões com maior concentração de lojas.
9) **Categorias de Produtos**: Analisar a distribuição de vendas dos produtos por categoria.


### Análises


> 📝**Pergunta 1: Distribuição de Clientes por Gênero e Faixa Etária**

~~~SQL
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
		WHEN Faixa_Etaria = 6 THEN '56-65' -- Faixa 6 corresponde ao intervalo '56-65 anos'.
		ELSE '66+'					-- Faixa 7 corresponde ao intervalo '66 anos ou mais'.
	END	Faixa_Etaria,
	COUNT(Faixa_Etaria) AS Total_Genero
FROM CTE_Distribuicao_Genero
GROUP BY Faixa_Etaria, Genero
ORDER BY Faixa_Etaria, Total_Genero DESC;
~~~

<div style="display: inline-block;">
	<img width="300" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/Resultado%20analise%20cliente.png">
	<img width="700" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/GRAFICO%20CLIENTES.png">
</div> 
<br>
Observando o gráfico percebe-se que a faixa etária de 26-35 possui um número clientes de 6003 que representa um total de 33% do total geral, sendo que o percentual masculino é de 17% e feminino de 16%. A faixa de 36-45 possui um número de 5230 de clientes representando 29% do total geral, sendo 15% masculino e 14% feminino. A faixa etária de 46-55 tem soma um total de 3057 com percentual de 17% do total geral, sendo que 9% são femininos e 8% masculinos. Essas três faixas representam um total de 79% dos clientes.
<br><br>


> 📝**Pergunta 2: Distribuição Geográfica de Clientes**

~~~sql
SELECT 
	L.Continente,	
	L.País,	
	COUNT(C.ID_Cliente) AS Total_Clientes,
	SUM(COUNT(C.ID_Cliente)) OVER(PARTITION BY L.Continente) AS Total_Continente
FROM Clientes C INNER JOIN Localidades L ON C.Id_Localidade = L.Id_Localidade
GROUP BY L.País, L.Continente
ORDER BY L.Continente, Total_Clientes DESC;
~~~

<div align="center" style="display: inline-block;">
	<img width="350" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/distrib.%20clientes%20.png"><br><br>
	<img width="850" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/analise_cliente.png">
</div> 
<br>

A distribuição por continente revela que a Europa abriga aproximadamente 49,7% dos clientes, em relação ao total de 18.148 clientes. Já a Ásia possui 7.536 clientes, representando 41,5% do total. Os continentes América do Norte e Oceania abrigam cerca de 5,9% e 2,8% dos clientes, respectivamente.
O gráfico de coluna mostra os top 10 principais países onde a empresa mais possui clientes, e revelam que 4 deles estão na Europa (Dinamarca, Suécia, Itália e Alemanha), 5 estão na Ásia (Coreia do Sul, Japão, China, Paquistão e Singapura) e 1 está na América do Norte (Estados Unidos).

<br>

> 📝**Pergunta 3: Motivos de Devolução dos Produtos**

~~~sql
SELECT 
	Motivo_Devolucao,
	COUNT(*) AS Qtde_Totais_Devolucao
FROM Devolucoes
GROUP BY Motivo_Devolucao
ORDER BY Qtde_Totais_Devolucao DESC;
~~~~

<div align="center" style="display: inline-block;">
	<img width="350" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/motivo_devolucao.png">	
</div> 

Analisando quais são os motivos mais frequentes devolução descobrimos que defeito, é o principal motivo com 1.600 ocorrências, representando 88% do total de devoluções que é 1809. Arrependimento com 104 ocorrências representa 6% e Troca Indisponível e Não Informado representam 3% cada.<br>

> 📝**Pergunta 4: Taxa de Devoluções**

~~~sql
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
~~~

#### Produto


<div align="center" style="display: inline-block;">
	<img width="650" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/devolucao_produto.png">	
</div> 
<br>

O resultado apresenta os 20 produtos com as maiores taxas de devolução, comparando o número total de devoluções com o número total de vendas para cada item. Esta análise é essencial para identificar produtos que podem precisar de melhorias ou revisões nas suas especificações.
Além disso, podemos realizar uma análise complementar calculando a média da taxa de devolução por categoria de produto e marca. Dessa forma, podemos identificar quais categorias e marcas apresentam as maiores taxas de devolução e, consequentemente, focar em estratégias para reduzir essas taxas.


#### Tipo Produto

~~~sql
SELECT
	Tipo_Produto,		
	SUM(Totais_Devolucao) / SUM(Total_Vendido) * 100 AS Taxa_Devolucao%
FROM vw_Taxa_Devolucao_Produtos
GROUP BY Tipo_Produto
ORDER BY [Taxa_Devolucao%] DESC

~~~

<div align="center" style="display: inline-block;">
	<img width="300" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/devolucao_tipo_produto.png">	
</div> 
<br>

A consulta revela que eletrônicos (Celular, Notebook, Monitor, Mouse e Teclado) têm uma taxa de devolução de 12%, enquanto vestuário (Camisa e Casaco) tem apenas 4%, isso pode sugerir que há problemas específicos com os eletrônicos (ex.: defeitos, descrições imprecisas) que precisam ser investigados e corrigidos.

#### Marca

~~~sql
SELECT
	Marca,		
	SUM(Totais_Devolucao) / SUM(Total_Vendido) * 100
	[Taxa_Devolucao%]
FROM vw_Taxa_Devolucao_Produtos
GROUP BY Marca 
ORDER BY [Taxa_Devolucao%] DESC
~~~

<div align="center" style="display: inline-block;">
	<img width="300" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/devolucao_marca.png">	
</div> 
<br>

O resultado revela que a marca Vaio tem a maior taxa de devolução 8,3% entre todas as marcas, número bem acima das demais marcas que é de 3%. A partir desses dados podemos investigar os motivos por trás da alta devolução da marca Vaio (ex.: defeitos, falhas frequentes, problemas logísticos).


> 📝**Pergunta 5: Produtos Mais Vendidos**

~~~sql
-- TOP 10 Produtos mais vendidos
 SELECT TOP 10
	DENSE_RANK() OVER(ORDER BY SUM(I.Qtd_Vendida * P.Preço_Unitario) DESC) AS [Rank],
	I.SKU,
	P.Produto AS Nome,
	SUM(I.Qtd_Vendida * P.Preço_Unitario) AS Total_Vendido
FROM Produtos P INNER JOIN Itens I ON P.SKU = I.SKU
GROUP BY I.SKU, P.Produto	
ORDER BY Total_Vendido DESC;
~~~

<div align="center" style="display: inline-block;">
	<img width="500" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/produtos_mais_vendidos.png">	
</div> 
<br>

O resultado ajuda a:
- Identificar os produtos mais rentáveis e priorizá-los;
- Criar estratégias de marketing direcionadas.
- Otimizar estoque e compras com foco nos produtos de alto desempenho.

> 📝**Pergunta 6: Análise Temporal de Vendas**

~~~sql
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
~~~

<div align="center" style="display: inline-block;">
	<img width="400" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/analise_temporal_vendas.png">	
</div> 
<br>

Essa consulta fornece uma visão clara do desempenho mensal e anual das vendas, permitindo:
- Identificar tendências sazonais.
- Acompanhar o crescimento acumulado ao longo do ano.
- Comparar o desempenho entre diferentes anos.
- Planejar estratégias de estoque, marketing e vendas com base em dados históricos.

> 📝**Pergunta 7: Vendas por Continente e Tipo de Loja**

~~~sql
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
	 R.Tipo,	 
	 FORMAT(R.Total_Continente,	'C0') AS Valor_Tipo_Loja,
	 FORMAT(SUM(R.Total_Continente) OVER(PARTITION BY R.Continente), 'C0') AS Total_Continente	
FROM Receita_Total_Continente R
~~~

<div align="center" style="display: inline-block;">
	<img width="400" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/vendas_continente_tipo_loja.png">	
</div> 
<br>

#### Desempenho por Continente
- **América do Norte**:

	- Total de vendas: R$ 9.247.045.
	- É o continente com a maior receita, representando o mercado mais forte.

- **Ásia**:
	- Total de vendas: R$ 2.956.342.
	- Segundo maior mercado, com potencial de crescimento.

- **Europa**:
	- Total de vendas: R$ 2.867.560.
	- Desempenho próximo ao da Ásia, mas ligeiramente inferior.

- **Oceania**:
	- Total de vendas: R$ 155.134.
	- Mercado menor, com oportunidades de expansão.

#### Desempenho por Tipo de Loja
- **Lojas Físicas**:
	- Dominam as vendas em todos os continentes, exceto na Oceania, onde não há dados de lojas online.
	- Na América do Norte, as lojas físicas geraram R$ 8.335.180, representando 90% do total do continente.
	- Na Ásia e Europa, as lojas físicas também são predominantes, com 73% e 69% do total de vendas, respectivamente.

- **Lojas Online**:
	- Têm uma participação menor, mas significativa.
	- Na América do Norte, as vendas online representam 10% do total.
	- Na Ásia e Europa, as vendas online representam 27% e 31%, respectivamente.

A tabela mostra que as lojas físicas são o principal canal de vendas, mas as vendas online têm uma participação significativa, especialmente na Ásia e Europa. A América do Norte é o mercado mais forte, enquanto a Oceania representa uma oportunidade de crescimento. Investir no canal online e expandir em mercados menores pode impulsionar ainda mais a receita global

> 📝**Pergunta 8: Concentração de Lojas**

~~~SQL
SELECT 
	LC.Continente,
	LC.País,
	COUNT(1) AS Num_Lojas
FROM LOJAS LJ INNER JOIN Localidades LC ON LJ.id_Localidade = LC.ID_Localidade
GROUP BY LC.Continente, LC.País
ORDER BY LC.Continente, Num_Lojas DESC

~~~

<div align="center" style="display: inline-block;">
	<img width="300" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/concentracao_lojas.png">	
</div> 
<br>


#### Distribuição Geográfica das Lojas:
- América do Norte: A maioria das lojas está concentrada nos Estados Unidos, com 198 lojas, enquanto o Canadá tem apenas 11 lojas.
- Ásia: A China tem o maior número de lojas na Ásia, com 9 lojas, seguida pelo Japão com 8 lojas. Outros países asiáticos têm um número menor de lojas, variando de 1 a 3.
- Europa: O Reino Unido lidera com 15 lojas, seguido pela Alemanha com 12 lojas e França com 8 lojas. A maioria dos outros países europeus tem apenas 1 loja.
- Oceania: A Austrália tem 3 lojas, sendo o único país listado na Oceania.

#### Concentração por Continente:

- América do Norte: 209 lojas (198 nos EUA e 11 no Canadá).
- Ásia: 36 lojas.
- Europa: 54 lojas.
- Oceania: 3 lojas.

#### Países com Maior Número de Lojas:

- Estados Unidos: 198 lojas.
- Reino Unido: 15 lojas.
- Alemanha: 12 lojas.
- China: 9 lojas.
- França: 8 lojas.

#### Países com Menor Número de Lojas:

Vários países na Ásia e Europa têm apenas 1 loja, como Singapura, Quirguistão, Armênia, Indonésia, Romênia, Polônia, Portugal, Malta, Suécia, Suíça, Grécia, Holanda, Irlanda, Dinamarca, Eslovénia e Espanha.

#### Diversidade de Países:

- A Ásia tem a maior diversidade de países com lojas, totalizando 13 países.
- A Europa tem 16 países com lojas.
- A América do Norte e a Oceania têm uma diversidade menor, com 2 e 1 país, respectivamente.

#### Estratégia de Expansão:

- A empresa parece ter uma forte presença nos Estados Unidos, que é o mercado principal.
- Há uma presença significativa, mas menor, em países europeus e asiáticos.
- A Oceania e alguns países da Ásia e Europa têm uma presença muito limitada, o que pode indicar oportunidades de expansão.

> 📝**Pergunta 9: Categorias de Produtos**

~~~sql
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
~~~

<div align="center" style="display: inline-block;">
	<img width="400" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/venda_tipo_produtos.png">	
</div> 
<br>

#### Produto com Maior Volume de Vendas:
Notebook é o produto que mais contribui para as vendas totais, representando 49,06% do total. Isso indica que os notebooks são os produtos mais vendidos e provavelmente os mais rentáveis.

#### Produtos Secundários:
Celular e Monitor são os próximos produtos mais significativos, com 29,09% e 11,20% respectivamente. Esses produtos também são importantes, mas têm um volume de vendas menor em comparação com os notebooks.

#### Produtos Menores:
Teclado, Mouse, Casaco e Camisa têm uma participação menor nas vendas, com 4,98%, 2,81%, 1,90% e 0,97% respectivamente. Esses produtos podem ser nichos de mercado ou áreas que a empresa está desenvolvendo.


## Exploração Interativa dos Dados 
Agora que realizamos a análise exploratória e entendemos melhor os dados iremos comparar diferentes métricas e dimensões para identificar os pontos fortes e fracos, avaliar o impacto de diferentes estratégias para uma melhor tomada de decisão.

### Análise Comparativa

- [x] Comparação entre faturamento e lucro ao longo do tempo;<br>
- [x] Comparação do lucro entre as marcas;<br>
- [x] Comparação do lucro entre os canais de vendas;<br>
- [x] Visão geral sobre cada loja; <br>
- [x] Visão geral sobre os produtos; <br>
- [x] Comparação do lucro entre os países.<br>

### KPIs

Principais indicadores chaves de desempenho (key performance indicator ou KPI) consolidados:

- [x] Faturamento total;<br>
- [x] Lucro;<br>
- [x] Número de vendas;<br>
- [x] Número de devoluções;<br>
- [x] Custo total;<br>
- [x] Margem de lucro.<br>

### Dashboard

<div style="display: inline-block;">
	<img width="800" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/dash%201.png"> <br>
	<img width="800" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/dash%202.png">
	<img width="800" src="https://github.com/DuduTrindade/AnaliseDados/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas%20com%20SQL/img/dash%203.png">
</div>
<br>

Aqui segue o [Link](https://app.powerbi.com/view?r=eyJrIjoiZmIxNTIyNWEtOTNlNi00ZGRiLThjYTEtYjQ5ZTJlNjNlZDkwIiwidCI6IjY1OWNlMmI4LTA3MTQtNDE5OC04YzM4LWRjOWI2MGFhYmI1NyJ9) para acessar o Dashboard.


<br>

## Conclusão 
O projeto de análise de dados demonstrou de forma clara e eficaz como a utilização de ferramentas analíticas, em especial o SQL, pode transformar dados brutos em insights estratégicos capazes de impulsionar decisões empresariais. Ao longo da análise, foram explorados diversos aspectos críticos do negócio, desde o comportamento dos clientes até o desempenho de produtos e lojas, permitindo identificar oportunidades de melhoria e otimização.

Este projeto não apenas reforçou a importância da análise de dados no contexto empresarial, mas também ilustrou como a tecnologia pode ser utilizada para transformar dados em conhecimento estratégico. A empresa ao adotar uma abordagem baseada em dados, conseguiu se posicionar de forma mais competitiva no mercado, garantindo maior eficiência operacional e melhores resultados financeiros a longo prazo. A análise de dados mostrou-se, portanto, uma ferramenta indispensável para a tomada de decisões informadas e assertivas, capazes de impulsionar o crescimento sustentável da empresa















