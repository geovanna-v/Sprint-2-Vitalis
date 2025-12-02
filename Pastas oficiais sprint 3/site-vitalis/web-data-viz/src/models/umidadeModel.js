var database = require("../database/config");

function kpiMediaUmidade(idPlantacao, idEmpresa) {
  const sql = `
    SELECT * FROM vw_kpiUmidade WHERE idPlantacao = ${idPlantacao} AND idEmpresa = ${idEmpresa};
    `;
  return database.executar(sql);
}

function kpiContarSensor(idPlantacao, idEmpresa) {
  const sql = `
   SELECT * FROM vw_kpiQtdSensores WHERE idPlantacao = ${idPlantacao} AND idEmpresa = ${idEmpresa};
  `;
   return database.executar(sql);
}

function buscarUmidadeDiaria(idPlantacao, idEmpresa) {
  const sql = `
    SELECT * FROM vw_dashboardDiaria WHERE idPlantacao = ${idPlantacao} AND idEmpresa = ${idEmpresa}; 
    `;
  return database.executar(sql);
}

function buscarUmidadeSemanal(idPlantacao, idEmpresa) {
  const sql = `
   SELECT * FROM wv_dashboardSemanal WHERE idPlantacao = ${idPlantacao} AND idEmpresa = ${idEmpresa};
    `;
  return database.executar(sql);
}

module.exports = {
  kpiMediaUmidade,
  kpiContarSensor,
  buscarUmidadeDiaria,
  buscarUmidadeSemanal
};
