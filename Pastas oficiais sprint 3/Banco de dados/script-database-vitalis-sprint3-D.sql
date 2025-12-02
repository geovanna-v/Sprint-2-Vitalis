-- Pasta pessoal Leticia

CREATE DATABASE vitalis;
use vitalis;

CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR (100) NOT NULL,
    dataEntrada DATETIME DEFAULT CURRENT_TIMESTAMP,
	cnpj CHAR(14) NOT NULL UNIQUE,
    email VARCHAR(50),
    senha VARCHAR(100)
);

INSERT INTO empresa (razaoSocial, cnpj, email, senha) VALUES
	('AgroVale Indústria de Alimentos', '12345678000195', 'agrovale@gmail.com', 'agrovale123'),
	('Verde Monitoramento Ambiental', '98765432000110', 'verdemonitoramento@outlook.com', 'verdemonitor123'), 
	('CajuBrasil Companhia', '45678912000133', 'cajubrasil@gmail.com', 'cajubrasil123'),
	('Sol Nascente Produções Agrícolas', '11223344000177', 'nascentesol@gmail.com', 'solnascente0606'),
	('EcoSensores Monitoramento', '99887766000155', 'ecoSensores@gmail.com', 'ecoSensores123'),
	('NutriCaju Indústria de Beneficiamento', '22334455000166', 'natricaju_278@gmail.com', 'natri@caju'),
	('TechAgro Monitoramento Digital', '33445566000122', 'techagro@outlook.com', 'techagroagro444'),
	('Flor do Sertão Companhia', '44556677000188', 'florsertaneja@gmail.com', 'florsetao4500');


CREATE TABLE usuario (
	idUsuario INT AUTO_INCREMENT,
    idSupervisor INT,
    fkEmpresa INT,
    apelidoUsuario VARCHAR (100),
    cpf CHAR(11) NOT NULL UNIQUE,
    emailUsuario VARCHAR(45) NOT NULL UNIQUE,
	senha VARCHAR(45) NOT NULL,
    CONSTRAINT pk_usuario
		PRIMARY KEY (idUsuario, fkEmpresa),
	nivelCargo TINYINT NOT NULL,
    CONSTRAINT chkNivelCargo 
		CHECK (nivelCargo IN(1, 2, 3))
);

ALTER TABLE usuario 
	ADD CONSTRAINT fk_supervisor
		FOREIGN KEY (idSupervisor)
		REFERENCES usuario(idUsuario);
ALTER TABLE usuario 
	ADD CONSTRAINT fk_empresa_usuario
		FOREIGN KEY (fkEmpresa)
		REFERENCES empresa(idEmpresa);

desc usuario;
        
INSERT INTO usuario (idSupervisor, fkEmpresa, apelidoUsuario, cpf, emailUsuario, senha, nivelCargo) VALUES 
	(1, 1, 'Joana Silva', '52136987412', 'contato@agrovale.com.br', 'Senha#2025', 1),
	(2, 1, 'João Moraes', '56989871236', 'suporte@verdeambiental.com', 'Segura123!', 2),
	(3, 2, 'Wilton Machado', '46789120001', 'rh@cajubrasil.com', 'Cajuzinho@2025', 3),
	(4, 3, 'Solange Lima', '23344000177', 'admin@solnascente.com', 'ProdAgro!45', 3),
	(5, 3, 'Arthur Franco', '97766000155', 'eco@ecosensores.com.br', 'Monitor#2025', 2),
	(6, 4, 'Cássia Martins', '34455000166', 'contato@nutricaju.com.br', 'Ncaju_2025', 1),
	(7, 5, 'Augusto Torres', '37566000122', 'info@techagro.com', 'Tech@2025', 1),
	(8, 6, 'Flora Souza', '56677000188', 'comercial@florsertao.com.br', 'Flor2025!', 1);
    
    
CREATE TABLE plantacao(
	idPlantacao INT PRIMARY KEY,
    fkEmpresa INT,
	areaM2 DECIMAL (7,2) NOT NULL,
    tipoSolo varchar(100) NOT NULL
);

ALTER TABLE plantacao 
	ADD constraint fk_empresa_plantacao
		foreign key (fkEmpresa)
        references empresa(idEmpresa);

INSERT INTO plantacao (idPlantacao, fkEmpresa, areaM2, tipoSolo) values 
(1, 1, 55.75, 'Argissolo');

CREATE TABLE sensor (
idSensor INT PRIMARY KEY,
lote INT NOT NULL,
modelo VARCHAR(100) NOT NULL,
coordSensor CHAR(2) NOT NULL,
fkPlantacao INT NOT NULL
);

ALTER TABLE sensor 
	ADD CONSTRAINT fk_plantacao
		FOREIGN KEY (fkPlantacao)
        REFERENCES plantacao(idPlantacao);
        
