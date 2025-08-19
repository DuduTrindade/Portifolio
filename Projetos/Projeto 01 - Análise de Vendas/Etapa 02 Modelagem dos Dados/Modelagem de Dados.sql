
USE Vendas_Nova_Varejo;

-- TABELA VENDAS

--Adicionando chave primária
ALTER TABLE VENDAS
	ADD CONSTRAINT PK_Id_Venda PRIMARY KEY (ID_VENDA)

-- Relacionamento entre VENDAS e CLIENTES
ALTER TABLE VENDAS
	ADD CONSTRAINT FK_Vendas_Clientes_IdCliente FOREIGN KEY (Id_Cliente) REFERENCES CLIENTES (Id_Cliente)

-- Relacionamento entre VENDAS E LOJAS
ALTER TABLE VENDAS
	ADD CONSTRAINT FK_Vendas_Lojas_IdLoja FOREIGN KEY (Id_Loja) REFERENCES LOJAS (Id_Loja)

-- ---------------------------------------------------------

-- TABELA ITENS

SELECT * FROM ITENS

-- REMOVENDO REDUNDÂNCIAS

-- Deletando o campo Data_venda
ALTER TABLE ITENS
	DROP COLUMN DATA_VENDA;


-- Deletando o campo Id_cliente
ALTER TABLE ITENS
	DROP COLUMN ID_CLIENTE;

-- Adicionando o campo Id_item
ALTER TABLE ITENS
	ADD Id_item INT IDENTITY(1,1)

-- Adicionando chave PRIMÁRIA
ALTER TABLE ITENS
	ADD CONSTRAINT PK_Itens_Id_item PRIMARY KEY (Id_item)


-- Relacionamento entre ITENS e VENDAS
ALTER TABLE ITENS
	ADD CONSTRAINT FK_Itens_Vendas_IdVenda FOREIGN KEY (Id_Venda) REFERENCES VENDAS (Id_Venda)
	
-- Relacionamento entre ITENS e PRODUTOS
ALTER TABLE ITENS
	ADD CONSTRAINT FK_Itens_Produtos_SKU FOREIGN KEY (SKU) REFERENCES PRODUTOS (SKU)

-- ---------------------------------------------------------	

-- TABELA CLIENTES

ALTER TABLE CLIENTES
	ADD CONSTRAINT PK_IdCliente PRIMARY KEY (ID_CLIENTE)

-- Relacionamento entre CLIENTES e LOCALIDADES
ALTER TABLE CLIENTES
	ADD CONSTRAINT FK_Cliente_Localidade_IdLocalidade FOREIGN KEY (Id_Localidade) REFERENCES LOCALIDADES (Id_Localidade)

-- ----------------------------------------------------------
-- TABELA DEVOLUÇÕES
SELECT * FROM Devolucoes

-- Adiciona uma nova coluna auto incremento
ALTER TABLE DEVOLUCOES
	ADD Id_Devolucao INT IDENTITY(1,1)

--Adiciona a coluna Id_Item
ALTER TABLE DEVOLUCOES
	ADD Id_Item INT NULL;


--Popular a coluna Id_Item
UPDATE d
SET d.Id_Item = i.Id_Item
FROM Devolucoes d
INNER JOIN (
    SELECT SKU, MIN(Id_Item) AS Id_Item
    FROM Itens
    GROUP BY SKU
) i ON d.SKU = i.SKU;


-- Criar a FK
ALTER TABLE Devolucoes
ALTER COLUMN Id_Item INT NOT NULL;


-- Adiciona uma chave PRIMARY 
ALTER TABLE DEVOLUCOES
	ADD CONSTRAINT PK_Devolucoes_IdDevolucao PRIMARY KEY(Id_Devolucao);

ALTER TABLE DEVOLUCOES
	ADD CONSTRAINT FK_IdLoja FOREIGN KEY (Id_Loja) REFERENCES LOJAS (Id_Loja);

-- Relacionamento entre Produtos e Devoluções
ALTER TABLE DEVOLUCOES
	ADD CONSTRAINT FK_ProdutoSKU_DevolucaoSKU_SKU FOREIGN KEY (SKU) REFERENCES PRODUTOS (SKU);

-- Relacionamento entre Itens e Devoluções
ALTER TABLE Devolucoes ADD CONSTRAINT FK_Devolucoes_Itens FOREIGN KEY (Id_Item) REFERENCES Itens(Id_Item);

-- ----------------------------------------------------------

-- TABELA LOCALIDADES

ALTER TABLE LOCALIDADES
	ADD CONSTRAINT PK_Id_Localidade PRIMARY KEY (Id_Localidade)

-- ----------------------------------------------------------
-- TABELA LOJAS

ALTER TABLE LOJAS	
	ADD CONSTRAINT PK_IdLoja PRIMARY KEY (ID_LOJA)

-- Relacionamento LOJAS e LOCALIDADES 
ALTER TABLE LOJAS
	ADD CONSTRAINT FK_Localidades_Lojas_IdLoca FOREIGN KEY (Id_Localidade) REFERENCES LOCALIDADES (Id_Localidade)

-- ----------------------------------------------------------
-- TABELA PRODUTOS

SELECT * FROM PRODUTOS

ALTER TABLE PRODUTOS 
	ADD CONSTRAINT PK_SKU PRIMARY KEY (SKU)















