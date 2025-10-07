use vitalis;

drop table empresaCliente;
	drop table usuarioEmpresa;
		drop table plantacaoEmpresa;
			drop table lotesEmpresa;
				drop table sensorEmpresa;
					drop table leituraSensor;
                    
show tables;

describe empresaCliente;
describe usuarioEmpresa;
describe plantacaoEmpresa;
describe lotesPlantacao;
describe sensorLote;
describe leituraSensor;


CREATE TABLE empresaCliente (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nomeEmpresa VARCHAR (150) NOT NULL,
	cnpj CHAR(14) NOT NULL UNIQUE
);
CREATE  TABLE usuarioEmpresa(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    cpf VARCHAR(14) NOT NULL UNIQUE,
	senha varchar(100) NOT NULL,
	nivelCargo TINYINT NOT NULL,
		CONSTRAINT chkNivelCargo 
		CHECK (nivelCargo IN(1, 2, 3, 99))
);
-- 'Estratégico' 	1
-- 'Tático'			2
-- 'Operacional'	3
-- 'DESENVOLVEDOR'  99
CREATE TABLE plantacaoEmpresa(
	idPlantacao INT PRIMARY KEY AUTO_INCREMENT,
	areaHec DECIMAL (7,3) NOT NULL,
    tipoSolo varchar(100),
    fkEmpresa int,
    constraint fkEmpresa 
		foreign key (fkEmpresa)
        references empresaCliente(idEmpresa)
);
CREATE TABLE lotesPlantacao(
	idLote int primary key auto_increment,
    nome varchar(100),
    nivelLote tinyint,
	fkPlantacao int not null, 
    constraint fkLote 
		foreign key (fkPlantacao)
        references plantacaoEmpresa(idPlantacao)
);
CREATE TABLE sensorLote (
	idSensor int primary key auto_increment,
    fkLote int not null,
    constraint fkSensor
		foreign key (fkLote)
        references lotesPlantacao(idLote)
);
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



-- entidade fraca // relacionamento fraco ou dependente = chave primaria composta
		-- id + fk
        -- não existe sem a outra
        
-- entidade forte
		-- existe só, apenas ID
        
-- relaci


-- tupos de atributos (campos/colunas)
	-- simples = indivisivel
    -- compostos = divisivel e DEVE ser dividido em altributos simples
    
    -- insert's com elementos compostos são uma má pratica 								ENDERECO == rua, numero, cep, bairro, etc, etc
	-- é correto dividir o elemento em outros simples e assim os adicionar atributos	CEP = ZZZZ NUMERO = XXX COMPLEMENTO = YYY 
    
    
    -- monovalorado : um valor
    -- multivalorado : muitos valores
    
    -- UBSERT INTO PESSOA (TELEFONES) VALUES -- (FIXO E PESSOAL) --> INSERT INTO PESSOA (TELEFONE FIXO, TELEFONE PESSOAL)

            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
