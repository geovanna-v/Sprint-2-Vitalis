var database = require("../database/config");

function buscarplantacoesPorEmpresa(idEmpresa) {
  var instrucaoSql = `SELECT idPlantacao, fkEmpresa, areaM2 FROM plantacao WHERE fkEmpresa = ${idEmpresa}`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);

  
}

function buscarplantacoes() {
  var instrucaoSql = `SELECT * FROM plantacao`;
  // console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);

}

function adcionarPlantacao(idEmpresa, areaM2, tipoSolo) {

    
    var instrucaoSql = `INSERT INTO plantacao (fkEmpresa, areaM2, tipoSolo) VALUES (${idEmpresa}, ${areaM2}, '${tipoSolo}')`;
    return database.executar(instrucaoSql);

  
}


module.exports = {
  buscarplantacoesPorEmpresa,
  adcionarPlantacao
}
