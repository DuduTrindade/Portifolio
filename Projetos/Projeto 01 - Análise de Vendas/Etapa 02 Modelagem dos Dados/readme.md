## 🧱 Etapa 02 – Modelagem dos Dados


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


### 📌 Diagrama ER completo (com chaves primárias, estrangeiras e cardinalidade).





	



### 🔐 Criação de índices nas tabelas fato (ex: Id_Cliente, SKU, Id_Loja) para melhorar performance.