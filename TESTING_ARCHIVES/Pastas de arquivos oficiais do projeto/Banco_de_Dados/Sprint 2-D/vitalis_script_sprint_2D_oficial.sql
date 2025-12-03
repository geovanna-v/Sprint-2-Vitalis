 DROP DATABASE vitalis; 
CREATE DATABASE vitalis;
use vitalis;

CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR (150) NOT NULL,
	cnpj CHAR(14) NOT NULL UNIQUE,
    email VARCHAR(50),
    senha VARCHAR(100),
    contato VARCHAR(18),
    dataEntrada DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO empresa (razaoSocial, cnpj, email, senha, contato) VALUES
	('AgroVale Indústria de Alimentos', '12345678000195', 'agrovale@gmail.com', 'agrovale123', '1253614264'),
	('Verde Monitoramento Ambiental', '98765432000110', 'verdemonitoramento@outlook.com', 'verdemonitor123', '21236547895'), 
	('CajuBrasil Companhia', '45678912000133', 'cajubrasil@gmail.com', 'cajubrasil123', '21236547895'),
	('Sol Nascente Produções Agrícolas', '11223344000177', 'nascentesol@gmail.com', 'solnascente0606', '21236547895'),
	('EcoSensores Monitoramento', '99887766000155', 'ecoSensores@gmail.com', 'ecoSensores123', '21236547895'),
	('NutriCaju Indústria de Beneficiamento', '22334455000166', 'natricaju_278@gmail.com', 'natri@caju', '21236547895'),
	('TechAgro Monitoramento Digital', '33445566000122', 'techagro@outlook.com', 'techagroagro444', '21236547895'),
	('Flor do Sertão Companhia', '44556677000188', 'florsertaneja@gmail.com', 'florsetao4500', '21236547895');


CREATE TABLE usuario (
	idUsuario INT AUTO_INCREMENT,
    idSupervisor INT NULL, 
    empresaSupervisor INT NULL, 
    fkEmpresa INT,
    apelidoUsuario VARCHAR (100),
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
	senha VARCHAR(50) NOT NULL,
	celular CHAR(11) NOT NULL UNIQUE,
	PRIMARY KEY (idUsuario, fkEmpresa),
	CONSTRAINT fk_empresa_usuario
		FOREIGN KEY (fkEmpresa)
		REFERENCES empresa(idEmpresa),
	nivelCargo TINYINT NOT NULL,
    CONSTRAINT chkNivelCargo 
		CHECK (nivelCargo IN(1, 2, 3))
);
alter table usuario add CONSTRAINT fk_supervisor
		FOREIGN KEY (idSupervisor, empresaSupervisor)
		REFERENCES usuario(idUsuario, fkEmpresa);

desc usuario;
        
INSERT INTO usuario (idSupervisor, fkEmpresa, apelidoUsuario, cpf, email, senha, celular, nivelCargo) VALUES 
	(1, 1, 'Joana Silva', '52136987412', 'contato@agrovale.com.br', 'Senha#2025', '949350142', 1),
	(2, 1, 'João Moraes', '56989871236', 'suporte@verdeambiental.com', 'Segura123!', '949750552', 2),
	(3, 2, 'Wilton Machado', '46789120001', 'rh@cajubrasil.com', 'Cajuzinho@2025', '979352963', 3),
	(4, 3, 'Solange Lima', '23344000177', 'admin@solnascente.com', 'ProdAgro!45', '946350888', 3),
	(5, 3, 'Arthur Franco', '97766000155', 'eco@ecosensores.com.br', 'Monitor#2025', '999351234', 2),
	(6, 4, 'Cássia Martins', '34455000166', 'contato@nutricaju.com.br', 'Ncaju_2025', '944350293', 1),
	(7, 5, 'Augusto Torres', '37566000122', 'info@techagro.com', 'Tech@2025', '923357423', 1),
	(8, 6, 'Flora Souza', '56677000188', 'comercial@florsertao.com.br', 'Flor2025!', '940651222', 1);
    
    
CREATE TABLE plantacao(
	idPlantacao INT PRIMARY KEY,
    fkEmpresa INT,
	areaM2 DECIMAL (7,3) NOT NULL,
    tipoSolo varchar(100)
);

ALTER TABLE plantacao 
	ADD constraint fk_empresa_plantacao
		foreign key (fkEmpresa)
        references empresa(idEmpresa);

INSERT INTO plantacao (idPlantacao, fkEmpresa, areaM2) values 
(1, 1, 55.75),
(2, 1, 55.75),
(3, 2, 175.5),
(4, 2, 175.5),
(5, 3, 100),
(6, 3, 100);


