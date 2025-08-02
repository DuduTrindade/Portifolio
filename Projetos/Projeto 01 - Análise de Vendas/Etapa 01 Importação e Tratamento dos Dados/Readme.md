# 📥Etapa 01 - Importação e Tratamento dos Dados
Os dados que utilizaremos estão dispostos em formato de arquivos csv extraídos do sistema da empresa. Esses dados serão importados para dentro do SQL Server, aonde realizarei toda a parte de tratamento e limpeza dos dados.

Os arquivos são compostos pelas seguintes tabelas:
<div align="center" style="display: inline-block;">
	<img  width="170" src="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/img/tb.png">
</div>



O primeiro passo antes da importação dos dados é a criação do banco de dados no SQL Server. Para este projeto, o banco foi nomeado como Vendas_Nova_Varejo. Em seguida, prosseguimos com a criação das tabelas utilizando o comando **CREATE TABLE** nome_tabela, onde cada tabela é estruturada de acordo com os dados a serem importados.

Para importar os dados dos arquivos CSV para dentro das tabelas do banco, utilizarei o comando **BULK INSERT**.

Esse comando é usado para importar dados de arquivos externos (como .csv, .txt, etc.) diretamente para uma tabela do banco de dados de forma rápida e eficiente.


Aqui está o script de importação dos dados: <a href="https://github.com/DuduTrindade/Portifolio/blob/main/Projetos/Projeto%2001%20-%20An%C3%A1lise%20de%20Vendas/Etapa%2001%20Importa%C3%A7%C3%A3o%20e%20Tratamento%20dos%20Dados/Importacao%20dos%20Dados.sql">link</a>


## Inspecionando as Tabelas Importadas

## Tratamento dos dados
Agora iremos verificar como os dados estão dispostos em cada tabela do banco de dados. Trataremos os seguintes pontos:

- Verificação dos dados
- Valores duplicados
- Valores nulos
- Verificação dos tipos de dados
- Totais de registros.
