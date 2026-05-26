-- TRABALHO NOTAS DO FUTURO 12/05/2026 - UMC - ENGENHARIA DE SOFTWARE 

-- Criação, utilização e exclusão do Banco de Dados
CREATE DATABASE Notas_do_Futuro;
Use Notas_do_Futuro;

DROP DATABASE notas_do_futuro;

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
('Érika Rocha', 11252101010, 'ADM_Érika_Rocha', SHA2('minhasenha1011112', 224)),
('Jessé Lucatelli', 11252101010, 'ADM_Jessé_Lucatelli', SHA2('minhasenha121314', 224));

-- Inserção de usuários
INSERT INTO Usuario_Padrao (Email, SENHA, Nome) VALUES
('ana.silva@gmail.com', SHA2('Senha@123', 256), 'Ana Silva'),
('bruno.costa@hotmail.com', SHA2('Bruno#2026', 256), 'Bruno Costa'),
('carla.mendes@yahoo.com', SHA2('Carla456!', 256), 'Carla Mendes'),
('diego.alves@gmail.com', SHA2('Diego789@', 256), 'Diego Alves'),
('eduarda.rocha@outlook.com', SHA2('Edu123#', 256), 'Eduarda Rocha'),
('felipe.lima@gmail.com', SHA2('Felipe@321', 256), 'Felipe Lima'),
('gabriela.souza@yahoo.com', SHA2('Gabi#654', 256), 'Gabriela Souza'),
('henrique.pereira@hotmail.com', SHA2('Henrique@1', 256), 'Henrique Pereira'),
('isabela.castro@gmail.com', SHA2('Isa789#', 256), 'Isabela Castro'),
('joao.vieira@outlook.com', SHA2('Joao@2025', 256), 'João Vieira'),
('karina.martins@gmail.com', SHA2('Karina#777', 256), 'Karina Martins'),
('lucas.ribeiro@yahoo.com', SHA2('Lucas123!', 256), 'Lucas Ribeiro'),
('mariana.almeida@gmail.com', SHA2('Mari@456', 256), 'Mariana Almeida'),
('nicolas.barros@hotmail.com', SHA2('Nico#2024', 256), 'Nicolas Barros'),
('olivia.gomes@gmail.com', SHA2('Olivia@999', 256), 'Olivia Gomes'),
('paulo.teixeira@yahoo.com', SHA2('Paulo#111', 256), 'Paulo Teixeira'),
('quiteria.santos@outlook.com', SHA2('Quiteria@2', 256), 'Quitéria Santos'),
('rafael.cardoso@gmail.com', SHA2('Rafa321#', 256), 'Rafael Cardoso'),
('sabrina.ferreira@yahoo.com', SHA2('Sabri@555', 256), 'Sabrina Ferreira'),
('thiago.moraes@hotmail.com', SHA2('Thiago#88', 256), 'Thiago Moraes'),
('ursula.nunes@gmail.com', SHA2('Ursula@2026', 256), 'Úrsula Nunes'),
('vinicius.oliveira@yahoo.com', SHA2('Vini#123', 256), 'Vinícius Oliveira'),
('wendy.araujo@gmail.com', SHA2('Wendy@789', 256), 'Wendy Araújo'),
('xavier.campos@hotmail.com', SHA2('Xavier#01', 256), 'Xavier Campos'),
('yasmin.freitas@gmail.com', SHA2('Yasmin@456', 256), 'Yasmin Freitas'),
('zeca.batista@yahoo.com', SHA2('Zeca#999', 256), 'Zeca Batista'),
('aline.melo@gmail.com', SHA2('Aline@321', 256), 'Aline Melo'),
('bianca.dias@hotmail.com', SHA2('Bianca#2025', 256), 'Bianca Dias'),
('caio.torres@yahoo.com', SHA2('Caio@741', 256), 'Caio Torres'),
('daniela.ramos@gmail.com', SHA2('Dani#852', 256), 'Daniela Ramos'),
('enzo.pinto@outlook.com', SHA2('Enzo@159', 256), 'Enzo Pinto'),
('fabiana.cunha@gmail.com', SHA2('Fabi#753', 256), 'Fabiana Cunha'),
('gustavo.leal@yahoo.com', SHA2('Gusta@951', 256), 'Gustavo Leal'),
('helena.moreira@hotmail.com', SHA2('Helena#147', 256), 'Helena Moreira'),
('igor.machado@gmail.com', SHA2('Igor@258', 256), 'Igor Machado'),
('juliana.reis@yahoo.com', SHA2('JuReis#369', 256), 'Juliana Reis'),
('kevin.andrade@hotmail.com', SHA2('Kevin@753', 256), 'Kevin Andrade'),
('larissa.pires@gmail.com', SHA2('Lari#852', 256), 'Larissa Pires'),
('matheus.fonseca@yahoo.com', SHA2('Math@951', 256), 'Matheus Fonseca'),
('natalia.borges@gmail.com', SHA2('Naty#357', 256), 'Natália Borges');

