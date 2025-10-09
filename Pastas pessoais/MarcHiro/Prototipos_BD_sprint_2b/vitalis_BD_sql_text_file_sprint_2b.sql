create database vitalis_pi;
use vitalis_pi;

drop table empresa;
drop table plantacao;
drop table leitura;
				
show tables;

describe empresa;
describe plantacao;
describe leitura;

select * from empresacliente;
select * from plantacaoempresa;
select * from leiturasensor;

CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nomeEmpresa varchar(100) NOT NULL UNIQUE,
    emailEmpresa varchar(100) NOT NULL UNIQUE,
    contato varchar(30) NOT NULL UNIQUE,
	cnpj CHAR(18) NOT NULL UNIQUE
);
CREATE TABLE plantacao(
	idPlantacao int,
    fkEmpresa int,
	sensorLote char(2), -- coordenada da plantacao onde temos um sensor (A0 - A1) (tabuleiro xadrez)
	constraint pkSensorPlantacao
		primary key (idPlantacao, fkEmpresa, sensorLote), -- faz com que seja obrigatorio que a combinacao dos tres seja unique
	constraint ckSensorLote -- forca o formato das cordenadas fiz maiusculo e minusculo, mas devemos mudar depois....
		check(
				(
				SUBSTRING(sensorLote, 1, 1) BETWEEN 'A' AND 'Z'
				OR 
                SUBSTRING(sensorLote, 1, 1) BETWEEN 'a' AND 'z'
				)
			 AND SUBSTRING(sensorLote, 2, 1) BETWEEN '0' AND '9'
			),
    constraint fkEmpresa 
		foreign key (fkEmpresa)
        references Empresa(idEmpresa),
	tamanhoHec Decimal(7,3) NOT NULL,
    qntPlantado int
);

CREATE TABLE leitura (
	idLeituraDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkSensorLote char(2),
    fkPlantacao int,
    fkEmpresa int,
	
	constraint leituraSensor
		primary key(idLeituraDate, fkSensorLote, fkPlantacao, fkEmpresa), 
	-- força que tenha apenas de um sensor de uma plantacao de uma empresa
    -- o auto_increment do idLeitura faz com que multiplas leituras possam ser de um sensor
	
	CONSTRAINT fk_leitura_plantacao
		FOREIGN KEY (fkPlantacao, fkEmpresa, fkSensorLote)
		REFERENCES plantacao (idPlantacao, fkEmpresa, sensorLote),
        
	umidadeSolo DECIMAL(5,2) NOT NULL
);

use test_vitalis;
describe plantacaoEmpresa;
SELECT idLeitura , fkSensorLote, umidadeSolo FROM leituraSensor WHERE data_hora BETWEEN '2025-10-02 23:00:00' AND '2025-10-02 23:05:00';






