INSERT INTO sensor (idSensor, lote, modelo, coordSensor, fkPlantacao) values 
(2, 1, 'capacitivo', 'A1', 1),
(3, 1, 'capacitivo', 'A2', 1),
(4, 1, 'capacitivo', 'A3', 1),

(5, 1, 'capacitivo', 'B0', 1),
(6, 1, 'capacitivo', 'B1', 1),
(7, 1, 'capacitivo', 'B2', 1),
(8, 1, 'capacitivo', 'B3', 1),

(9, 1, 'capacitivo', 'C0', 1),
(10, 1, 'capacitivo', 'C1', 1),
(11, 1, 'capacitivo', 'C2', 1),
(12, 1, 'capacitivo', 'C3', 1),

(13, 1, 'capacitivo', 'D0', 1),
(14, 1, 'capacitivo', 'D1', 1),
(15, 1, 'capacitivo', 'D2', 1),
(16, 1, 'capacitivo', 'D3', 1);

CREATE TABLE leitura (
	idLeitura INT AUTO_INCREMENT,
	dataLeitura DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT,
	leituraUmidade DECIMAL(5,2) NOT NULL,
		CONSTRAINT pkLeitura
			PRIMARY KEY (idLeitura, fkSensor),
		CONSTRAINT fkLeituraSensor
			FOREIGN KEY (fkSensor) REFERENCES sensor (idSensor)
);
    
    show tables;
            select * from empresa;
            select * from plantacao;
            select * from sensor;
            select * from leitura;
            select * from usuario;
            
			describe empresa;
            describe plantacao;
            describe sensor;
            describe leitura;
            describe usuario;

-- VIEWS PARA A DASHBOARD (acrescentar datas e horas diferentes para a dashboard diária e semanal)           
CREATE VIEW vw_kpiUmidade AS  
	SELECT AVG(leitura.leituraUmidade) AS "Média da Umidade do Solo na Plantação" 
	FROM leitura
	JOIN sensor ON leitura.fkSensor = sensor.idSensor 
    JOIN plantacao ON sensor.fkPlantacao = plantacao.idPlantacao
    JOIN empresa ON plantacao.fkEmpresa = empresa.idEmpresa
	ORDER BY leitura.idLeitura DESC; -- // KPI da umidade do solo (última leitura)

CREATE VIEW vw_dashboardDiaria AS
	SELECT HOUR(dataLeitura) AS hora,
	ROUND(AVG(leituraUmidade), 2) AS umidade
	FROM leitura
	JOIN sensor ON leitura.fkSensor = sensor.idSensor
    JOIN plantacao ON sensor.fkPlantacao = plantacao.idPlantacao
    JOIN empresa ON plantacao.fkEmpresa = empresa.idEmpresa
	GROUP BY HOUR(dataLeitura)
	ORDER BY hora DESC
    LIMIT 12; -- // Dados para a dashboard de umidade diaria (de hora em hora) -- As últimas 12 horas 
        
CREATE VIEW wv_dashboardSemanal AS 
	SELECT DATE(dataLeitura) AS dia,
	ROUND(AVG(leituraUmidade), 2) AS media
	FROM leitura
	JOIN sensor ON leitura.fkSensor = sensor.idSensor
    JOIN plantacao ON sensor.fkPlantacao = plantacao.idPlantacao
    JOIN empresa ON plantacao.fkEmpresa = empresa.idEmpresa
	GROUP BY DATE(dataLeitura)
	ORDER BY dia DESC
    LIMIT 7; -- // Dados para a dashboard de umidade semanal -- últimos 7 dias

CREATE VIEW vw_kpiQtdSensores AS
	SELECT COUNT(idSensor) as "Quantidade de Sensores"
    FROM sensor JOIN plantacao 
    ON sensor.fkPlantacao = plantacao.idPlantacao 
    JOIN empresa 
    ON plantacao.fkEmpresa = empresa.idEmpresa; -- // KPI da quantidade de sensores por plantação 
	
SELECT * FROM vw_dashboardDiaria;
SELECT * FROM vw_dashboardDiaria WHERE plantacao.fkEmpresa = 1;
SELECT * FROM leitura ORDER BY (dataLeitura) DESC LIMIT 1;
SELECT * FROM wv_dashboardSemanal LIMIT 7;

SELECT COUNT(idSensor) as "Quantidade de Sensores"
    FROM sensor JOIN plantacao 
    ON sensor.fkPlantacao = plantacao.idPlantacao;
    
select * from leitura JOIN sensor 
ON leitura.fkSensor = sensor.idSensor 
JOIN plantacao 
ON sensor.fkPlantacao = plantacao.idPlantacao 
JOIN empresa 
ON plantacao.fkEmpresa = empresa.idEmpresa;
