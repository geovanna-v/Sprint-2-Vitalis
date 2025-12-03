var database = require("../database/config");


function buscarUmidadeDiaria(idPlantacao) {
  const sql = `
    SELECT 
        leitura.dataLeitura AS minute,
        ROUND(AVG(leitura.leituraUmidadeSolo), 2) AS umidade
        FROM leitura
        JOIN sensor
        ON leitura.fkSensor = sensor.idSensor
        WHERE sensor.fkPlantacao = ${idPlantacao}
        GROUP BY minute
        ORDER BY minute
        DESC LIMIT 1;
        
    `;
  return database.executar(sql);
}

function buscarUmidadeSemanal(idPlantacao) {
  const sql = `
        SELECT  
        DATE(leitura.dataLeitura) AS day,
        ROUND(AVG(leituraUmidadeSolo), 2) AS umidade
        FROM leitura
        JOIN sensor 
        ON leitura.fkSensor = sensor.idSensor
        WHERE sensor.fkPlantacao = ${idPlantacao}
        GROUP BY DATE(leitura.dataLeitura)
        ORDER BY DATE(leitura.dataLeitura)
        DESC LIMIT 1;
    `;
  return database.executar(sql);
}

function kpiMediaUmidade(idEmpresa) {
  const sql = `
    SELECT media as valor FROM vw_kpiUmidade WHERE idEmpresa = ${idEmpresa};
    `;
  return database.executar(sql);
}

function kpiContarSensor(idPlantacao) {
  const sql = `
   SELECT quantidade FROM vw_kpiQtdSensores WHERE idPlantacao = ${idPlantacao};
  `;
   return database.executar(sql);
}




function buscarUmidadeDiariaFill(idPlantacao) {
  const sql = `
    SELECT 
        leitura.dataLeitura AS minute,
        ROUND(AVG(leitura.leituraUmidadeSolo), 2) AS umidade
        FROM leitura
        JOIN sensor
        ON leitura.fkSensor = sensor.idSensor
        WHERE sensor.fkPlantacao = ${idPlantacao}
        GROUP BY minute
        ORDER BY minute
        DESC LIMIT 12;
    `;
  return database.executar(sql);
}

function buscarUmidadeSemanalFill(idPlantacao) {
  const sql = `
        SELECT  
        DATE(leitura.dataLeitura) AS day,
        ROUND(AVG(leituraUmidadeSolo), 2) AS umidade
        FROM leitura
        JOIN sensor 
        ON leitura.fkSensor = sensor.idSensor
        WHERE sensor.fkPlantacao = ${idPlantacao}
        GROUP BY DATE(leitura.dataLeitura)
        ORDER BY DATE(leitura.dataLeitura)
        DESC LIMIT 7;
    `;
  return database.executar(sql);
}

module.exports = {
  kpiMediaUmidade,
  kpiContarSensor,
  buscarUmidadeDiaria,
  buscarUmidadeSemanal,
  buscarUmidadeDiariaFill,
  buscarUmidadeSemanalFill,
};
