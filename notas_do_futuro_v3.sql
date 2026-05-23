-- TRABALHO NOTAS DO FUTURO 12/05/2026 - UMC - ENGENHARIA DE SOFTWARE 

-- Criação, utilização e exclusão do Banco de Dados
CREATE DATABASE Notas_do_Futuro;
Use Notas_do_Futuro;

-- DROP DATABASE notas_do_futuro;

CREATE TABLE ADM(
ID_Adm SMALLINT AUTO_INCREMENT,
Nome VARCHAR (100),
Login_usuario_Adm VARCHAR (50) NOT NULL UNIQUE,
SENHA VARCHAR (255) NOT NULL,
CONSTRAINT pk_ID_Adm PRIMARY KEY (ID_Adm)
) AUTO_INCREMENT = 100;

CREATE TABLE Usuario_Padrao
(ID_Usuario SMALLINT AUTO_INCREMENT,
Email VARCHAR (100) NOT NULL UNIQUE,
SENHA VARCHAR (255) NOT NULL,
Nome VARCHAR (100),
CONSTRAINT pk_ID_Usuario PRIMARY KEY (ID_Usuario)
); 

CREATE TABLE Professor
(ID_Professor SMALLINT AUTO_INCREMENT,
Email VARCHAR (100) NOT NULL UNIQUE,
Nome VARCHAR (100),
Senha VARCHAR (255) NOT NULL,
CONSTRAINT pk_ID_Professor PRIMARY KEY (ID_Professor)
);

CREATE TABLE Regiao
(ID_Regiao SMALLINT AUTO_INCREMENT,
Nome_Regiao VARCHAR (50) UNIQUE,
CONSTRAINT pk_ID_Regiao PRIMARY KEY (ID_Regiao)
); 

CREATE TABLE Quiz
(ID_Quiz SMALLINT AUTO_INCREMENT,
Nome_Quiz VARCHAR (50) UNIQUE,
CONSTRAINT pk_ID_Quiz PRIMARY KEY (ID_Quiz)
); 

CREATE TABLE Estado
(ID_Estado SMALLINT AUTO_INCREMENT,
Nome_Estado VARCHAR (50) UNIQUE,
Sigla CHAR(2) UNIQUE NOT NULL,
ID_Regiao SMALLINT NOT NULL,
CONSTRAINT fk_ID_Regiao FOREIGN KEY (ID_Regiao)
REFERENCES Regiao (ID_Regiao) ON DELETE CASCADE,
CONSTRAINT pk_ID_Estado PRIMARY KEY (ID_Estado)
); 

CREATE TABLE Perfil_Usuario
(Id_Perfil SMALLINT AUTO_INCREMENT,
Nome VARCHAR (100),
Foto VARCHAR(255),
ID_Usuario SMALLINT NOT NULL,
CONSTRAINT fk_ID_Usuario FOREIGN KEY (ID_Usuario)
REFERENCES Usuario_Padrao (ID_Usuario),
CONSTRAINT pk_ID_Perfil PRIMARY KEY (ID_Perfil)
);

CREATE TABLE Info_Regiao
(ID_Info_Regiao SMALLINT AUTO_INCREMENT,
Info_Regiao TEXT NOT NULL,
ID_Regiao SMALLINT NOT NULL,
CONSTRAINT fk_ID_Info_Regiao FOREIGN KEY (ID_Regiao)
REFERENCES Regiao (ID_Regiao),
CONSTRAINT pk_ID_Info_Regiao PRIMARY KEY (ID_Info_Regiao)
);

CREATE TABLE Notas
(ID_Nota SMALLINT AUTO_INCREMENT,
Nota DECIMAL(4,2) NOT NULL,
ID_Quiz SMALLINT NOT NULL,
ID_Usuario SMALLINT NOT NULL,
ID_Professor SMALLINT,
CONSTRAINT pk_ID_Nota PRIMARY KEY (ID_Nota),
CONSTRAINT fk_Nota_Usuario FOREIGN KEY (Id_Usuario)
REFERENCES Usuario_Padrao (ID_Usuario),
CONSTRAINT fk_Quiz FOREIGN KEY (ID_Quiz)
REFERENCES Quiz (ID_Quiz),
CONSTRAINT fk_Notas_Professor FOREIGN KEY (ID_Professor)
REFERENCES Professor (ID_Professor)
);

CREATE TABLE Pergunta
(ID_Pergunta SMALLINT AUTO_INCREMENT,
Enunciado TEXT NOT NULL,
ID_Quiz SMALLINT NOT NULL,
ID_Estado SMALLINT NOT NULL,	
CONSTRAINT pk_ID_Pergunta PRIMARY KEY (ID_Pergunta),
CONSTRAINT fk_Pergunta_Quiz FOREIGN KEY (ID_Quiz)
REFERENCES Quiz (ID_Quiz),
CONSTRAINT fk_Pergunta_Estado FOREIGN KEY (ID_Estado) 
REFERENCES Estado(ID_Estado) ON DELETE CASCADE
);

