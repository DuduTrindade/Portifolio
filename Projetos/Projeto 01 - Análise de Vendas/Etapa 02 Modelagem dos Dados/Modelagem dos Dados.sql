
-- Adiciona uma nova coluna Id_Devolucao como chave prim�ria
ALTER TABLE Devolucoes
    ADD Id_Devolucao SMALLINT PRIMARY KEY IDENTITY(1,1);