-- Inserção de professores
INSERT INTO Professor (Email, Nome, Senha) VALUES
('carlos.almeida@universidade.com', 'Carlos Almeida', SHA2('Carlos@123', 256)),
('fernanda.lopes@universidade.com', 'Fernanda Lopes', SHA2('Fernanda#2026', 256)),
('ricardo.mendes@universidade.com', 'Ricardo Mendes', SHA2('Ricardo@456', 256)),
('patricia.souza@universidade.com', 'Patrícia Souza', SHA2('Patricia#789', 256)),
('marcos.pereira@universidade.com', 'Marcos Pereira', SHA2('Marcos@321', 256)),
('juliana.castro@universidade.com', 'Juliana Castro', SHA2('Juliana#654', 256)),
('andre.rocha@universidade.com', 'André Rocha', SHA2('Andre@987', 256)),
('camila.teixeira@universidade.com', 'Camila Teixeira', SHA2('Camila#852', 256)),
('roberto.lima@universidade.com', 'Roberto Lima', SHA2('Roberto@159', 256)),
('beatriz.ramos@universidade.com', 'Beatriz Ramos', SHA2('Beatriz#753', 256)),
('leonardo.cardoso@universidade.com', 'Leonardo Cardoso', SHA2('Leo@951', 256)),
('simone.barros@universidade.com', 'Simone Barros', SHA2('Simone#147', 256)),
('fabio.moraes@universidade.com', 'Fábio Moraes', SHA2('Fabio@258', 256)),
('renata.gomes@universidade.com', 'Renata Gomes', SHA2('Renata#369', 256)),
('eduardo.freitas@universidade.com', 'Eduardo Freitas', SHA2('Eduardo@741', 256)),
('aline.nunes@universidade.com', 'Aline Nunes', SHA2('Aline#852', 256)),
('gustavo.oliveira@universidade.com', 'Gustavo Oliveira', SHA2('Gustavo@963', 256)),
('tatiane.cunha@universidade.com', 'Tatiane Cunha', SHA2('Tatiane#159', 256)),
('henrique.dias@universidade.com', 'Henrique Dias', SHA2('Henrique@357', 256)),
('priscila.reis@universidade.com', 'Priscila Reis', SHA2('Priscila#951', 256)),
('rafaela.pinto@universidade.com', 'Rafaela Pinto', SHA2('Rafaela@111', 256)),
('thiago.machado@universidade.com', 'Thiago Machado', SHA2('Thiago#222', 256)),
('luciana.fonseca@universidade.com', 'Luciana Fonseca', SHA2('Luciana@333', 256)),
('vinicius.andrade@universidade.com', 'Vinícius Andrade', SHA2('Vinicius#444', 256)),
('cristiane.alves@universidade.com', 'Cristiane Alves', SHA2('Cristiane@555', 256)),
('paulo.costa@universidade.com', 'Paulo Costa', SHA2('Paulo#666', 256)),
('debora.santos@universidade.com', 'Débora Santos', SHA2('Debora@777', 256)),
('mateus.borges@universidade.com', 'Mateus Borges', SHA2('Mateus#888', 256)),
('daniela.campos@universidade.com', 'Daniela Campos', SHA2('Daniela@999', 256)),
('sergio.leal@universidade.com', 'Sérgio Leal', SHA2('Sergio#101', 256)),
('vanessa.vieira@universidade.com', 'Vanessa Vieira', SHA2('Vanessa@202', 256)),
('alexandre.melo@universidade.com', 'Alexandre Melo', SHA2('Alexandre#303', 256)),
('claudia.martins@universidade.com', 'Cláudia Martins', SHA2('Claudia@404', 256)),
('rodrigo.torres@universidade.com', 'Rodrigo Torres', SHA2('Rodrigo#505', 256)),
('isabela.ribeiro@universidade.com', 'Isabela Ribeiro', SHA2('Isabela@606', 256)),
('felipe.araujo@universidade.com', 'Felipe Araújo', SHA2('Felipe#707', 256)),
('monica.pereira@universidade.com', 'Mônica Pereira', SHA2('Monica@808', 256)),
('caio.mendes@universidade.com', 'Caio Mendes', SHA2('Caio#909', 256)),
('elaine.moreira@universidade.com', 'Elaine Moreira', SHA2('Elaine@010', 256)),
('wesley.lopes@universidade.com', 'Wesley Lopes', SHA2('Wesley#111', 256));