CREATE TABLE MiniJogo
(ID_MiniJogo SMALLINT AUTO_INCREMENT,
Nome_Jogo VARCHAR (100) UNIQUE NOT NULL,
Tipo_Jogo VARCHAR (30) NOT NULL,
Descricao TEXT NOT NULL,
ID_Regiao SMALLINT NOT NULL,
CONSTRAINT pk_ID_MiniJogo PRIMARY KEY (ID_MiniJogo),
CONSTRAINT fk_MiniJogo_Regiao FOREIGN KEY (ID_Regiao)
REFERENCES Regiao (ID_Regiao)
);

CREATE TABLE Alternativa
(ID_Alternativa SMALLINT AUTO_INCREMENT,
Descricao TEXT NOT NULL,
Alternativa_Correta BOOLEAN DEFAULT FALSE,
ID_Pergunta SMALLINT NOT NULL,
CONSTRAINT pk_ID_Alternativa PRIMARY KEY (ID_Alternativa),
CONSTRAINT fk_ID_Pergunta FOREIGN KEY (ID_Pergunta)
REFERENCES Pergunta (ID_Pergunta)
);

CREATE TABLE Gerenciar (
ID_ADM SMALLINT,
ID_Usuario SMALLINT,
Data_Gerenciamento DATETIME DEFAULT CURRENT_TIMESTAMP, 
PRIMARY KEY (ID_ADM, ID_Usuario),
CONSTRAINT fk_gerenciar_adm FOREIGN KEY (ID_ADM) 
REFERENCES ADM(ID_ADM) ON DELETE CASCADE,
CONSTRAINT fk_gerenciar_usuario FOREIGN KEY (ID_Usuario) 
REFERENCES Usuario_Padrao(ID_Usuario) ON DELETE CASCADE
);

CREATE TABLE Consultar (
ID_Usuario SMALLINT,
ID_nota SMALLINT,
Data_da_Consulta DATETIME DEFAULT CURRENT_TIMESTAMP, 
PRIMARY KEY (ID_Usuario, ID_nota), 
CONSTRAINT fk_consultar_usuario FOREIGN KEY (ID_Usuario) 
REFERENCES Usuario_Padrao(ID_Usuario) ON DELETE CASCADE,
CONSTRAINT fk_consultar_nota FOREIGN KEY (ID_nota) 
REFERENCES Notas(ID_nota) ON DELETE CASCADE
);

	CREATE TABLE Modificar_Nota (
	ID_Professor SMALLINT,
	ID_nota SMALLINT,
	Ultima_Alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (ID_Professor, ID_nota),
	CONSTRAINT fk_modificar_professor FOREIGN KEY (ID_Professor) 
	REFERENCES Professor(ID_Professor) ON DELETE CASCADE,
	CONSTRAINT fk_modificar_nota FOREIGN KEY (ID_nota) 
	REFERENCES Notas(ID_nota) ON DELETE CASCADE
	);

CREATE TABLE Log_Modificar_Nota (
    ID_Log INT AUTO_INCREMENT PRIMARY KEY,
    ID_Professor SMALLINT,
    ID_nota SMALLINT,
    Data_Alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Acao VARCHAR(50) DEFAULT 'ALTERACAO',
    CONSTRAINT fk_log_professor FOREIGN KEY (ID_Professor) 
	REFERENCES Professor(ID_Professor) ON DELETE CASCADE,
    CONSTRAINT fk_log_nota FOREIGN KEY (ID_nota) 
	REFERENCES Notas(ID_nota) ON DELETE CASCADE
);

CREATE TABLE Interacao
(
ID_Usuario SMALLINT,
ID_Regiao SMALLINT,
Data_Interacao DATETIME DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (ID_Usuario, ID_Regiao),
CONSTRAINT fk_ID_Usuario_Int FOREIGN KEY (ID_Usuario)
REFERENCES Usuario_Padrao (ID_Usuario) ON DELETE CASCADE,
CONSTRAINT fk_ID_Regiao_Int FOREIGN KEY (ID_Regiao)
REFERENCES Regiao (ID_Regiao) ON DELETE CASCADE
);

-- Criação, alteração e exclusão de tabelas
ALTER TABLE ADM	
ADD Bio_Professor TEXT;
ALTER TABLE ADM
MODIFY Bio_Professor VARCHAR (255);
ALTER TABLE ADM
DROP COLUMN Bio_Professor;

