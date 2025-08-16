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

Os dados utilizados neste projeto foram extraídos do sistema ERP da empresa e fornecidos em formato CSV. Aqui está o <a href="https://github.com/DuduTrindade/Portifolio/tree/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/dados">Link</a>
dos arquivos utilizados neste projeto.

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

Aqui está o  <a href="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/Explora%C3%A7%C3%A3o%20dos%20Dados.sql">Link</a> para os scripts de Exploração dos dados


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

**Ações Tomadas:**

1. Normalização de nomes


>Ao analisar a tabela, identifiquei que as colunas *Primeiro_nome e Sobrenome* estão com todos os caracteres em letras maiúsculas, o que não corresponde ao formato padrão desejado.
>Para corrigir esse problema, utilizarei o comando `UPDATE` na tabela clientes, ajustando os registros para que apenas a primeira letra de cada nome e sobrenome fique em maiúscula, seguindo a convenção adequada.


<div align="center" style="display: inline-block;">
    <img  width="900" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tabela_clientes_caixaAlta.png">
</div>

<br><br>

2. Padronização campo data_nascimento

>A coluna *Data_Nascimento* está armazenada no formato padrão *AAAA-MM-DD* (ano-mês-dia), que é o formato nativo do SQL Server para o tipo de dados DATE. Este formato será mantido para permitir operações e cálculos com datas sem conversões.
>Para exibição no formato brasileiro *DD-MM-AAAA* (dia-mês-ano), utilizaremos as funções `CONVERT` ou `FORMAT` quando necessário, mantendo o armazenamento original.



<div align="center" style="display: inline-block;">
    <img  width="900" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tabela_clientes_conversaoData.png">
</div>
<br>



## **Tabela Devoluções**

<div align="center" style="display: inline-block;">
	<img  width="900" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tabela_devolucoes.png">
</div>

**Informações dos campos da tabela:**
- `Data_Devolucao`: Data em que a devolução foi realizada
- `ID_Loja`: Identificador único da loja onde a devolução foi feita.
- `SKU`: Código do produto devolvido
- `Qtd_Devolvida`: Quantidade de itens devolvidos (geralmente 1, mas há casos de 2).
- `Motivo_Devolucao`:  Razão da devolução, como Produto com defeito (mais frequente), Arrependimento (cliente não quis mais o produto), Nao informado (motivo não especificado), Troca Indisponível (quando a troca não pôde ser realizada).

**Problemas Encontrados:**

- ❌Valores duplicados

**Ações Tomadas:**

1. Verificação de Dados Duplicados

>Podemos observar que a tabela Devoluções possui 1 registro duplicado.

<div align="center" style="display: inline-block;">
	<img  width="900" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tabela_devolucoes_DUPLICATAS.png">
</div>

<br>

>Selecionando quais são os registros duplicados.

<div align="center" style="display: inline-block;">
	<img  width="900" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tabela_devolucoes_DUPLICATAS_selecionar.png">
</div>

<br>

>Apagando os registros duplicados

<div align="center" style="display: inline-block;">
	<img  width="900" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tabela_devolucoes_DELETENDO_DUPLICADOS.png">
</div>


## **Tabela Itens**
<div align="center" style="display: inline-block;">
	<img  width="900" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tabela_itens.png">
</div>

<br>

**Informações dos campos da tabela:**
- `Id_Venda`:	Identificador único da venda (ex SO45079)
- `Ordem_Compra`:	Número da ordem de compra
- `Data_Venda`:	Data da venda no formato DD/MM/AAAA
- `SKU`: Código do produto vendido (ex HL45, HL59)
- `ID_Cliente`:	Identificador do cliente
- `Qtd_Vendida`:	Quantidade vendida



**Problemas Encontrados:**

- 🆗✅Detecção de campos nulos
- 🆗✅Possíveis valores nulos ou duplicados
- 🆗✅Formato dos Dados

**Ações Tomadas:** <br>
Nenhuma ação necessária, os dados estão tratados e limpos.





## **Tabela Localidades**
<div align="center" style="display: inline-block;">
	<img  width="900" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tabela_localidades.png">
</div>

<br>

**Informações dos campos da tabela:**

- `ID_Localidade`: 	Identificador numérico único
- `Pais`: Nome do país
- `Continente`:	Continente onde o país está localizado

**Problemas Encontrados:**

- 🆗✅Detecção de campos nulos
- 🆗✅Possíveis valores nulos ou duplicados
- 🆗✅Formato dos Dados

**Ações Tomadas:** <br>
Nenhuma ação necessária, os dados estão tratados e limpos.

## **Tabela Lojas**
<div align="center" style="display: inline-block;">
	<img  width="900" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/TABELA_LOJAS.png">
</div>

<br>

**Informações dos campos da tabela:**

- `ID_Loja`:	Identificador numérico único
- `Nome_Loja`:	Nome da loja (inclui localização e número quando há múltiplas lojas na mesma cidade)
- `Quantidade_Colaboradores`:	Número de funcionários
- `Tipo`:	Física, Online ou Reseller
- `Id_Localidade`:	Identificador numérico único de cada localidade
- `Gerente_Loja`:	Nome do gerente (sobrenome, nome)
- `Documento_Gerente`:	Número de documento do gerente

<br>

**Problemas Encontrados:**

- 🆗✅Detecção de campos nulos
- 🆗✅Possíveis valores nulos ou duplicados
- 🆗✅Formato dos Dados

**Ações Tomadas:** <br>
Nenhuma ação necessária, os dados estão tratados e limpos.

## **Tabela Produtos**
<div align="center" style="display: inline-block;">
	<img  width="900" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tabela_produtos.png">
</div>

<br>

**Informações dos campos da tabela:**
- `SKU`:	Código identificador único
- `Produto`:	Nome completo do produto
- `Marca`:	Fabricante
- `Tipo_Produto`:	Categoria principal
- `Preco_Unitario`:	Preço de venda do produto
- `Custo_Unitario`:	Custo do produto para a empresa
- `Observacao`:	Comentários adicionais (vazio na maioria dos casos)

**Problemas Encontrados:**

- 🆗✅Detecção de campos nulos
- 🆗✅Possíveis valores nulos ou duplicados
- 🆗✅Formato dos Dados

**Ações Tomadas:** <br>
Nenhuma ação necessária, os dados estão tratados e limpos.

## **Tabela Vendas**
<div align="center" style="display: inline-block;">
	<img  width="900" src="">
</div>

📊 Conclusão da Etapa

Todos os dados brutos foram carregados no SQL Server com sucesso utilizando BULK INSERT.

A qualidade dos dados foi avaliada através de EDA (valores nulos, duplicados, inconsistências).

Foram aplicadas ações corretivas pontuais (ex.: exclusão de duplicatas, normalização de nomes, padronização de formatos).

O dataset resultante encontra-se padronizado, limpo e confiável, pronto para a Etapa 02 – Modelagem dos Dados.