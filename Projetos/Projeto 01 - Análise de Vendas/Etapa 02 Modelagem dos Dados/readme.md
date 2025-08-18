## 🧱 Etapa 02 – Modelagem dos Dados

### 📖 Dicionário de Dados

### 📌 Diagrama ER completo (com chaves primárias, estrangeiras e cardinalidade).




### 🧭 Classificação Dimensão x Fato: Documente quais são suas tabelas fato e dimensão:

|Tabelas Fato (registram eventos)|	
|Vendas		|`Fato`|
|Itens		|`Fato`|	
|Devoluções	|`Fato`|

|Tabelas de 	Dimensão (contexto descritivo)|
|Produtos		|Dimensão	
|Clientes		|Dimensão
|Localidades	|Dimensão
|Lojas			|Dimensão
	



###🔐 Criação de índices nas tabelas fato (ex: Id_Cliente, SKU, Id_Loja) para melhorar performance.