-- Inserção de regiões
INSERT INTO Regiao (Nome_Regiao) VALUES
('Norte'),
('Nordeste'),
('Centro-Oeste'),
('Sudeste'),
('Sul');

-- Inserir quizes dos estados 
INSERT INTO Quiz (Nome_Quiz) VALUES
('Quiz Acre'),
('Quiz Alagoas'),
('Quiz Amapá'),
('Quiz Amazonas'),
('Quiz Bahia'),
('Quiz Ceará'),
('Quiz Distrito Federal'),
('Quiz Espírito Santo'),
('Quiz Goiás'),
('Quiz Maranhão'),
('Quiz Mato Grosso'),
('Quiz Mato Grosso do Sul'),
('Quiz Minas Gerais'),
('Quiz Pará'),
('Quiz Paraíba'),
('Quiz Paraná'),
('Quiz Pernambuco'),
('Quiz Piauí'),
('Quiz Rio de Janeiro'),
('Quiz Rio Grande do Norte'),
('Quiz Rio Grande do Sul'),
('Quiz Rondônia'),
('Quiz Roraima'),
('Quiz Santa Catarina'),
('Quiz São Paulo'),
('Quiz Sergipe'),
('Quiz Tocantins');

-- Inserir Estados
INSERT INTO Estado (Nome_Estado, Sigla, ID_Regiao) VALUES
('Acre', 'AC', 1),
('Alagoas', 'AL', 2),
('Amapá', 'AP', 1),
('Amazonas', 'AM', 1),
('Bahia', 'BA', 2),
('Ceará', 'CE', 2),
('Distrito Federal', 'DF', 3),
('Espírito Santo', 'ES', 4),
('Goiás', 'GO', 3),
('Maranhão', 'MA', 2),
('Mato Grosso', 'MT', 3),
('Mato Grosso do Sul', 'MS', 3),
('Minas Gerais', 'MG', 4),
('Pará', 'PA', 1),
('Paraíba', 'PB', 2),
('Paraná', 'PR', 5),
('Pernambuco', 'PE', 2),
('Piauí', 'PI', 2),
('Rio de Janeiro', 'RJ', 4),
('Rio Grande do Norte', 'RN', 2),
('Rio Grande do Sul', 'RS', 5),
('Rondônia', 'RO', 1),
('Roraima', 'RR', 1),
('Santa Catarina', 'SC', 5),
('São Paulo', 'SP', 4),
('Sergipe', 'SE', 2),
('Tocantins', 'TO', 1);

