/*
	BANCO DE DADOS - VITALIS
	Sistema para gerenciar empresas, cultivos de caju, leituras de sensores e produtividade.
*/

CREATE DATABASE Vitalis;

USE Vitalis;

/* 
	TABELA: CadastroEmpresa
	Armazena informações das empresas parceiras, como nome, CNPJ, contato, perfil e nível de cargo.
*/

CREATE TABLE CadastroEmpresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nomeEmpresa VARCHAR (150) NOT NULL,
    dataEntrada DATETIME DEFAULT CURRENT_TIMESTAMP,
	fotoPerfil VARCHAR(60),
	cnpj CHAR(14) NOT NULL UNIQUE,
	email VARCHAR(100) NOT NULL UNIQUE,
	senha VARCHAR(50) NOT NULL,
	contato CHAR(11) NOT NULL UNIQUE,
	perfil VARCHAR(50) NOT NULL,
		CONSTRAINT chkPerfil 
		CHECK (perfil IN('Indústria', 'Companhia de Produção', 'Empresa de Monitoramento')),
	nivelCargo VARCHAR(40) NOT NULL,
		CONSTRAINT chkNivelCargo 
		CHECK (nivelCargo IN('Estratégico', 'Tático', 'Operacional'))
);

INSERT INTO CadastroEmpresa (nomeEmpresa, fotoPerfil, cnpj, email, senha, contato, perfil, nivelCargo) VALUES
	('AgroVale Indústria de Alimentos', 'agrovale.png', '12345678000195', 'contato@agrovale.com.br', 'Senha#2025', '11987654321', 'Indústria', 'Estratégico'),
	('Verde Monitoramento Ambiental', 'verde_monit.jpg', '98765432000110', 'suporte@verdeambiental.com', 'Segura123!', '21999887766', 'Empresa de Monitoramento', 'Operacional'),
	('CajuBrasil Companhia', 'cajubrasil_logo.png', '45678912000133', 'rh@cajubrasil.com', 'Cajuzinho@2025', '81991234567', 'Companhia de Produção', 'Tático'),
	('Sol Nascente Produções Agrícolas', 'solnascente.jpg', '11223344000177', 'admin@solnascente.com', 'ProdAgro!45', '62999881234', 'Companhia de Produção', 'Operacional'),
	('EcoSensores Monitoramento', 'ecosensores.png', '99887766000155', 'eco@ecosensores.com.br', 'Monitor#2025', '31988776655', 'Empresa de Monitoramento', 'Tático'),
	('NutriCaju Indústria de Beneficiamento', 'nutricaju.png', '22334455000166', 'contato@nutricaju.com.br', 'Ncaju_2025', '71999887744', 'Indústria', 'Operacional'),
	('TechAgro Monitoramento Digital', 'techagro.jpg', '33445566000122', 'info@techagro.com', 'Tech@2025', '11988776655', 'Empresa de Monitoramento', 'Estratégico'),
	('Flor do Sertão Companhia', 'florsertao.png', '44556677000188', 'comercial@florsertao.com.br', 'Flor2025!', '85991237890', 'Companhia de Produção', 'Tático');
    
SELECT 
	idEmpresa AS "ID da Empresa",
    dataEntrada AS "Data de Cadastro",
    nomeEmpresa AS "Nome da Empresa Parceira",
    fotoPerfil AS "Ícone da Empresa Parceira",
    cnpj AS "CNPJ",
    email AS "E-mail",
    contato AS "Contato",
    perfil AS "Perfil",
    nivelCargo AS "Nível do Cargo"
FROM CadastroEmpresa;

DESCRIBE CadastroEmpresa;


/* 
	TABELA: leituraSensor
	Registra leituras de umidade do solo enviadas pelos sensores, com alerta de nível de umidade.
*/

