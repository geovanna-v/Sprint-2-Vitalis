/*
	BANCO DE DADOS - VITALIS
	Sistema para gerenciar empresas, cultivos de caju, leituras de sensores e produtividade.
*/

CREATE DATABASE vitalis;

use vitalis;
                    
show tables;

describe empresa;
describe usuario;
describe plantacaoEmpresa;
describe lotesPlantacao;
describe sensorLote;
describe leituraSensor;

/* 
	TABELA: empresa
	Armazena informações das empresas parceiras, como nome, CNPJ, contato, perfil e nível de cargo.
*/

CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR (150) NOT NULL,
	cnpj CHAR(14) NOT NULL UNIQUE,
    cep CHAR(8),
    numero VARCHAR(45),
    bairro VARCHAR(100)
);

INSERT INTO empresa (razaoSocial, cnpj) VALUES
	('AgroVale Indústria de Alimentos', '12345678000195'),
	('Verde Monitoramento Ambiental', '98765432000110'),
	('CajuBrasil Companhia', '45678912000133'),
	('Sol Nascente Produções Agrícolas', '11223344000177'),
	('EcoSensores Monitoramento', '99887766000155'),
	('NutriCaju Indústria de Beneficiamento', '22334455000166'),
	('TechAgro Monitoramento Digital', '33445566000122'),
	('Flor do Sertão Companhia', '44556677000188');

/* Tabela usuario, dados do usario */

CREATE TABLE usuario (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR (100),
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
	senha VARCHAR(50) NOT NULL,
	celular CHAR(11) NOT NULL UNIQUE,
    nivelCargo TINYINT NOT NULL,
    CONSTRAINT chkNivelCargo 
		CHECK (nivelCargo IN(1, 2, 3, 99))
);
/* 'Estratégico'	- 1
	'Tático'		- 2
	'Operacional'	- 3
	'DESENVOLVEDOR' - 99
*/

INSERT INTO usuario (nome, cpf, email, senha, celular, nivelCargo) VALUES 
	('Joana Silva', '52136987412', 'contato@agrovale.com.br', 'Senha#2025', '11987654321', 1),
	('João Moraes', '56989871236', 'suporte@verdeambiental.com', 'Segura123!', '21999887766', 3),
	('Wilton Machado', '46789120001', 'rh@cajubrasil.com', 'Cajuzinho@2025', '81991234567', 2),
	('Solange Lima', '23344000177', 'admin@solnascente.com', 'ProdAgro!45', '62999881234', 3),
	('Arthur Franco' '97766000155', 'eco@ecosensores.com.br', 'Monitor#2025', '31988776655', 2),
	('Cássia Martins', '34455000166', 'contato@nutricaju.com.br', 'Ncaju_2025', '71999887744', 3),
	('Augusto Torres', '37566000122', 'info@techagro.com', 'Tech@2025', '11988776655', 1),
	('Flora Souza', '56677000188', 'comercial@florsertao.com.br', 'Flor2025!', '85991237890', 2);
    
/* Tabela plantação, engloba todo solo de cajueiros plantados */

CREATE TABLE plantacaoEmpresa(
	idPlantacao INT PRIMARY KEY AUTO_INCREMENT,
	areaHec DECIMAL (7,3) NOT NULL,
    tipoSolo varchar(100),
    fkEmpresa int,
    constraint fkEmpresa 
		foreign key (fkEmpresa)
        references empresa(idEmpresa)
);

INSERT INTO plantacaoEmpresa (areaHec, tipoSolo, fkEmpresa) VALUES
(2500.000, 'Arenoso', 2),
(3500.000, 'Argiloso', 3),
(2562.000, 'Arenoso', 1),
(2364.784, 'Argiloso', 1),
(6025.600, 'Arenoso', 4),
(9852.222, 'Arenoso', 5),
(9500.100, 'Arenoso', 6);

/* Tabela Lotes da Plantação, toda a plantação será separa em lotes, os quais terão apenas um sensor implantado */

CREATE TABLE lotesPlantacao(
	idLote int primary key auto_increment,
    nome varchar(100),
    nivelLote tinyint,
	fkPlantacao int not null, 
    constraint fkLote 
		foreign key (fkPlantacao)
        references plantacaoEmpresa(idPlantacao)
);

INSERT INTO lotesPlantacao (nome, nivelLote, fkPlantacao) VALUES
('A1',0, 1),
('a0', 1, 2),
('B1', 0, 3),
('B2', 0, 3),
('b4', 1, 4),
('c1', 1, 5),
('c2', 0, 6);

CREATE TABLE sensorLote (
	idSensor int primary key auto_increment,
    fkLote int not null,
    constraint fkSensor
		foreign key (fkLote)
        references lotesPlantacao(idLote)
);

/* Tabela de leitura do sensor */ 

CREATE TABLE leituraSensor (
	idLeitura INT AUTO_INCREMENT,
    fkSensor int,

	constraint pkSensor
		primary key(idLeitura, fkSensor),
        
	constraint fkLeitura
		foreign key (fkSensor)
        references sensorLote(idSensor),
    
	umidadeSolo DECIMAL(5,2) NOT NULL,
	data_hora DATETIME DEFAULT CURRENT_TIMESTAMP
);

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
