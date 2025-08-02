-- Etapa 01: Importação e Tratamento dos Dados

WITH CTE_Duplicatas AS(
	SELECT 
		*
		,ROW_NUMBER() OVER(PARTITION BY ID_Cliente, Primeiro_Nome, Sobrenome, Email, Data_Nascimento									
						   ORDER BY ID_Cliente) AS Rn
	FROM Clientes
)
SELECT
	*
FROM CTE_Duplicatas
WHERE Rn > 1;








-- Verificar valores nulos


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


-- Remover Espaços vazios

BEGIN TRANSACTION;

UPDATE Clientes
    SET Primeiro_Nome   = TRIM(Primeiro_Nome),
        Sobrenome       = TRIM(Sobrenome),     
        Email           = TRIM(Email),          
        Genero          = TRIM(Genero),         
        Estado_Civil    = TRIM(Estado_Civil),      
        Nivel_Escolar   = TRIM(Nivel_Escolar),  
        Documento       = TRIM(Documento);



-- Validação dos tipos dos dados

SELECT 
    column_name AS 'Nome da Coluna',
    data_type AS 'Tipo de Dado'
FROM 
    information_schema.columns
WHERE 
    table_name = 'Clientes'
    AND table_schema NOT IN ('information_schema', 'pg_catalog')
ORDER BY 
    ordinal_position;