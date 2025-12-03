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
        GROUP BY MINUTE(minute)
        ORDER BY minute
        DESC LIMIT 1;
        
    `;
  return database.executar(sql);
}

function buscarUmidadeSemanal(idPlantacao) {
  const sql = `
        SELECT  
        leitura.dataLeitura AS day,
        ROUND(AVG(leituraUmidadeSolo), 2) AS umidade
        FROM leitura
        JOIN sensor 
        ON leitura.fkSensor = sensor.idSensor
        WHERE sensor.fkPlantacao = ${idPlantacao}
        GROUP BY DATE(leitura.dataLeitura)
        ORDER BY day
        DESC LIMIT 1;
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
        GROUP BY MINUTE(minute)
        ORDER BY leitura.dataleitura
        DESC LIMIT 12;
        
    `;
  return database.executar(sql);
}

function buscarUmidadeSemanalFill(idPlantacao) {
  const sql = `
        SELECT  
        leitura.dataLeitura AS day,
        ROUND(AVG(leituraUmidadeSolo), 2) AS umidade
        FROM leitura
        JOIN sensor 
        ON leitura.fkSensor = sensor.idSensor
        WHERE sensor.fkPlantacao = ${idPlantacao}
        GROUP BY DATE(leitura.dataLeitura)
        ORDER BY leitura.dataLeitura
        DESC LIMIT 7;
    `;
  return database.executar(sql);
}

module.exports = {

  buscarUmidadeDiaria,
  buscarUmidadeSemanal,
  buscarUmidadeDiariaFill,
  buscarUmidadeSemanalFill,
};
