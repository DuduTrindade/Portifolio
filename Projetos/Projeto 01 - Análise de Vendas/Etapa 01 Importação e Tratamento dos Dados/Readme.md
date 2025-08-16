# 📊 Etapa 01 - Importação e Tratamento de Dados

## 1. Introdução e Contexto

Nesta primeira etapa, focamos na **importação, validação e limpeza** dos dados que serão utilizados nas análises subsequentes.

**Objetivos principais:**
- Importar dados de múltiplas fontes CSV
- Realizar análise exploratória (EDA) completa
- Garantir a qualidade dos dados através de tratamentos adequados

**Tecnologias utilizadas:**
- 🛢️ `SQL Server` (SGBDR)
- 📋 Linguagem `T-SQL` (para scripts de importação e tratamento)

**Escopo do projeto:**
- 7 tabelas relacionadas ao processo de vendas
- Dados históricos de 3 anos
- Processo completo de ETL (Extract, Transform, Load)

## 2. Fontes de Dados

Os dados utilizados neste projeto foram extraídos do sistema ERP da empresa e fornecidos em formato CSV.

**Estrutura de arquivos:**


| Tabela     | Registros| Descrição                     										   | 
|------------|----------|--------------------------------------------------------------------------|
|Clientes    | 18148    |Contém informações cadastrais e demográficas detalhadas de cada clientes. |
|Devoluções  | 1809     |Registra as devoluções dos produtos.
|Itens		 | 56046	|Detalha os itens vendidos em cada venda.
|Localidades | 34		|Armazena informações geográficas das lojas.			
|Lojas		 | 306	    |Contém informações sobre as lojas.
|Produtos	 | 293      |Armazena informações sobre os produtos vendidos.
|Vendas      | 25164    |Registra as vendas realizadas.
       

## 3. Criação do Banco de Dados e das Tabelas


Aqui está o <a href= "https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/Importacao%20dos%20Dados.sql"> Link</a> dos scripts da Criação do Banco de Dados juntamente com as tabelas.

Principais Etapas Realizadas:

1) Estrutura do Banco: <br>
	✔Criei o banco Vendas_Nova_Varejo no SQL Server <br>
	✔Desenvolvi um modelo relacional alinhado ao negócio <br>
	✔Defini tipos de dados apropriados para cada campo <br>

2) Método de Importação<br>
Utilizei `BULK INSERT` por oferecer:
	- Alta eficiência com grandes volumes
	- Controle preciso sobre formatos
	- Performance superior a métodos alternativos


## 4. Exploração Inicial dos dados
A **Análise Exploratória de Dados (EDA** - *Exploratory Data Analysis*) é uma etapa fundamental no tratamento de dados, onde investigamos o conjunto de dados para entender suas características, identificar problemas e preparação para modelagem dos dados.

Técnicas aplicadas:

✅ Verificação de estrutura e tipos de dados

🔍 Identificação de valores ausentes (NULL)

🧹 Detecção e tratamento de duplicatas

📐 Padronização de formatos (datas, textos)

🚨 Identificação de outliers e inconsistências


 ## 4.1 Tabela Clientes


<div align="center" style="display: inline-block;">
	<img  width="900" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tabela_clientes.png">
</div>

<br>

**Informações dos campos da tabela:**
- `Cliente_ID`: Identificador único do cliente
- `Primeiro_nome`: Nome do cliente
- `Sobrenome`: Sobrenome do cliente
- `Email`:Endereço de e-mail do cliente
- `Genero`:M(Masculino) ou F(Feminino).
- `Data_Nascimento`: Data de nascimento no formatoAAAA/MM/AA
- `Estado_Civil`:C(Casado), S(Solteiro)
- `Num_Filhos`:Número de filhos.
- `Nivel_Escolar`:(Ensino Médio Incompleto, Superior Incompleto, Ensino Médio Completo, Pós Graduação e Superior Completo).
- `Documento`:Possivelmente CPF ou RG
- `Id_Localidade`:Código numérico que pode representar cidade, estado ou região


**Problemas Encontrados:**
- ❌Nomes e sobrenomes em CAIXA ALTA
- ❌Formato de data padrão americano
- ❌Possíveis valores nulos ou duplicados

**Ações Tomadas::**

1. Normalização de nomes


>Ao analisar a tabela, identifiquei que as colunas *Primeiro_nome e Sobrenome* estão com todos os caracteres em letras maiúsculas, o que não corresponde ao formato padrão desejado.
>Para corrigir esse problema, utilizarei o comando **UPDATE** na tabela clientes, ajustando os registros para que apenas a primeira letra de cada nome e sobrenome fique em maiúscula, seguindo a convenção adequada.


 ~~~sql
