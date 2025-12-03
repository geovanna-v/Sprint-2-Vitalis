var express = require("express");
var router = express.Router();
var umidadeController = require("../controllers/umidadeController");

// Rotas para os gráficos e cards
router.get("/atual/:idEmpresa", umidadeController.buscarUmidadeAtual);
router.get("/diaria/:idEmpresa", umidadeController.buscarUmidadeDiaria);
router.get("/semanal/:idEmpresa", umidadeController.buscarUmidadeSemanal);

module.exports = router;