-- Inserir Perfil do usuário
INSERT INTO Perfil_Usuario (Nome, Foto, ID_Usuario) VALUES
('Ana Silva', 'https://notasdofuturo.com/imagens/foto_ana.jpg', 1),
('Bruno Costa', 'https://notasdofuturo.com/imagens/foto_bruno.jpg', 2),
('Carla Mendes', 'https://notasdofuturo.com/imagens/foto_carla.jpg', 3),
('Diego Alves', 'https://notasdofuturo.com/imagens/foto_diego.jpg', 4),
('Eduarda Rocha', 'https://notasdofuturo.com/imagens/foto_eduarda.jpg', 5),
('Felipe Lima', 'https://notasdofuturo.com/imagens/foto_felipe.jpg', 6),
('Gabriela Souza', 'https://notasdofuturo.com/imagens/foto_gabriela.jpg', 7),
('Henrique Pereira', 'https://notasdofuturo.com/imagens/foto_henrique.jpg', 8),
('Isabela Castro', 'https://notasdofuturo.com/imagens/foto_isabela.jpg', 9),
('João Vieira', 'https://notasdofuturo.com/imagens/foto_joao.jpg', 10),
('Karina Martins', 'https://notasdofuturo.com/imagens/foto_karina.jpg', 11),
('Lucas Ribeiro', 'https://notasdofuturo.com/imagens/foto_lucas.jpg', 12),
('Mariana Almeida', 'https://notasdofuturo.com/imagens/foto_mariana.jpg', 13),
('Nicolas Barros', 'https://notasdofuturo.com/imagens/foto_nicolas.jpg', 14),
('Olivia Gomes', 'https://notasdofuturo.com/imagens/foto_olivia.jpg', 15),
('Paulo Teixeira', 'https://notasdofuturo.com/imagens/foto_paulo.jpg', 16),
('Quitéria Santos', 'https://notasdofuturo.com/imagens/foto_quiteria.jpg', 17),
('Rafael Cardoso', 'https://notasdofuturo.com/imagens/foto_rafael.jpg', 18),
('Sabrina Ferreira', 'https://notasdofuturo.com/imagens/foto_sabrina.jpg', 19),
('Thiago Moraes', 'https://notasdofuturo.com/imagens/foto_thiago.jpg', 20),
('Úrsula Nunes', 'https://notasdofuturo.com/imagens/foto_ursula.jpg', 21),
('Vinícius Oliveira', 'https://notasdofuturo.com/imagens/foto_vinicius.jpg', 22),
('Wendy Araújo', 'https://notasdofuturo.com/imagens/foto_wendy.jpg', 23),
('Xavier Campos', 'https://notasdofuturo.com/imagens/foto_xavier.jpg', 24),
('Yasmin Freitas', 'https://notasdofuturo.com/imagens/foto_yasmin.jpg', 25),
('Zeca Batista', 'https://notasdofuturo.com/imagens/foto_zeca.jpg', 26),
('Aline Melo', 'https://notasdofuturo.com/imagens/foto_aline.jpg', 27),
('Bianca Dias', 'https://notasdofuturo.com/imagens/foto_bianca.jpg', 28),
('Caio Torres', 'https://notasdofuturo.com/imagens/foto_caio.jpg', 29),
('Daniela Ramos', 'https://notasdofuturo.com/imagens/foto_daniela.jpg', 30),
('Enzo Pinto', 'https://notasdofuturo.com/imagens/foto_enzo.jpg', 31),
('Fabiana Cunha', 'https://notasdofuturo.com/imagens/foto_fabiana.jpg', 32),
('Gustavo Leal', 'https://notasdofuturo.com/imagens/foto_gustavo.jpg', 33),
('Helena Moreira', 'https://notasdofuturo.com/imagens/foto_helena.jpg', 34),
('Igor Machado', 'https://notasdofuturo.com/imagens/foto_igor.jpg', 35),
('Juliana Reis', 'https://notasdofuturo.com/imagens/foto_juliana.jpg', 36),
('Kevin Andrade', 'https://notasdofuturo.com/imagens/foto_kevin.jpg', 37),
('Larissa Pires', 'https://notasdofuturo.com/imagens/foto_larissa.jpg', 38),
('Matheus Fonseca', 'https://notasdofuturo.com/imagens/foto_matheus.jpg', 39),
('Natália Borges', 'https://notasdofuturo.com/imagens/foto_natalia.jpg', 40);

