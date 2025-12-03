var database = require("../database/config");

function buscarUltimasMedidas(idplantacao, limite_linhas) {

    var instrucaoSql = `SELECT 
                    avg(l.leituraUmidadeSolo) as umidade,
                    time(l.dataLeitura) as momento
                    FROM leitura l 
                    join sensor s on l.fkSensor = s.idSensor
                    join plantacao p on s.fkPlantacao = p.idPlantacao
                    where p.idPlantacao = 1 AND p.fkEmpresa = 1 AND s.lote = 1
                    group by time(l.dataLeitura)
                    order by l.dataLeitura desc
                    LIMIT 10;
                    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idplantacao) {

    var instrucaoSql = `
                SELECT 
                    avg(l.leituraUmidadeSolo) as umidade,
                    time(l.dataLeitura) as momento
                    FROM leitura l 
                    join sensor s on l.fkSensor = s.idSensor
                    join plantacao p on s.fkPlantacao = p.idPlantacao
                    where p.idPlantacao = 1 AND p.fkEmpresa = 1 AND s.lote = 1
                    group by time(l.dataLeitura)
                    order by l.dataLeitura desc
                    LIMIT 1;`;

    
    
                            
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal
}