CREATE TABLE sensor (
idSensor INT PRIMARY KEY auto_increment,
lote INT NOT NULL,
modelo VARCHAR(100) NOT NULL,
coordSensor CHAR(2) NOT NULL,
fkPlantacao INT NOT NULL
);
ALTER TABLE sensor 
	ADD CONSTRAINT fk_plantacao
		FOREIGN KEY (fkPlantacao)
        REFERENCES plantacao(idPlantacao);
        
INSERT INTO sensor (lote, modelo, coordSensor, fkPlantacao) values 
(1, 'capacitivo', 'A0', 1),
(1, 'capacitivo', 'A1', 1),
(1, 'capacitivo', 'A2', 1),
(1, 'capacitivo', 'A3', 1),
(1, 'capacitivo', 'B0', 1),
(1, 'capacitivo', 'B1', 1),
(1, 'capacitivo', 'B2', 1),
(1, 'capacitivo', 'B3', 1),
(1, 'capacitivo', 'C0', 1),
(1, 'capacitivo', 'C1', 1),
(1, 'capacitivo', 'C2', 1),
(1, 'capacitivo', 'C3', 1),
(1, 'capacitivo', 'D0', 1),
(1, 'capacitivo', 'D1', 1),
(1, 'capacitivo', 'D2', 1),
(1, 'capacitivo', 'D3', 1),
(1, 'capacitivo', 'A0', 2),
(1, 'capacitivo', 'A1', 2),
(1, 'capacitivo', 'A2', 2),
(1, 'capacitivo', 'A3', 2),
(1, 'capacitivo', 'B0', 2),
(1, 'capacitivo', 'B1', 2),
(1, 'capacitivo', 'B2', 2),
(1, 'capacitivo', 'B3', 2),
(1, 'capacitivo', 'C0', 2),
(1, 'capacitivo', 'C1', 2),
(1, 'capacitivo', 'C2', 2),
(1, 'capacitivo', 'C3', 2),
(1, 'capacitivo', 'D0', 2),
(1, 'capacitivo', 'D1', 2),
(1, 'capacitivo', 'D2', 2),
(1, 'capacitivo', 'D3', 2),
(1, 'capacitivo', 'A0', 3),
(1, 'capacitivo', 'A1', 3),
(1, 'capacitivo', 'A2', 3),
(1, 'capacitivo', 'A3', 3),
(1, 'capacitivo', 'B0', 3),
(1, 'capacitivo', 'B1', 3),
(1, 'capacitivo', 'B2', 3),
(1, 'capacitivo', 'B3', 3),
(1, 'capacitivo', 'C0', 3),
(1, 'capacitivo', 'C1', 3),
(1, 'capacitivo', 'C2', 3),
(1, 'capacitivo', 'C3', 3),
(1, 'capacitivo', 'D0', 3),
(1, 'capacitivo', 'D1', 3),
(1, 'capacitivo', 'D2', 3),
(1, 'capacitivo', 'D3', 3),
(1, 'capacitivo', 'A0', 4),
(1, 'capacitivo', 'A1', 4),
(1, 'capacitivo', 'A2', 4),
(1, 'capacitivo', 'A3', 4),
(1, 'capacitivo', 'B0', 4),
(1, 'capacitivo', 'B1', 4),
(1, 'capacitivo', 'B2', 4),
(1, 'capacitivo', 'B3', 4),
(1, 'capacitivo', 'C0', 4),
(1, 'capacitivo', 'C1', 4),
(1, 'capacitivo', 'C2', 4),
(1, 'capacitivo', 'C3', 4),
(1, 'capacitivo', 'D0', 4),
(1, 'capacitivo', 'D1', 4),
(1, 'capacitivo', 'D2', 4),
(1, 'capacitivo', 'D3', 4),
(1, 'capacitivo', 'A0', 5),
(1, 'capacitivo', 'A1', 5),
(1, 'capacitivo', 'A2', 5),
(1, 'capacitivo', 'A3', 5),
(1, 'capacitivo', 'B0', 5),
(1, 'capacitivo', 'B1', 5),
(1, 'capacitivo', 'B2', 5),
(1, 'capacitivo', 'B3', 5),
(1, 'capacitivo', 'C0', 5),
(1, 'capacitivo', 'C1', 5),
(1, 'capacitivo', 'C2', 5),
(1, 'capacitivo', 'C3', 5),
(1, 'capacitivo', 'D0', 5),
(1, 'capacitivo', 'D1', 5),
(1, 'capacitivo', 'D2', 5),
(1, 'capacitivo', 'D3', 5),
(1, 'capacitivo', 'A0', 6),
(1, 'capacitivo', 'A1', 6),
(1, 'capacitivo', 'A2', 6),
(1, 'capacitivo', 'A3', 6),
(1, 'capacitivo', 'B0', 6),
(1, 'capacitivo', 'B1', 6),
(1, 'capacitivo', 'B2', 6),
(1, 'capacitivo', 'B3', 6),
(1, 'capacitivo', 'C0', 6),
(1, 'capacitivo', 'C1', 6),
(1, 'capacitivo', 'C2', 6),
(1, 'capacitivo', 'C3', 6),
(1, 'capacitivo', 'D0', 6),
(1, 'capacitivo', 'D1', 6),
(1, 'capacitivo', 'D2', 6),
(1, 'capacitivo', 'D3', 6),
(2, 'capacitivo', 'A0', 1),
(2, 'capacitivo', 'A1', 1),
(2, 'capacitivo', 'A2', 1),
(2, 'capacitivo', 'A3', 1),
(2, 'capacitivo', 'B0', 1),
(2, 'capacitivo', 'B1', 1),
(2, 'capacitivo', 'B2', 1),
(2, 'capacitivo', 'B3', 1),
(2, 'capacitivo', 'C0', 1),
(2, 'capacitivo', 'C1', 1),
(2, 'capacitivo', 'C2', 1),
(2, 'capacitivo', 'C3', 1),
(2, 'capacitivo', 'D0', 1),
(2, 'capacitivo', 'D1', 1),
(2, 'capacitivo', 'D2', 1),
(2, 'capacitivo', 'D3', 1),
(2, 'capacitivo', 'A0', 2),
(2, 'capacitivo', 'A1', 2),
(2, 'capacitivo', 'A2', 2),
(2, 'capacitivo', 'A3', 2),
(2, 'capacitivo', 'B0', 2),
(2, 'capacitivo', 'B1', 2),
(2, 'capacitivo', 'B2', 2),
(2, 'capacitivo', 'B3', 2),
(2, 'capacitivo', 'C0', 2),
(2, 'capacitivo', 'C1', 2),
(2, 'capacitivo', 'C2', 2),
(2, 'capacitivo', 'C3', 2),
(2, 'capacitivo', 'D0', 2),
(2, 'capacitivo', 'D1', 2),
(2, 'capacitivo', 'D2', 2),
(2, 'capacitivo', 'D3', 2),
(2, 'capacitivo', 'A0', 3),
(2, 'capacitivo', 'A1', 3),
(2, 'capacitivo', 'A2', 3),
(2, 'capacitivo', 'A3', 3),
(2, 'capacitivo', 'B0', 3),
(2, 'capacitivo', 'B1', 3),
(2, 'capacitivo', 'B2', 3),
(2, 'capacitivo', 'B3', 3),
(2, 'capacitivo', 'C0', 3),
(2, 'capacitivo', 'C1', 3),
(2, 'capacitivo', 'C2', 3),
(2, 'capacitivo', 'C3', 3),
(2, 'capacitivo', 'D0', 3),
(2, 'capacitivo', 'D1', 3),
(2, 'capacitivo', 'D2', 3),
(2, 'capacitivo', 'D3', 3),
(2, 'capacitivo', 'A0', 4),
(2, 'capacitivo', 'A1', 4),
(2, 'capacitivo', 'A2', 4),
(2, 'capacitivo', 'A3', 4),
(2, 'capacitivo', 'B0', 4),
(2, 'capacitivo', 'B1', 4),
(2, 'capacitivo', 'B2', 4),
(2, 'capacitivo', 'B3', 4),
(2, 'capacitivo', 'C0', 4),
(2, 'capacitivo', 'C1', 4),
(2, 'capacitivo', 'C2', 4),
(2, 'capacitivo', 'C3', 4),
(2, 'capacitivo', 'D0', 4),
(2, 'capacitivo', 'D1', 4),
(2, 'capacitivo', 'D2', 4),
(2, 'capacitivo', 'D3', 4),
(2, 'capacitivo', 'A0', 5),
(2, 'capacitivo', 'A1', 5),
(2, 'capacitivo', 'A2', 5),
(2, 'capacitivo', 'A3', 5),
(2, 'capacitivo', 'B0', 5),
(2, 'capacitivo', 'B1', 5),
(2, 'capacitivo', 'B2', 5),
(2, 'capacitivo', 'B3', 5),
(2, 'capacitivo', 'C0', 5),
(2, 'capacitivo', 'C1', 5),
(2, 'capacitivo', 'C2', 5),
(2, 'capacitivo', 'C3', 5),
(2, 'capacitivo', 'D0', 5),
(2, 'capacitivo', 'D1', 5),
(2, 'capacitivo', 'D2', 5),
(2, 'capacitivo', 'D3', 5),
(2, 'capacitivo', 'A0', 6),
(2, 'capacitivo', 'A1', 6),
(2, 'capacitivo', 'A2', 6),
(2, 'capacitivo', 'A3', 6),
(2, 'capacitivo', 'B0', 6),
(2, 'capacitivo', 'B1', 6),
(2, 'capacitivo', 'B2', 6),
(2, 'capacitivo', 'B3', 6),
(2, 'capacitivo', 'C0', 6),
(2, 'capacitivo', 'C1', 6),
(2, 'capacitivo', 'C2', 6),
(2, 'capacitivo', 'C3', 6),
(2, 'capacitivo', 'D0', 6),
(2, 'capacitivo', 'D1', 6),
(2, 'capacitivo', 'D2', 6),
(2, 'capacitivo', 'D3', 6);