BEGIN TRANSACTION;

UPDATE Clientes
	SET Primeiro_Nome = UPPER(LEFT(Primeiro_Nome, 1)) + LOWER(SUBSTRING(Primeiro_Nome, 2, LEN(Primeiro_Nome)))

UPDATE Clientes
	SET Sobrenome = UPPER(LEFT(Sobrenome, 1)) + LOWER(SUBSTRING(Sobrenome, 2, LEN(Sobrenome)))

COMMIT;

SELECT TOP 15 * FROM Clientes
~~~
<div align="center" style="display: inline-block;">
    <img  width="700" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tbClientes_maiusculo.png">
</div>

<br><br>

2. Padronização campo data_nascimento

>A coluna *Data_Nascimento* está armazenada no formato padrão *AAAA-MM-DD* (ano-mês-dia), que é o formato nativo do SQL Server para o tipo de dados DATE. Este formato será mantido para permitir operações e cálculos com datas sem conversões.
>Para exibição no formato brasileiro *DD-MM-AAAA* (dia-mês-ano), utilizaremos as funções **CONVERT ou FORMAT** quando necessário, mantendo o armazenamento original.

~~~sql
-- Conversão campo data de nascimento
SELECT TOP 15
    Data_Nascimento,
    CONVERT(VARCHAR, Data_Nascimento, 105) AS data_convertida,
    FORMAT(Data_Nascimento, 'dd-MM-yyyy') AS data_formatada
FROM Clientes

~~~

<div align="center" style="display: inline-block;">
    <img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tbClientes_DataNas.png">
</div>
<br>


3. Identificação de campos nulos

>Outra validação que devemos fazer na tabela clientes é de *Identificação de valores ausentes (missing data)*, ou seja, verificar se a tabela possui algum campo com valores nulos.

~~~sql
--Identificação de valores ausentes (missing data)

SELECT
    *
FROM Clientes
WHERE 
    ID_Cliente      IS NULL OR
    Primeiro_Nome   IS NULL OR
    Sobrenome       IS NULL OR
    Email           IS NULL OR
    Genero          IS NULL OR
    Data_Nascimento IS NULL OR
    Estado_Civil    IS NULL OR
    Num_Filhos      IS NULL OR
    Nivel_Escolar   IS NULL OR
    Documento       IS NULL OR
    Id_Localidade   IS NULL;
~~~

<div align="center" style="display: inline-block;">
	<img  width="700" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tbClientes_nulos.png">
</div>
<br>

**Resultado**: ✅A tabela Clientes não possui campos com *valores nulos*.
<br><br>

4. Verificação de Duplicatas

>Dados duplicados podem distorcer nossas análises, por isso devemos realizar *Detecteção de duplicatas*.

```sql
--Detecteção duplicatas

WITH CTE_Duplicatas AS(
	SELECT 
		*
		,ROW_NUMBER() OVER(PARTITION BY ID_Cliente, Primeiro_Nome, Sobrenome, Email, Data_Nascimento, Estado_Civil,
                            Num_filhos, Nivel_Escolar, Documento, Id_Localidade
						   ORDER BY ID_Cliente) AS Rn
	FROM Clientes
)
SELECT
	*
FROM CTE_Duplicatas
WHERE Rn > 1;
```

<div align="center" style="display: inline-block;">
	<img  width="700" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tbClientes_nulos.png">
</div>

<br>

**Resultado**: ✅A tabela Clientes não possui campos com *valores duplicados*.
<br><br>



## **Tabela Devoluções**

<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tbDevolucoes.png">
</div>

**Informações dos campos da tabela:**
- `Data_Devolucao`: Data em que a devolução foi realizada
- `ID_Loja`: Identificador único da loja onde a devolução foi feita.
- `SKU`: Código do produto devolvido
- `Qtd_Devolvida`: Quantidade de itens devolvidos (geralmente 1, mas há casos de 2).
- `Motivo_Devolucao`:  Razão da devolução, como Produto com defeito (mais frequente), Arrependimento (cliente não quis mais o produto), Nao informado (motivo não especificado), Troca Indisponível (quando a troca não pôde ser realizada).


## **Tabela Itens**
<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tbDevolucoes.png">
</div>

**Problemas Encontrados:**
- ❌Detecção de campos nulos
- ❌Possíveis valores nulos ou duplicados

**Ações Tomadas::**













## **Tabela Localidades**
<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c4.png">
</div>

## **Tabela Lojas**
<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c5.png">
</div>

## **Tabela Produtos**
<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c6.png">
</div>

## **Tabela Vendas**
<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c7.png">
</div>

