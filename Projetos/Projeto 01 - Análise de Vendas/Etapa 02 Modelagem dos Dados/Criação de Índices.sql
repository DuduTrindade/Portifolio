
USE Vendas_Nova_Varejo;

/* ===================================================
   📊 ÍNDICES NAS TABELAS FATO
   =================================================== */

/* ===== Tabela Vendas ===== */
-- Índice para acelerar consultas por data de venda
CREATE INDEX IX_Vendas_DataVenda
ON Vendas (Data_Venda);

-- Índice para acelerar joins e filtros por cliente
CREATE INDEX IX_Vendas_IdCliente
ON Vendas (ID_Cliente);

-- Índice para acelerar joins e filtros por loja
CREATE INDEX IX_Vendas_IdLoja
ON Vendas (ID_Loja);


/* ===== Tabela Itens ===== */
-- Índice para acelerar joins entre Vendas e Itens
CREATE INDEX IX_Itens_IdVenda
ON Itens (Id_Venda);

-- Índice para acelerar joins com Produtos
CREATE INDEX IX_Itens_SKU
ON Itens (SKU);

-- Índice composto para relatórios de mix de produtos por venda
CREATE INDEX IX_Itens_IdVenda_SKU
ON Itens (Id_Venda, SKU);


/* ===== Tabela Devoluções ===== */
-- Índice para consultas por data de devolução
CREATE INDEX IX_Devolucoes_DataDevolucao
ON Devolucoes (Data_Devolucao);

-- Índice para consultas por loja (ex: devoluções por loja)
CREATE INDEX IX_Devolucoes_IdLoja
ON Devolucoes (Id_Loja);

-- Índice para relacionar devoluções com os itens vendidos
CREATE INDEX IX_Devolucoes_IdItem
ON Devolucoes (Id_Item);



/* ===================================================
   📊 ÍNDICES NAS TABELAS DIMENSÃO
   =================================================== */

/* ===== Tabela Clientes ===== */
-- Índice único para evitar duplicidade de documentos
CREATE UNIQUE INDEX UQ_Clientes_Documento
ON Clientes (Documento);

-- Índice para buscas por email (ex: relatórios de clientes)
CREATE UNIQUE INDEX UQ_Clientes_Email
ON Clientes (Email);

-- Índice para segmentações por localidade
CREATE INDEX IX_Clientes_IdLocalidade
ON Clientes (Id_Localidade);


/* ===== Tabela Produtos ===== */
-- Índice para buscas rápidas por tipo de produto
CREATE INDEX IX_Produtos_TipoProduto
ON Produtos (Tipo_Produto);

-- Índice para relatórios por marca
CREATE INDEX IX_Produtos_Marca
ON Produtos (Marca);


/* ===== Tabela Lojas ===== */
-- Índice para consultas por localidade (ex: lojas por cidade/país)
CREATE INDEX IX_Lojas_IdLocalidade
ON Lojas (Id_Localidade);


/* ===== Tabela Localidades ===== */
-- Índice para relatórios por país
CREATE INDEX IX_Localidades_Pais
ON Localidades (Pais);

-- Índice para relatórios por continente
CREATE INDEX IX_Localidades_Continente
ON Localidades (Continente);
