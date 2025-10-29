CREATE DATABASE vitalis;
use vitalis;

CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR (150) NOT NULL,
	cnpj CHAR(14) NOT NULL UNIQUE,
    email VARCHAR(50),
    contato VARCHAR(18),
    dataEntrada DATETIME DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO empresa (razaoSocial, cnpj) values
('marcidada', '123456789abcde');


	
CREATE TABLE usuario (
	idUsuario INT AUTO_INCREMENT,
    idSupervisor INT,
    fkEmpresa INT,
    apelidoUsuario VARCHAR (100),
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
	senha VARCHAR(50) NOT NULL,
	celular CHAR(11) NOT NULL UNIQUE,
    CONSTRAINT pk_usuario
		PRIMARY KEY (idUsuario, fkEmpresa)
);

ALTER TABLE usuario 
	ADD CONSTRAINT fk_supervisor
		FOREIGN KEY (idSupervisor)
		REFERENCES usuario(idUsuario);
ALTER TABLE usuario 
	ADD CONSTRAINT fk_empresa_usuario
		FOREIGN KEY (fkEmpresa)
		REFERENCES empresa(idEmpresa);
    
    
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
(1,1,55.75);


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
(1, 1, 'capacitivo', 'A0', 1);

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
            
			drop table empresa;
            drop table plantacao;
            drop table leitura;
            drop table sensor;
            drop table usuario;     
            

            
            
            
            
            
            
            
            
            
            
