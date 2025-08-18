## 🧱 Etapa 02 – Modelagem dos Dados


### 📖 Dicionário de Dados
|Tabela Clientes
| Campo            | Descrição do campo                                                                 | Tipo do dado   |
|------------------|-----------------------------------------------------------------------------------|---------------|
| ID_Cliente       | Identificador único do cliente                                                    | smallint      |
| Primeiro_Nome    | Nome do cliente.                                                                  | nvarchar      |
| Sobrenome        | Sobrenome do cliente.                                                             | nvarchar      |
| Email            | Endereço de e-mail do cliente                                                     | nvarchar      |
| Genero           | M (Masculino) ou F (Feminino).                                                   | nchar         |
| Data_Nascimento  | Data de nascimento no formato AAAA/MM/AA                                          | date          |
| Estado_Civil     | C (Casado), S (Solteiro)                                                         | nchar         |
| Num_Filhos       | Número de filhos.                                                                 | tinyint       |
| Nivel_Escolar    | (Ensino Médio Incompleto, Superior Incompleto, Ensino Médio Completo, Pós Graduação e Superior Completo). | nvarchar |
| Documento        | CPF ou RG                                                                         | nvarchar      |
| Id_Localidade    | Código numérico que pode representar cidade, estado ou região                    | tinyint       |

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