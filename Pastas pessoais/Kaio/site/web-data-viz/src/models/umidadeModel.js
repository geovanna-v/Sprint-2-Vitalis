var database = require("../database/config");

function buscarUmidadeAtual(idEmpresa) { // KPI da umidade do solo (última leitura)
  const sql = `
    SELECT * FROM vw_kpiUmidade;
    `;
  return database.executar(sql);
}

function buscarUmidadeDiaria(idEmpresa) { // Dados para a dashboard de umidade diaria (de hora em hora)
  const sql = `
    SELECT * FROM vw_dashboardUmidade;
    `;
  return database.executar(sql);
}

function buscarUmidadeSemanal(idEmpresa) { // Dados para a dashboard de umidade semanal
  const sql = `
    SELECT * FROM vw_dashboardSemanal;
    `;
  return database.executar(sql);
}

function buscarQtdSensor() {
  const sql = `
  SELECT * FROM vw_kpiQtdSensores;
  `
}

module.exports = {
  buscarUmidadeAtual,
  buscarUmidadeDiaria,
  buscarUmidadeSemanal,
  buscarQtdSensor
};
