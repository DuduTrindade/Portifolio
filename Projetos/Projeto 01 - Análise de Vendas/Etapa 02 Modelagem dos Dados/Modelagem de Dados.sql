
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

-- REMOVENDO REDUNDÂNCIAS

-- Deletando o campo Data_venda
ALTER TABLE ITENS
	DROP COLUMN DATA_VENDA;


-- Deletando o campo Id_cliente
ALTER TABLE ITENS
	DROP COLUMN ID_CLIENTE;

SELECT * FROM ITENS
















-- adicionando chave composta
ALTER TABLE ITENS
	ADD CONSTRAINT PK_IdVenda_OrdemCompra PRIMARY KEY (ID_VENDA, ORDEM_COMPRA)

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

-- Adiciona uma chave PRIMARY COMPOSTA
ALTER TABLE DEVOLUCOES
	ADD CONSTRAINT PK_IdLoja_IdDevolucao PRIMARY KEY (Id_Loja, Id_Devolucao)

ALTER TABLE DEVOLUCOES
	ADD CONSTRAINT FK_IdLoja FOREIGN KEY (Id_Loja) REFERENCES LOJAS (Id_Loja)

-- Relacionamento entre Produtos e Devoluções
ALTER TABLE DEVOLUCOES
	ADD CONSTRAINT FK_ProdutoSKU_DevolucaoSKU_SKU FOREIGN KEY (SKU) REFERENCES PRODUTOS (SKU)

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















