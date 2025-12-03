var database = require("../database/config");


function buscarUmidadeDiaria(idPlantacao) {
  const sql = `
    SELECT dataLeitura AS minute,
        ROUND(AVG(leituraUmidadeSolo), 2) AS umidade
        FROM leitura
        JOIN sensor ON leitura.fkSensor = sensor.idSensor
        WHERE sensor.fkPlantacao = ${idPlantacao}
        GROUP BY MINUTE(leitura.dataLeitura)
        ORDER BY minute DESC LIMIT 1;
        
    `;
  return database.executar(sql);
}

function buscarUmidadeSemanal(idPlantacao) {
  const sql = `
SELECT  DATE(dataLeitura) AS dia,
        ROUND(AVG(leituraUmidadeSolo), 2) AS umidade
        FROM leitura
        JOIN sensor ON leitura.fkSensor = sensor.idSensor
        WHERE sensor.fkPlantacao = ${idPlantacao}
        GROUP BY DATE(leitura.dataLeitura)
        ORDER BY dia
        DESC LIMIT 1;
    `;
  return database.executar(sql);
}






function buscarUmidadeDiariaFill(idPlantacao) {
  const sql = `
    SELECT dataLeitura AS minute,
        ROUND(AVG(leituraUmidadeSolo), 2) AS umidade
        FROM leitura
        JOIN sensor ON leitura.fkSensor = sensor.idSensor
        WHERE sensor.fkPlantacao = ${idPlantacao}
        GROUP BY MINUTE(leitura.dataLeitura)
        ORDER BY minute DESC LIMIT 10;
        
    `;
  return database.executar(sql);
}

function buscarUmidadeSemanalFill(idPlantacao) {
  const sql = `
SELECT  DATE(dataLeitura) AS dia,
        ROUND(AVG(leituraUmidadeSolo), 2) AS umidade
        FROM leitura
        JOIN sensor ON leitura.fkSensor = sensor.idSensor
        WHERE sensor.fkPlantacao = ${idPlantacao}
        GROUP BY DATE(leitura.dataLeitura)
        ORDER BY dia
        DESC LIMIT 10;
    `;
  return database.executar(sql);
}

module.exports = {

  buscarUmidadeDiaria,
  buscarUmidadeSemanal,
  buscarUmidadeDiariaFill,
  buscarUmidadeSemanalFill,
};