-- Inserir Info_Regiões
INSERT INTO Info_Regiao (Info_Regiao, ID_Regiao) VALUES
('A Região Norte é a maior do Brasil e abriga a impressionante Floresta Amazônica, considerada a maior floresta tropical do planeta.
Seus rios gigantescos, como o Amazonas, influenciam o clima mundial e escondem espécies que ainda nem foram totalmente descobertas.
Explorar a Região Norte é mergulhar em uma mistura fascinante de natureza extrema, culturas indígenas e riquezas naturais únicas.', 1),

('A Região Nordeste encanta pela força de sua cultura, pelas músicas marcantes e pelas tradições que atravessam gerações.
Além das praias paradisíacas e da culinária famosa, o Nordeste possui histórias de resistência, festas populares gigantescas e um povo conhecido pela hospitalidade.
Cada estado nordestino revela costumes, sotaques e paisagens que despertam curiosidade e admiração.', 2),

('A Região Centro-Oeste é conhecida por suas enormes áreas naturais e pelo papel essencial na produção agrícola brasileira.
O Pantanal, uma das maiores áreas alagadas do mundo, abriga animais impressionantes e cenários de tirar o fôlego.
Além disso, Brasília chama atenção por sua arquitetura moderna e importância política para todo o país.', 3),

('A Região Sudeste é o coração econômico do Brasil e reúne algumas das cidades mais influentes da América Latina.
Entre arranha-céus, centros tecnológicos, praias famosas e patrimônios históricos, a região mistura inovação, cultura e oportunidades.
É no Sudeste que tradição e modernidade convivem lado a lado, despertando interesse em diferentes áreas do conhecimento.', 4),

('A Região Sul chama atenção pelo clima mais frio, pelas paisagens verdes e pelas fortes influências europeias presentes na arquitetura e na culinária.
A região possui cidades organizadas, festas tradicionais e um turismo que vai desde serras até vinícolas famosas.
Conhecer o Sul é descobrir costumes únicos e uma diversidade cultural que diferencia a região do restante do país.', 5),

('A Amazônia, localizada principalmente na Região Norte, exerce influência direta no equilíbrio ambiental do planeta.
A floresta produz umidade, abriga milhões de espécies e desperta interesse científico no mundo inteiro.
Muitos pesquisadores acreditam que ainda existem segredos naturais e medicinais escondidos em suas matas.', 1),

('O Nordeste brasileiro vai muito além do turismo de praia e guarda riquezas históricas fundamentais para entender o Brasil.
Suas cidades históricas preservam construções coloniais, tradições religiosas e manifestações culturais extremamente importantes.
A região desperta curiosidade por unir beleza natural, história e identidade cultural forte.', 2),

('O Centro-Oeste possui paisagens naturais que impressionam pela grandiosidade e diversidade.
O encontro entre Cerrado, Pantanal e áreas agrícolas cria uma região estratégica para a economia e para o meio ambiente.
Além disso, o turismo ecológico atrai pessoas interessadas em aventura, natureza e observação da vida selvagem.', 3),

('A Região Sudeste concentra universidades renomadas, centros financeiros e importantes polos industriais do Brasil.
Ao mesmo tempo, preserva patrimônios históricos, museus, manifestações artísticas e eventos culturais conhecidos internacionalmente.
A região desperta interesse justamente por combinar desenvolvimento econômico com intensa diversidade cultural.', 4),

('A Região Sul é conhecida por suas tradições, pela gastronomia diferenciada e pelas paisagens naturais que mudam bastante durante o ano.
As temperaturas mais baixas favorecem experiências incomuns para muitos brasileiros, incluindo geadas e até neve em algumas cidades.
Entre montanhas, festas típicas e influência europeia, o Sul desperta curiosidade em quem busca cultura e turismo.', 5);

-- Inserir Notas
INSERT INTO Notas (Nota, ID_Quiz, ID_Usuario, ID_Professor) VALUES
(8.50, 1, 1, 1),
(7.25, 2, 2, 2),
(9.00, 3, 3, 3),
(6.75, 4, 4, 4),
(8.90, 5, 5, 5),
(7.80, 6, 6, 6),
(9.50, 7, 7, 7),
(5.60, 8, 8, 8),
(8.10, 9, 9, 9),
(7.95, 10, 10, 10),

(6.40, 11, 11, 11),
(9.20, 12, 12, 12),
(8.75, 13, 13, 13),
(7.10, 14, 14, 14),
(9.85, 15, 15, 15),
(6.95, 16, 16, 16),
(8.30, 17, 17, 17),
(7.45, 18, 18, 18),
(9.10, 19, 19, 19),
(5.90, 20, 20, 20),

(8.60, 21, 21, 21),
(7.70, 22, 22, 22),
(9.40, 23, 23, 23),
(6.80, 24, 24, 24),
(8.95, 25, 25, 25),
(7.35, 26, 26, 26),
(9.75, 27, 27, 27),
(6.20, 1, 28, 28),
(8.15, 2, 29, 29),
(7.55, 3, 30, 30),

(9.30, 4, 31, 31),
(5.75, 5, 32, 32),
(8.45, 6, 33, 33),
(7.90, 7, 34, 34),
(9.60, 8, 35, 35),
(6.50, 9, 36, 36),
(8.70, 10, 37, 37),
(7.05, 11, 38, 38),
(9.15, 12, 39, 39),
(6.85, 13, 40, 40);

-- Inserir perguntas
INSERT INTO Pergunta (Enunciado, ID_Quiz, ID_Estado) VALUES
('Qual é a capital do Acre?', 1, 1),
('Qual é a capital de Alagoas?', 2, 2),
('Qual estado brasileiro é cortado pela Linha do Equador e possui o Marco Zero?', 3, 3),
('Qual é o nome da maior floresta tropical do mundo presente no Amazonas?', 4, 4),
('Qual cidade da Bahia foi a primeira capital do Brasil?', 5, 5),
('Qual é a capital do Ceará?', 6, 6),
('Qual cidade planejada está localizada no Distrito Federal?', 7, 7),
('Qual é a capital do Espírito Santo?', 8, 8),
('Qual é a capital de Goiás?', 9, 9),
('Qual parque nacional famoso pelas dunas e lagoas está localizado no Maranhão?', 10, 10),
('Qual importante bioma está presente no Mato Grosso?', 11, 11),
('Qual bioma atrai turistas para o Mato Grosso do Sul?', 12, 12),
('Qual é a capital de Minas Gerais?', 13, 13),
('Qual é a capital do Pará?', 14, 14),
('Em qual capital da Paraíba o sol nasce primeiro nas Américas?', 15, 15),
('Qual é o nome da famosa usina hidrelétrica localizada no Paraná?', 16, 16),
('Qual é a capital de Pernambuco?', 17, 17),
('Qual parque arqueológico famoso está localizado no Piauí?', 18, 18),
('Qual monumento famoso está localizado no Rio de Janeiro?', 19, 19),
('Qual é a capital do Rio Grande do Norte?', 20, 20),
('Qual é a capital do Rio Grande do Sul?', 21, 21),
('Qual é a capital de Rondônia?', 22, 22),
('Qual é a capital de Roraima?', 23, 23),
('Qual é a capital de Santa Catarina?', 24, 24),
('Qual é a capital de São Paulo?', 25, 25),
('Qual é a capital de Sergipe?', 26, 26),
('Qual cidade planejada é a capital do Tocantins?', 27, 27);

INSERT INTO MiniJogo (Nome_Jogo, Tipo_Jogo, Descricao, ID_Regiao) VALUES
('Batidas da Amazônia', 'Musical',
'Combine sons da floresta, acompanhe ritmos indígenas e desbloqueie instrumentos tradicionais escondidos no coração da Amazônia.', 1),

('Forró Turbo', 'Musical',
'Entre em batalhas de dança eletrizantes no sertão nordestino e prove que seus reflexos conseguem acompanhar o ritmo acelerado da sanfona.', 2),

('Pantanal Selvagem', 'Aventura',
'Explore o Pantanal, fotografe animais raros e sobreviva aos desafios naturais enquanto descobre curiosidades da Região Centro-Oeste.', 3),

('Corrida Maluca Paulista', 'Corrida',
'Desvie do trânsito caótico, enfrente pistas urbanas insanas e descubra quem domina as ruas mais aceleradas do Sudeste.', 4),

('Lobisomem da Serra', 'Terror',
'Investigue lendas misteriosas em florestas cobertas por neblina e sobreviva às criaturas escondidas nas montanhas do Sul do Brasil.', 5);

INSERT INTO Alternativa (Descricao, Alternativa_Correta, ID_Pergunta) VALUES
-- Pergunta 1
('Rio Branco', TRUE, 1),
('Manaus', FALSE, 1),
('Belém', FALSE, 1),
('Porto Velho', FALSE, 1),

-- Pergunta 2
('Maceió', TRUE, 2),
('Recife', FALSE, 2),
('Natal', FALSE, 2),
('Aracaju', FALSE, 2),

-- Pergunta 3
('Amapá', TRUE, 3),
('Pará', FALSE, 3),
('Amazonas', FALSE, 3),
('Roraima', FALSE, 3),

-- Pergunta 4
('Floresta Amazônica', TRUE, 4),
('Mata Atlântica', FALSE, 4),
('Caatinga', FALSE, 4),
('Pantanal', FALSE, 4),

-- Pergunta 5
('Salvador', TRUE, 5),
('Porto Seguro', FALSE, 5),
('Feira de Santana', FALSE, 5),
('Ilhéus', FALSE, 5),

-- Pergunta 6
('Fortaleza', TRUE, 6),
('Sobral', FALSE, 6),
('Juazeiro do Norte', FALSE, 6),
('Caucaia', FALSE, 6),

-- Pergunta 7
('Brasília', TRUE, 7),
('Goiânia', FALSE, 7),
('Palmas', FALSE, 7),
('Cuiabá', FALSE, 7),

-- Pergunta 8
('Vitória', TRUE, 8),
('Vila Velha', FALSE, 8),
('Serra', FALSE, 8),
('Cariacica', FALSE, 8),

-- Pergunta 9
('Goiânia', TRUE, 9),
('Anápolis', FALSE, 9),
('Rio Verde', FALSE, 9),
('Catalão', FALSE, 9),

-- Pergunta 10
('Lençóis Maranhenses', TRUE, 10),
('Chapada Diamantina', FALSE, 10),
('Jalapão', FALSE, 10),
('Serra do Cipó', FALSE, 10),

-- Pergunta 11
('Cerrado', TRUE, 11),
('Pampa', FALSE, 11),
('Caatinga', FALSE, 11),
('Mata Atlântica', FALSE, 11),

-- Pergunta 12
('Pantanal', TRUE, 12),
('Amazônia', FALSE, 12),
('Caatinga', FALSE, 12),
('Pampa', FALSE, 12),

-- Pergunta 13
('Belo Horizonte', TRUE, 13),
('Uberlândia', FALSE, 13),
('Ouro Preto', FALSE, 13),
('Montes Claros', FALSE, 13),

-- Pergunta 14
('Belém', TRUE, 14),
('Santarém', FALSE, 14),
('Marabá', FALSE, 14),
('Altamira', FALSE, 14),

-- Pergunta 15
('João Pessoa', TRUE, 15),
('Campina Grande', FALSE, 15),
('Patos', FALSE, 15),
('Sousa', FALSE, 15),

-- Pergunta 16
('Itaipu', TRUE, 16),
('Belo Monte', FALSE, 16),
('Tucuruí', FALSE, 16),
('Xingó', FALSE, 16),

-- Pergunta 17
('Recife', TRUE, 17),
('Olinda', FALSE, 17),
('Caruaru', FALSE, 17),
('Petrolina', FALSE, 17),

-- Pergunta 18
('Serra da Capivara', TRUE, 18),
('Chapada dos Veadeiros', FALSE, 18),
('Lençóis Maranhenses', FALSE, 18),
('Aparados da Serra', FALSE, 18),

-- Pergunta 19
('Cristo Redentor', TRUE, 19),
('Pão de Açúcar', FALSE, 19),
('Maracanã', FALSE, 19),
('Escadaria Selarón', FALSE, 19),

-- Pergunta 20
('Natal', TRUE, 20),
('Mossoró', FALSE, 20),
('Parnamirim', FALSE, 20),
('Caicó', FALSE, 20),

-- Pergunta 21
('Porto Alegre', TRUE, 21),
('Caxias do Sul', FALSE, 21),
('Pelotas', FALSE, 21),
('Gramado', FALSE, 21),

-- Pergunta 22
('Porto Velho', TRUE, 22),
('Ji-Paraná', FALSE, 22),
('Ariquemes', FALSE, 22),
('Vilhena', FALSE, 22),

-- Pergunta 23
('Boa Vista', TRUE, 23),
('Pacaraima', FALSE, 23),
('Caracaraí', FALSE, 23),
('Mucajaí', FALSE, 23),

-- Pergunta 24
('Florianópolis', TRUE, 24),
('Joinville', FALSE, 24),
('Blumenau', FALSE, 24),
('Chapecó', FALSE, 24),

-- Pergunta 25
('São Paulo', TRUE, 25),
('Campinas', FALSE, 25),
('Santos', FALSE, 25),
('Sorocaba', FALSE, 25),

-- Pergunta 26
('Aracaju', TRUE, 26),
('Lagarto', FALSE, 26),
('Itabaiana', FALSE, 26),
('Estância', FALSE, 26),

-- Pergunta 27
('Palmas', TRUE, 27),
('Araguaína', FALSE, 27),
('Gurupi', FALSE, 27),
('Porto Nacional', FALSE, 27);


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
