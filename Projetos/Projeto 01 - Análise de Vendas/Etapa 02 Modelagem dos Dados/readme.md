## 🧱 Etapa 02 – Modelagem dos Dados

### 📶Diagrama DER do Banco de Dados

<div align="center" style="display: inline-block;">
	<img  width="900" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2002%20Modelagem%20dos%20Dados/img/diagrama_der.png">
</div>

<br>

### ⚠️ Pontos a revisar/melhorar:

#### 1.Tabela `Itens`

- Contém **ID_Cliente** e **Data_Venda**, que já estão na tabela Vendas.<br>
🔹 Isso é redundância.<br>
➝ Melhor deixar apenas `Id_Venda`, `SKU`, `Quantidade_Vendida` e `Ordem_Compra`.<br>
(Se precisar do cliente ou da data, busca-se via `JOIN` em `Vendas`).

#### 2.Tabela `Devolucoes`

- Está ligada a **Produtos** e **Lojas**, mas não a **Vendas/Itens**.<br>
🔹 Isso pode gerar inconsistências, pois uma devolução deveria estar ligada a uma venda específica (ou item vendido).<br>
➝ Sugestão: incluir `Id_Venda` ou `Id_Item` em `Devolucoes`, para rastrear qual venda gerou a devolução.

#### 3.Tabela `Lojas`

- Tem `Gerente_Loja` e `Documento_Gerente`.<br>
🔹 Se for necessário controlar gerentes como entidades próprias, talvez fosse melhor ter uma tabela **Gerentes**.<br>
Mas, no nosso caso não é prioridade, pode ficar assim.

### Ações Tomadas:

- **Remover redundâncias da tabela** `Itens` (não precisa repetir cliente e data).
- **Ligar devoluções às vendas/itens**, não só a produtos e lojas.

<hr>

### Remover redundâncias da tabela itens

<div align="center" style="display: inline-block;">
	<img  width="600" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2002%20Modelagem%20dos%20Dados/img/eliminando_redundancia.png">
</div>

<br>

### Ligar devoluções às vendas/itens

No DER atual, a tabela **Devoluções** está ligada apenas a **Produtos** e **Lojas**, mas **não garante o vínculo com a venda original**. 
Isso pode gerar problema, pois uma devolução sempre deveria estar associada a um item de venda específico.

### 🔧 Como resolver:


1. **Criar `Id_Item` na tabela Itens**

~~~sql
ALTER TABLE Itens
ADD Id_Item INT IDENTITY(1,1) PRIMARY KEY;
~~~

2. **Adicionar `Id_Item` em Devoluções**

~~~sql
ALTER TABLE Devolucoes
ADD Id_Item INT NULL;
~~~

3. **Popular `Id_Item`**

~~~sql
UPDATE d
SET d.Id_Item = i.Id_Item
FROM Devolucoes d
INNER JOIN (
    SELECT SKU, MIN(Id_Item) AS Id_Item
    FROM Itens
    GROUP BY SKU
) i ON d.SKU = i.SKU;
~~~

4. **Criar a FOREIGN KEY**

~~~sql
ALTER TABLE Devolucoes
ALTER COLUMN Id_Item INT NOT NULL;

ALTER TABLE Devolucoes
ADD CONSTRAINT FK_Devolucoes_Itens
FOREIGN KEY (Id_Item) REFERENCES Itens(Id_Item);
~~~

### ✅ O que melhorou

- **`Devoluções` → `Itens`**: agora cada devolução só existe se houver um item vendido correspondente.

Aqui esta o <a href="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2002%20Modelagem%20dos%20Dados/Modelagem%20de%20Dados.sql">**Link**</a> dos scripts de relacionamento entre as tabelas.

### 📌 Diagrama ER completo (com chaves primárias, estrangeiras e cardinalidade).

<div align="center" style="display: inline-block;">
	<img  width="900" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2002%20Modelagem%20dos%20Dados/img/diagrama_der_NORMALIZADO.png">
</div>

<br>

### 🧭 Classificação Tabelas Dimensão x Fato

Tabelas Fato (registram eventos)	
- Vendas
- Itens
- Devoluções

Tabelas de 	Dimensão (contexto descritivo)
- Produtos
- Clientes
- Localidades
- Lojas	



### 🔐 Criação de índices nas tabelas fato e Dimensão para melhorar performance.

~~~sql

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

~~~


### 📖 Dicionário de Dados
																										