CREATE TABLE leituraSensor (
	idLeitura INT PRIMARY KEY AUTO_INCREMENT,
	umidadeSolo DECIMAL(4,2) NOT NULL,
	tipoAlerta VARCHAR (50) NOT NULL,
		CONSTRAINT chkAlerta 
		CHECK (tipoAlerta IN('Umidade Baixa', 'Umidade Moderada', 'Umidade Alta')),
	data_hora DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO leituraSensor (umidadeSolo, tipoAlerta, data_hora) VALUES
(12.50, 'Umidade Baixa', '2025-08-25 08:15:00'),
(18.30, 'Umidade Moderada', '2025-08-25 09:45:00'),
(25.60, 'Umidade Alta', '2025-08-25 11:10:00'),
(14.20, 'Umidade Baixa', '2025-08-26 07:50:00'),
(19.80, 'Umidade Moderada', '2025-08-26 10:25:00'),
(28.40, 'Umidade Alta', '2025-08-26 14:05:00'),
(11.90, 'Umidade Baixa', '2025-08-27 06:40:00'),
(20.10, 'Umidade Moderada', '2025-08-27 09:20:00'),
(27.75, 'Umidade Alta', '2025-08-27 13:30:00'),
(13.80, 'Umidade Baixa', '2025-08-28 08:05:00');

SELECT
	idLeitura AS "ID do Sensor",
    umidadeSolo AS "Umidade do Solo",
    tipoAlerta AS "Alerta!",
    data_hora AS "Data e Hora da medição"
FROM leituraSensor;

DESCRIBE leituraSensor;

/* 
	TABELA: Caju
	Registra informações de plantio de caju, quantidade plantada, água utilizada, área plantada, colheita e economia de água.
*/

CREATE TABLE Caju (
	idCaju INT PRIMARY KEY AUTO_INCREMENT,
    qtdCaju_plantado INT,
    qtdAgua_utilizada DECIMAL (6,3),
    tamanhoHec DECIMAL (5,3),
    qtdCaju_colhido INT,
    qtdAgua_economia DECIMAL (6,3)
);

INSERT INTO Caju (qtdCaju_plantado, qtdAgua_utilizada, tamanhoHec, qtdCaju_colhido, qtdAgua_economia) VALUES
(1000, 500.250, 1.000, 850, 50.000),
(1500, 750.500, 1.500, 1300, 80.000),
(1200, 600.000, 1.200, 1000, 60.000),
(1800, 900.750, 1.800, 1600, 90.500),
(1100, 550.300, 1.100, 950, 45.000),
(2000, 100.000, 2.000, 1800, 20.000),
(1300, 650.450, 1.300, 1150, 65.000),
(1600, 800.600, 1.600, 1400, 80.250);

SELECT 
	idCaju AS "ID do Cajueiro",
    qtdAgua_utilizada AS "Quantidade de Água Utilizada",
    qtdCaju_plantado AS "Quantidade de Cajus Plantados",
    tamanhoHec AS "Tamanho em Hectares da Área Plantada",
    qtdCaju_colhido AS "Quantidade de Cajus Colhidos",
    qtdAgua_economia AS "Quantidade de Água Economizada na Irrigação"
FROM Caju;

DESCRIBE Caju;

/* 
	TABELA: Produtividade
	Armazena dados de produção e rendimento das safras de caju.
*/

CREATE TABLE Produtividade (
	idProdutividade INT PRIMARY KEY AUTO_INCREMENT,
	safra_inicio DATE NOT NULL,
    safra_final DATE NOT NULL,
	producao_kg DECIMAL(10,2),
	rendimento DECIMAL(5,2)
);

INSERT INTO Produtividade (safra_inicio, safra_final, producao_kg, rendimento) VALUES
('2024-01-03', '2025-01-15', 8500.50, 8.50),
('2024-02-18', '2025-02-20', 13000.75, 9.00),
('2024-03-01', '2025-03-10', 10000.00, 8.33),
('2024-04-12', '2025-04-05', 16000.25, 8.89),
('2024-05-06', '2025-05-12', 9500.00, 8.18),
('2024-06-10', '2025-06-18', 18000.80, 9.00),
('2024-07-19', '2025-07-22', 11500.40, 8.50),
('2024-08-23', '2025-08-30', 14000.60, 8.75);

SELECT 
	idProdutividade AS "ID Produtividade",
    safra_inicio AS "Data de Inicio da Safra",
    safra_final AS "Data final da Safra",
    producao_kg AS "Produção em KG do Caju",
    rendimento AS "Rendimento em KG por área ou por planta"
FROM Produtividade;

DESCRIBE Produtividade;

ALTER TABLE leituraSensor ADD COLUMN fkCajuSensor int;
ALTER TABLE leituraSensor ADD CONSTRAINT fkCajuSensorLeitura
	foreign key (fkCajuSensor) references Caju (idCaju);

SELECT * FROM leituraSensor;

ALTER TABLE Produtividade ADD COLUMN fkCajuProd int;
ALTER TABLE Produtividade ADD CONSTRAINT fkCajuProdutividade
	foreign key (fkCajuProd) references Caju (idCaju);

SELECT * FROM Produtividade;

ALTER TABLE Produtividade ADD COLUMN fkCadastro int;
ALTER TABLE Produtividade ADD CONSTRAINT fCadastroProdutividade
	foreign key (fkCadastro) references CadastroEmpresa (idEmpresa);

SELECT * FROM Produtividade;