CREATE TABLE leitura (
	idLeitura INT PRIMARY KEY AUTO_INCREMENT,
	dataLeitura DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensor INT,
	leituraUmidadeSolo DECIMAL(5,2) NOT NULL
);
ALTER TABLE leitura
	ADD	CONSTRAINT fk_sensor
	FOREIGN KEY (fkSensor)
	REFERENCES sensor(idSensor);
    
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
            
SELECT avg(l.leituraUmidadeSolo) as umidade
                    FROM leitura l 
                    join sensor s on l.fkSensor = s.idSensor
                    join plantacao p on s.fkPlantacao = p.idPlantacao
                    where p.idPlantacao = 1
                    group by minute(l.dataLeitura)
                    order by minute(l.dataLeitura) desc
                    LIMIT 10;
                    
SELECT avg(l.leituraUmidadeSolo) as umidade,
                    l.dataLeitura as momento
                    FROM leitura l 
                    join sensor s on l.fkSensor = s.idSensor
                    join plantacao p on s.fkPlantacao = p.idPlantacao
                    where p.idPlantacao = s.fkPlantacao AND p.fkEmpresa = 1
                    group by minute(l.dataLeitura)
                    order by l.dataLeitura desc;
                    
                    
                    SELECT avg(l.leituraUmidadeSolo) as umidade, time(l.dataLeitura) as momento FROM leitura l join sensor s on l.fkSensor = s.idSensor join plantacao p on s.fkPlantacao = p.idPlantacao where p.idPlantacao = 1 AND p.fkEmpresa = 1 group by minute(l.dataLeitura) order by l.dataLeitura desc LIMIT 10;
                    
                    
            select idSensor
					from sensor s 
                    join plantacao p
                    on s.fkPlantacao = p.idPlantacao
                    join empresa e
                    on p.fkEmpresa = e.idEmpresa
                    where e.idEmpresa = 1;
                    
            
            
            
            
            SELECT  avg(l.leituraUmidadeSolo) as umidade,
                    time(l.dataLeitura) as momento
                    FROM leitura l 
                    join sensor s on l.fkSensor = s.idSensor
                    join plantacao p on s.fkPlantacao = p.idPlantacao
                    where p.idPlantacao = 1 AND p.fkEmpresa = 1
                    group by second(l.dataLeitura)
                    order by l.dataLeitura desc
                    LIMIT 1;
            
            select * from leitura where fksensor = 32;
            
            select s.idSensor from sensor s join plantacao p on s.fkPlantacao = p.idPlantacao where p.idPlantacao = 1 and s.lote = 1;
            
            
            SELECT 
                    avg(l.leituraUmidadeSolo) as umidade,
                    time(l.dataLeitura) as momento
                    FROM leitura l 
                    join sensor s on l.fkSensor = s.idSensor
                    join plantacao p on s.fkPlantacao = p.idPlantacao
                    where p.idPlantacao = 1 AND p.fkEmpresa = 1 AND s.lote = 1
                    group by time(l.dataLeitura)
                    order by l.dataLeitura desc
                    LIMIT 1;
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
				SELECT 
                    avg(l.leituraUmidadeSolo) as umidade,
                    time(l.dataLeitura) as momento
                    FROM leitura l 
                    join sensor s on l.fkSensor = s.idSensor
                    join plantacao p on s.fkPlantacao = p.idPlantacao
                    where p.idPlantacao = 1 AND p.fkEmpresa = 1
                    group by minute(l.dataLeitura)
                    order by l.idLeitura desc
                    LIMIT 1;
                    
                    
                    
                    
				
            
