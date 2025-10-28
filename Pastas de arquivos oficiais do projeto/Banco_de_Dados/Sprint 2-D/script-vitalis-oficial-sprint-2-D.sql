/*
	BANCO DE DADOS - VITALIS
	Sistema para gerenciar empresas, cultivos de caju, leituras de sensores e produtividade.
*/

CREATE DATABASE vitalis;

use vitalis;
                    
show tables;

/* 
	TABELA: empresa
	Armazena informações das empresas parceiras, como a razão social, CNPJ e endereço.
*/

CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR (150) NOT NULL,
	cnpj CHAR(14) NOT NULL UNIQUE,
	dataEntrada DATETIME DEFAULT CURRENT_TIMESTAMP,
    email VARCHAR(100),
    senha VARCHAR(50),
    celular CHAR(11)	
);

INSERT INTO empresa (razaoSocial, cnpj, email, senha, celular) VALUES
	('AgroVale Indústria de Alimentos', '12345678000195', 'agrovale@gmail.com', 'agrovale123', '1253614264'),
	('Verde Monitoramento Ambiental', '98765432000110', 'verdemonitoramento@outlook.com', 'verdemonitor123', '21236547895'), 
	('CajuBrasil Companhia', '45678912000133', 'cajubrasil@gmail.com', 'cajubrasil123', '21236547895'),
	('Sol Nascente Produções Agrícolas', '11223344000177', 'nascentesol@gmail.com', 'solnascente0606', '21236547895'),
	('EcoSensores Monitoramento', '99887766000155', 'ecoSensores@gmail.com', 'ecoSensores123', '21236547895'),
	('NutriCaju Indústria de Beneficiamento', '22334455000166', 'natricaju_278@gmail.com', 'natri@caju', '21236547895'),
	('TechAgro Monitoramento Digital', '33445566000122', 'techagro@outlook.com', 'techagroagro444', '21236547895'),
	('Flor do Sertão Companhia', '44556677000188', 'florsertaneja@gmail.com', 'florsetao4500', '21236547895');
    
    select * from empresa;

/* TABELA: usuario. 
Dados do usario vindos do site. A empresa pode se cadastrar "sem usuário específico", 
porém dentro de sua página de perfil poderá cadastrar seus funcionários, que serão registrados na tabela "usuario",
com permissões para cada tipo de perfil profissional.
*/

CREATE TABLE usuario (
	idUsuario INT,
    apelidoUsuario VARCHAR (100),
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
	senha VARCHAR(50) NOT NULL,
    nivelCargo TINYINT NOT NULL,
    CONSTRAINT chkNivelCargo 
		CHECK (nivelCargo IN(1, 2, 3)),
	fkEmpresa INT,
    CONSTRAINT fkEmpresa
		FOREIGN KEY (fkEmpresa)
			REFERENCES 	empresa(idEmpresa),
	PRIMARY KEY (iDUsuario, fkEmpresa)
);
/* 'Estratégico'	- 1
	'Tático'		- 2
	'Operacional'	- 3
*/

INSERT INTO usuario VALUES 
	(1,'Joana Silva', '52136987412', 'contato@agrovale.com.br', 'Senha#2025', 1, 2),
	(2,'João Moraes', '56989871236', 'suporte@verdeambiental.com', 'Segura123!', 3, 2),
	(3,'Wilton Machado', '46789120001', 'rh@cajubrasil.com', 'Cajuzinho@2025', 2, 3),
	(4,'Solange Lima', '23344000177', 'admin@solnascente.com', 'ProdAgro!45', 3, 4),
	(5,'Arthur Franco', '97766000155', 'eco@ecosensores.com.br', 'Monitor#2025', 2, 5),
	(6,'Cássia Martins', '34455000166', 'contato@nutricaju.com.br', 'Ncaju_2025', 3, 8),
	(7,'Augusto Torres', '37566000122', 'info@techagro.com', 'Tech@2025', 1, 8),
	(8,'Flora Souza', '56677000188', 'comercial@florsertao.com.br', 'Flor2025!', 2, 7);
    
    select * from usuario;
    
/* TABELA: plantação.
 Engloba todo solo de arvores de caju plantadas. Cada empresa pode ter N plantações. Essas plantações serão separadas
 em lotes de pelo menos 256m², cada lote pode comportar N sensores.*/

CREATE TABLE plantacao(
	idPlantacao INT AUTO_INCREMENT,
	idLote CHAR(2),
    idSensor INT, 
    PRIMARY KEY (idPlantacao, idLote, idSensor),
    fkEmpresa INT,
    constraint fkEmpresaPlantacao 
		foreign key (fkEmpresa)
        references empresa(idEmpresa),
	coordSensor CHAR(2),
    sensorModelo VARCHAR(100)
);

INSERT INTO plantacao (idLote, idSensor, fkEmpresa, coordSensor, sensorModelo) VALUES
('A0', 1, 2, 'A0', 'Umidade Capacitivo'),
('A1', 1, 3, 'A1', 'Umidade Capacitivo'),
('A2', 2, 1, 'A2', 'Umidade Capacitivo'),
('A3', 2, 1, 'A3', 'Umidade Capacitivo'),
('A4', 5, 4, 'A4', 'Umidade Capacitivo'),
('A5', 6, 5, 'A5', 'Umidade Capacitivo'),
('A6', 7, 6, 'A6', 'Umidade Capacitivo');

	select * from plantacao;

SHOW INDEX FROM plantacao;
/* TABELA: Leitura do sensor.
Importante para conexão com a API que insere dados do arduino no BD. 
Cada lote terá um sensor, e cada sensor terá uma tabela de leitura. */ 

CREATE TABLE leituraSensor (
	dataLeitura DATETIME DEFAULT CURRENT_TIMESTAMP PRIMARY KEY,
	umidadeSolo DECIMAL(5,2) NOT NULL,
    fkPlantacao INT,
    fkLote CHAR(2),
    fkSensor INT,    
	CONSTRAINT fk_leitura_plantacao
		FOREIGN KEY (fkPlantacao, fkLote, fkSensor) REFERENCES plantacao (idPlantacao, idLote, idSensor)
);

INSERT INTO leituraSensor VALUES
(default, 123.25, 1, 'A0', 1);

select * from leituraSensor;

describe empresa;
describe usuario;
describe plantacao;
describe leituraSensor;