CREATE TABLE Coordenacao
(Id_Coordenacao SMALLINT AUTO_INCREMENT,
Nome_Coordenador VARCHAR (100),
CONSTRAINT pk_ID_Coordenacao PRIMARY KEY (ID_Coordenacao)
);
DROP TABLE Coordenacao;
ALTER TABLE Adm
ADD RGM SMALLINT NOT NULL;
ALTER TABLE ADM
MODIFY RGM CHAR(11) NOT NULL;
-- Inserção, atualização e exclusão de Dados
INSERT INTO Adm (Nome, RGM, Login_usuario_Adm, Senha)
VALUES ('Jessica Claro', 11252100357, 'ADM_Jessica_Claro', SHA2('minhasenha123', 512)),
('Paloma Bichler', 11261405986, 'ADM_Paloma_Bichler', SHA2('minhasenha456', 224)),
('Beatriz Alves', 11252102196, 'ADM_Beatriz_Alves', SHA2('minhasenha789', 224)),
('Érika Rocha', 11252101010, 'ADM_Érika_Rocha', SHA2('minhasenha1011112', 224));

-- Consulta de Tabelas
SELECT * FROM Adm;
SELECT * FROM Alternativa;
SELECT * FROM Consultar;
SELECT * FROM Estado;
SELECT * FROM Gerenciar;
SELECT * FROM Info_regiao;
SELECT * FROM Interacao;
SELECT * FROM MiniJogo;
SELECT * FROM Modificar_nota;
SELECT * FROM Notas;
SELECT * FROM Perfil_Usuario;
SELECT * FROM Pergunta;
SELECT * FROM Professor;
SELECT * FROM Quiz;
SELECT * FROM Regiao;
SELECT * FROM Usuario_Padrao;

DESC Adm;

-- DISTINCT Ignora valores duplicados EX SELECT DISTINCT Pergunta;

-- BEATRIZ 
INSERT INTO Regiao (Nome_Regiao) VALUES
('Sudeste'),
('Sul'),
('Nordeste');

INSERT INTO Usuario_Padrao (Email, SENHA, Nome) VALUES
('ana@gmail.com', SHA2('123',256), 'Ana Silva'),
('bruno@gmail.com', SHA2('456',256), 'Bruno Souza'),
('carla@gmail.com', SHA2('789',256), 'Carla Lima');



INSERT INTO Estado (Nome_Estado, Sigla, ID_Regiao) VALUES
('São Paulo', 'SP', 1),
('Paraná', 'PR', 2),
('Bahia', 'BA', 3);

explain analyze select * from Estado where sigla = 'SP';

CREATE UNIQUE INDEX idx_sigla_estado ON Estado (Sigla);

INSERT INTO Professor (Email, Nome, Senha) VALUES
('prof1@gmail.com', 'Carlos Mendes', SHA2('abc',256)),
('prof2@gmail.com', 'Juliana Alves', SHA2('def',256)),
('prof3@gmail.com', 'Ricardo Gomes', SHA2('ghi',256));


INSERT INTO Perfil_Usuario (Nome, Foto, ID_Usuario) VALUES
('Ana Perfil', 'foto1.jpg', 1),
('Bruno Perfil', 'foto2.jpg', 2),
('Carla Perfil', 'foto3.jpg', 3);

INSERT INTO Info_Regiao (Info_Regiao, ID_Regiao) VALUES
('Região mais populosa', 1),
('Clima mais frio', 2),
('Cultura rica e diversa', 3);

INSERT INTO MiniJogo (Nome_Jogo, Tipo_Jogo, Descricao, ID_Regiao) VALUES
('Jogo Sudeste', 'Quiz', 'Perguntas sobre Sudeste', 1),
('Jogo Sul', 'Puzzle', 'Desafios do Sul', 2),
('Jogo Nordeste', 'Trivia', 'Curiosidades do Nordeste', 3);

INSERT INTO Pergunta (Enunciado, ID_Quiz, ID_Estado) VALUES
('Qual a capital de SP?', 1, 1),
('Qual a capital do PR?', 1, 2),
('Qual a capital da BA?', 1, 3);

INSERT INTO Alternativa (Descricao, Alternativa_Correta, ID_Pergunta) VALUES
('São Paulo', TRUE, 1),
('Curitiba', TRUE, 2),
('Salvador', TRUE, 3);

INSERT INTO Notas (Nota, ID_Quiz, ID_Usuario, ID_Professor) VALUES
(8.5, 1, 1, 1),
(7.0, 2, 2, 2),
(9.0, 3, 3, 3);

INSERT INTO Gerenciar (ID_ADM, ID_Usuario) VALUES
(100, 1),
(101, 2),
(102, 3);

INSERT INTO Consultar (ID_Usuario, ID_nota) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Modificar_Nota (ID_Professor, ID_nota) VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Log_Modificar_Nota (ID_Professor, ID_nota, Acao) VALUES
(1, 1, 'ALTERACAO'),
(2, 2, 'ALTERACAO'),
(3, 3, 'ALTERACAO');

INSERT INTO Interacao (ID_Usuario, ID_Regiao) VALUES
(1, 1),
(2, 2),
(3, 3);


