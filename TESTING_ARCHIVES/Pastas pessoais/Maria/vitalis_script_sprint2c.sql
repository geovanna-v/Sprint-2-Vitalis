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
    cep CHAR(8),
    numero VARCHAR(45),
    bairro VARCHAR(100)
);

INSERT INTO empresa (razaoSocial, cnpj, cep, numero, bairro) VALUES
	('AgroVale Indústria de Alimentos', '12345678000195','02548971', '2644','Jardim Vital'),
	('Verde Monitoramento Ambiental', '98765432000110','23636581','6325', 'Jardim Soares Silva'),
	('CajuBrasil Companhia', '45678912000133', '23685412', '982', 'Vila Madalena'),
	('Sol Nascente Produções Agrícolas', '11223344000177','23698745', '7369', 'Jardim Santo Américo'),
	('EcoSensores Monitoramento', '99887766000155','25636987','941','Jardim Vitápolis'),
	('NutriCaju Indústria de Beneficiamento', '22334455000166', '25479587','3047','Jardim Portela'),
	('TechAgro Monitoramento Digital', '33445566000122', '23698745', '5847','Vila Sonia'),
	('Flor do Sertão Companhia', '44556677000188', '69858941', '5050', 'Jardim Silveira');
    
    select * from empresa;

/* TABELA: usuario. 
Dados do usario vindos do site. A empresa pode se cadastrar "sem usuário específico", 
porém dentro de sua página de perfil poderá cadastrar seus funcionários, que serão registrados na tabela "usuario",
com permissões para cada tipo de perfil profissional.
*/

CREATE TABLE usuario (
	idUsuario INT,
    nome VARCHAR (100),
    cpf VARCHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
	senha VARCHAR(50) NOT NULL,
	celular CHAR(11) NOT NULL UNIQUE,
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
	(1,'Joana Silva', '52136987412', 'contato@agrovale.com.br', 'Senha#2025', '11987654321', 1, 2),
	(2,'João Moraes', '56989871236', 'suporte@verdeambiental.com', 'Segura123!', '21999887766', 3, 2),
	(3,'Wilton Machado', '46789120001', 'rh@cajubrasil.com', 'Cajuzinho@2025', '81991234567', 2, 3),
	(4,'Solange Lima', '23344000177', 'admin@solnascente.com', 'ProdAgro!45', '62999881234', 3, 4),
	(5,'Arthur Franco', '97766000155', 'eco@ecosensores.com.br', 'Monitor#2025', '31988776655', 2, 5),
	(6,'Cássia Martins', '34455000166', 'contato@nutricaju.com.br', 'Ncaju_2025', '71999887744', 3, 8),
	(7,'Augusto Torres', '37566000122', 'info@techagro.com', 'Tech@2025', '11988776655', 1, 8),
	(8,'Flora Souza', '56677000188', 'comercial@florsertao.com.br', 'Flor2025!', '85991237890', 2, 7);
    
    select * from usuario;
    
/* TABELA: plantação.
 Engloba todo solo de arvores de caju plantadas. Cada empresa pode ter N plantações. */

CREATE TABLE plantacao(
	idPlantacao INT PRIMARY KEY AUTO_INCREMENT,
	areaHec DECIMAL (7,3) NOT NULL,
    tipoSolo varchar(100),
    fkEmpresaPlantacao int,
    constraint fkEmpresaPlantacao 
		foreign key (fkEmpresaPlantacao)
        references empresa(idEmpresa)
);

INSERT INTO plantacao (areaHec, tipoSolo, fkEmpresaPlantacao) VALUES
(2500.000, 'Arenoso', 2),
(3500.000, 'Argiloso', 3),
(2562.000, 'Arenoso', 1),
(2364.784, 'Argiloso', 1),
(6025.600, 'Arenoso', 4),
(9852.222, 'Arenoso', 5),
(9500.100, 'Arenoso', 6);

	select * from plantacao;
    
/* TABELA: Lotes da Plantação.
As plantações serão dividas em uma malha separadas por 9 quadradros, cada um sendo referente a um único lote. 
Cada lote poderá ter apenas 1 sensor. Desta forma, cada plantação terá no mínimo 9 lotes/9 sensores 
e no máximo N lotes/ N sensores. */

CREATE TABLE lotes(
	idLote INT auto_increment,
	fkPlantacaoEmpresa int not null,
    CONSTRAINT fkPlantacaoEmpresa
		FOREIGN KEY (fkPlantacaoEmpresa)
			REFERENCES 	empresa(idEmpresa),
    primary key (idLote, fkPlantacaoEmpresa)
);

INSERT INTO lotes (fkPlantacaoEmpresa) VALUES
(1),
(2),
(3),
(3),
(4),
(5),
(6);

	select * from lotes;
    
/* TABELA: Sensor. 
 Mostra os dados dos sensores, cada sensor tem uma leitura para si. Nas plantações podem ter diferentes modelos
 de sensores, daí a necessidade de uma tabela apenas para os sensores, identificando-os unicamente e seus modelos. */

CREATE TABLE sensor (
idSensor CHAR(2),
modelo VARCHAR(100),
nome varchar(50),
fkLote INT,
CONSTRAINT fkLote
	FOREIGN KEY (fkLote)
		REFERENCES lotes(idLote),
fkPlantacao INT,
CONSTRAINT fkPlantacao
	FOREIGN KEY (fkPlantacao)
		REFERENCES lotes(fkPlantacaoEmpresa),
PRIMARY KEY (idSensor, fkLote, fkPlantacao)
);

 SELECT * FROM sensor;
 
/* TABELA: Leitura do sensor.
Importante para conexão com a API que insere dados do arduino no BD. 
Cada lote terá um sensor, e cada sensor terá uma tabela de leitura. */ 

CREATE TABLE leituraSensor (
	dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
	umidadeSolo DECIMAL(5,2) NOT NULL,
    fkSensor CHAR(2),
    CONSTRAINT fkSensor
		FOREIGN KEY (fkSensor)
			REFERENCES sensor(idSensor),
	fkLote INT,
	CONSTRAINT fkLoteLeitura
		FOREIGN KEY (fkLote)
			REFERENCES lotes(idLote),
	fkPlantacao INT,
	CONSTRAINT fkPlantacaoLeitura
		FOREIGN KEY (fkPlantacao)
			REFERENCES lotes(fkPlantacaoEmpresa),
    PRIMARY KEY (dataHora, fkSensor, fkLote, fkPlantacao)
);

describe empresa;
describe usuario;
describe plantacao;
describe lotes;
describe sensor;
describe leituraSensor;


            
            
            
            
            
            
            
            
            
            
            
            
            
            
