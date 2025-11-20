var database = require("../database/config");

function buscarplantacoesPorEmpresa(empresaId) {

  var instrucaoSql = `SELECT idPlantacao, fkEmpresa, areaM2 FROM plantacao WHERE fkEmpresa = ${empresaId} limit 1`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresaId, descricao) {
  
  var instrucaoSql = `INSERT INTO (descricao, fk_empresa) plantacao VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarplantacoesPorEmpresa,
  cadastrar
}
