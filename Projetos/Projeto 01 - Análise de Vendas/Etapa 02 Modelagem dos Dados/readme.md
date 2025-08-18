## 🧱 Etapa 02 – Modelagem dos Dados


### 📖 Dicionário de Dados

#### Tabela Clientes																										
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
| Itens       | Id_Venda               | Identificador único da venda (ex SO45079)                                                                                                                         | nvarchar    |
| Itens       | Ordem_Compra           | Número da ordem de compra                                                                                                                                         | tinyint     |
| Itens       | Data_Venda             | Data da venda no formato DD/MM/AAAA                                                                                                                               | date        |
| Itens       | SKU                    | Código do produto vendido (ex HL45, HL59)                                                                                                                         | nvarchar    |
| Itens       | ID_Cliente             | Identificador do cliente                                                                                                                                          | smallint    |
| Itens       | Quantidade_Vendida      | Quantidade vendida                                                                                                                                                | tinyint     |
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




### 📌 Diagrama ER completo (com chaves primárias, estrangeiras e cardinalidade).




### 🧭 Classificação Dimensão x Fato

Tabelas Fato (registram eventos)	
- Vendas
- Itens
- Devoluções

Tabelas de 	Dimensão (contexto descritivo)
- Produtos
- Clientes
- Localidades
- Lojas
	



### 🔐 Criação de índices nas tabelas fato (ex: Id_Cliente, SKU, Id_Loja) para melhorar performance.