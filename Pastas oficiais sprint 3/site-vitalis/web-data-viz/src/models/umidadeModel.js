var database = require("../database/config");

function kpiMediaUmidade(idPlantacao) {
  const sql = `
    SELECT * FROM vw_kpiUmidade WHERE idPlantacao = ${idPlantacao};
    `;
  return database.executar(sql);
}

function kpiContarSensor(idPlantacao) {
  const sql = `
   SELECT * FROM vw_kpiQtdSensores WHERE idPlantacao = ${idPlantacao};
  `;
   return database.executar(sql);
}

function buscarUmidadeDiaria(idPlantacao) {
  const sql = `
    SELECT * FROM vw_dashboardDiaria WHERE sensor.fkPlantacao = ${idPlantacao}; 
    `;
  return database.executar(sql);
}

function buscarUmidadeSemanal(idPlantacao) {
  const sql = `
   SELECT * FROM wv_dashboardSemanal WHERE sensor.fkPlantacao = ${idPlantacao};
    `;
  return database.executar(sql);
}

function buscarUmidadeDiariaFill(idPlantacao) {
  const sql = `
   SELECT * FROM wv_dashboardDiariaFill WHERE sensor.fkPlantacao = ${idPlantacao};
    `;
  return database.executar(sql);
}

function buscarUmidadeSemanalFill(idPlantacao) {
  const sql = `
   SELECT * FROM wv_dashboardSemanalFill WHERE sensor.fkPlantacao = ${idPlantacao};
    `;
  return database.executar(sql);
}

module.exports = {
  kpiMediaUmidade,
  kpiContarSensor,
  buscarUmidadeDiaria,
  buscarUmidadeSemanal,
  buscarUmidadeDiariaFill,
  buscarUmidadeSemanalFill
};
