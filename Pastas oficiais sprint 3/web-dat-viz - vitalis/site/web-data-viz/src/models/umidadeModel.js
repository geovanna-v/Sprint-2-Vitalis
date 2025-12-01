var database = require("../database/config");

function buscarUmidadeAtual(idPlantacao) {
  const sql = `
    SELECT leitura.leituraUmidadeSolo AS valor
        FROM leitura
        JOIN sensor ON leitura.fkSensor = sensor.idSensor
        WHERE sensor.fkPlantacao = ${idPlantacao}
        ORDER BY leitura.idLeitura DESC
        LIMIT 1;
    `;
  return database.executar(sql);
}

function buscarUmidadeDiaria(idPlantacao) {
  const sql = `
    SELECT HOUR(dataLeitura) AS hora,
        ROUND(AVG(leituraUmidadeSolo), 2) AS umidade
        FROM leitura
        JOIN sensor ON leitura.fkSensor = sensor.idSensor
        WHERE sensor.fkPlantacao = 1
        GROUP BY HOUR(dataLeitura)
        ORDER BY hora;
    `;
  return database.executar(sql);
}

function buscarUmidadeSemanal(idPlantacao) {
  const sql = `
SELECT DATE(dataLeitura) AS dia,
       ROUND(AVG(leituraUmidadeSolo), 2) AS media
FROM leitura
JOIN sensor ON leitura.fkSensor = sensor.idSensor
WHERE sensor.fkPlantacao = ${idPlantacao}
GROUP BY DATE(dataLeitura)
ORDER BY dia;
    `;
  return database.executar(sql);
}

module.exports = {
  buscarUmidadeAtual,
  buscarUmidadeDiaria,
  buscarUmidadeSemanal,
};