| Nome_Tabela | Nome_Coluna            | Descrição dos Campos                                                                                                                                               | Tipo_Dado   |
|-------------|------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| Clientes    | ID_Cliente             | Identificador único do cliente                                                                                                                                    | smallint    |
| Clientes    | Primeiro_Nome          | Nome do cliente.                                                                                                                                                  | nvarchar    |
| Clientes    | Sobrenome              | Sobrenome do cliente.                                                                                                                                             | nvarchar    |
| Clientes    | Email                  | Endereço de e-mail do cliente                                                                                                                                     | nvarchar    |
| Clientes    | Genero                 | M (Masculino) ou F (Feminino).                                                                                                                                    | nchar       |
| Clientes    | Data_Nascimento        | Data de nascimento no formato AAAA/MM/AA                                                                                                                          | date        |
| Clientes    | Estado_Civil           | C (Casado), S (Solteiro)                                                                                                                                          | nchar       |
| Clientes    | Num_Filhos             | Número de filhos.                                                                                                                                                 | tinyint     |
| Clientes    | Nivel_Escolar          | Tipos de Escolaridade: (Ensino Médio Incompleto, Superior Incompleto, Ensino Médio Completo, Pós Graduação e Superior Completo).                                  | nvarchar    |
| Clientes    | Documento              | CPF ou RG                                                                                                                                                         | nvarchar    |
| Clientes    | Id_Localidade          | Código numérico que pode representar cidade, estado ou região                                                                                                     | tinyint     |
| Devolucoes  | Data_Devolucao         | Data em que a devolução foi realizada (formato DD/MM/AAAA).                                                                                                       | date        |
| Devolucoes  | Id_Loja                | Identificador único da loja onde a devolução foi feita.                                                                                                            | smallint    |
| Devolucoes  | SKU                    | Código do produto devolvido (exemplo HL45, HL164, etc.).                                                                                                          | nvarchar    |
| Devolucoes  | Qtde_Devolvida         | Quantidade de itens devolvidos (geralmente 1, mas há casos de 2).                                                                                                 | smallint    |
| Devolucoes  | Motivo_Devolucao       | Razão da devolução, como Produto com defeito (mais frequente), Arrependimento (cliente não quis mais o produto), Nao informado (motivo não especificado), Troca Indisponível (quando a troca não pôde ser realizada). | nvarchar |
| Devolucoes  | Id_Devolucao           | Identificador único de cada devolução                                                                                                                        | nvarchar    |
| Devolucoes  | Id_Item	               | Identificador único de cada item                                                                                                | nvarchar    |
| Itens       | Id_Venda               | Identificador único da venda (ex SO45079)                                                                                                                         | nvarchar    |
| Itens       | Ordem_Compra           | Número da ordem de compra                                                                                                                                         | tinyint     |
| Itens       | SKU                    | Código do produto vendido (ex HL45, HL59)                                                                                                                         | nvarchar    |
| Itens       | Quantidade_Vendida     | Quantidade vendida  
| Itens       | Id_Item				   | Identificador único do item                                                                                                                                              | tinyint     |
| Localidades | ID_Localidade          | Identificador numérico único                                                                                                                                      | tinyint     |
| Localidades | Pais                   | Nome do país                                                                                                                                                      | nvarchar    |
| Localidades | Continente             | Continente onde o país está localizado                                                                                                                            | nvarchar    |
| Lojas       | ID_Loja                | Identificador numérico único                                                                                                                                      | smallint    |
| Lojas       | Nome_Loja              | Nome da loja (inclui localização e número quando há múltiplas lojas na mesma cidade)                                                                              | nvarchar    |
| Lojas       | Quantidade_Colaboradores | Número de funcionários                                                                                                                                          | smallint    |
| Lojas       | Tipo                   | Física, Online ou Reseller                                                                                                                                        | nvarchar    |
| Lojas       | id_Localidade          | Identificador numérico único de cada localidade                                                                                                                   | tinyint     |
| Lojas       | Gerente_Loja           | Nome do gerente (sobrenome, nome)                                                                                                                                 | nvarchar    |
| Lojas       | Documento_Gerente      | Número de documento do gerente                                                                                                                                    | nvarchar    |
| Produtos    | SKU                    | Código identificador único                                                                                                                                        | nvarchar    |
| Produtos    | Produto                | Nome completo do produto                                                                                                                                          | nvarchar    |
| Produtos    | Marca                  | Fabricante                                                                                                                                                        | nvarchar    |
| Produtos    | Tipo_Produto           | Categoria principal                                                                                                                                               | nvarchar    |
| Produtos    | Preco_Unitario         | Preço de venda do produto                                                                                                                                         | decimal     |
| Produtos    | Custo_Unitario         | Custo do produto para a empresa                                                                                                                                   | decimal     |
| Vendas      | Id_Venda               | Identificador único da venda (ex SO45079)                                                                                                                         | nvarchar    |
| Vendas      | Data_Venda             | Data da venda no formato DD/MM/AAAA                                                                                                                               | date        |
| Vendas      | ID_Cliente             | Identificador do cliente                                                                                                                                          | smallint    |
| Vendas      | ID_Loja                | Identificador da loja                                                                                                                                             | smallint    |

