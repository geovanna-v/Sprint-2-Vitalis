var plantacaoModel = require("../models/plantacaoModel");

function buscarPlantacaoEmpresa(req, res) {
  var idUsuario = req.params.idUsuario;

  plantacaoModel.buscarPlantacaoEmpresa(idUsuario).then((resultado) => {

      res.status(200).json(resultado);

  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar as plantacoes: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}


function adcionarPlantacao(req, res) {
  var idEmpresa = req.body.idEmpresa;
  var areaM2 = req.body.areaM2;
  var tipoSolo = req.body.tipoSolo;

    plantacaoModel.adcionarPlantacao(idEmpresa, areaM2, tipoSolo)
      .then((resultado) => {
        res.status(200).json(resultado);
      });
  
}

module.exports = {
  buscarPlantacaoEmpresa,
  adcionarPlantacao
}