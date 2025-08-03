<h1>📥Etapa 01 - Importação e Tratamento dos Dados</h1> 

Os dados que utilizaremos estão dispostos em formato de arquivos csv extraídos do sistema da empresa. Esses dados serão importados para dentro do SQL Server, aonde realizarei toda a parte de tratamento e limpeza dos dados. Aqui está o <a href="https://github.com/DuduTrindade/Portifolio/tree/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/dados">Link</a> dos arquivos.

Os arquivos são compostos pelas seguintes tabelas:

<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tb.png">
</div>



O primeiro passo antes da importação dos dados é a criação do banco de dados no SQL Server. Para este projeto, o banco foi nomeado como Vendas_Nova_Varejo. Em seguida, prosseguimos com a criação das tabelas utilizando o comando **CREATE TABLE** nome_tabela, onde cada tabela é estruturada de acordo com os dados a serem importados.

Para importar os dados dos arquivos CSV para dentro das tabelas do banco, utilizarei o comando **BULK INSERT**.

Esse comando é usado para importar dados de arquivos externos (como .csv, .txt, etc.) diretamente para uma tabela do banco de dados de forma rápida e eficiente.


Aqui está o <a href="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/Importacao%20dos%20Dados.sql">Link</a> do script de importação dos dados:

<div align="center" style="display: inline-block;">
	<img  width="700" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tb_import.png">
</div>


## Exploração Inicial dos dados
A **Análise Exploratória de Dados (EDA** - *Exploratory Data Analysis*) é uma etapa fundamental no tratamento de dados, onde investigamos o conjunto de dados para entender suas características, identificar problemas e obter insights iniciais.

Passos a serem executados:

- 1.Verificação da estrutura (colunas, tipos de dados).

- 2.Identificação de valores ausentes (missing data). 

- 3.Detecteção duplicatas 

- 4.Padronização de datas, textos (uppercase/lowercase)

##
 
 ### Tabela Clientes

 *1.Verificação da estrutura (colunas)*

<div align="center" style="display: inline-block;">
	<img  width="700" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c1.png">
</div>

<br>
Descrição dos campos da tabela:
- **ID_Cliente**: Identificador único do cliente
- **Primeiro_Nome**: Nome do cliente.
- **Sobrenome**: Sobrenome do cliente.
- **Email**: Endereço de e-mail.
- **Genero**: M(Masculino) ou F(Feminino).
- **Data_Nascimento**: Data de nascimento no formato DD/MM/AAAA.
- **Estado_Civil**:	C(Casado) e S(Solteiro).
- **Num_Filhos**: Número de filhos.
- **Nivel_Escolar**: Escolaridade (ex: "Superior Completo", "Ensino Médio Incompleto").
- **Documento**: CPF ou RG
- **Id_Localidade**: Código numérico que pode representar cidade, estado ou região

<br><br>


*2.Identificação de valores ausentes (missing data)*

## **Tabela Devoluções**

<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c2.png">
</div>

## **Tabela Itens**
<div align="center" style="display: inline-block;">
	<img  width="500" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/c3.png">
</div>

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

## Limpeza dos dados
Agora iremos verificar como os dados estão dispostos em cada tabela do banco de dados. Trataremos os seguintes pontos:


- Tratamento de dados ausentes: Remoção ou preenchimento (imputação por média, mediana ou algoritmos).

- Correção de inconsistências: Padronização de datas, textos (uppercase/lowercase), unidades de medida.

- Remoção de duplicatas e dados irrelevantes.

- Filtragem de outliers (quando necessário).
