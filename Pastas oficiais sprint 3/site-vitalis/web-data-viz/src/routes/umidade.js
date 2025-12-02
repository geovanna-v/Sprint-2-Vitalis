var express = require("express");
var router = express.Router();
var umidadeController = require("../controllers/umidadeController");

// Rotas para os gráficos e cards
router.get("/atual/:idPlantacao/:idEmpresa", umidadeController.kpiMediaUmidade);
router.get("/atual/:idPlantacao/:idEmpresa", umidadeController.kpiContarSensor);
router.get("/diaria/:idPlantacao", umidadeController.buscarUmidadeDiaria);
router.get("/semanal/:idPlantacao", umidadeController.buscarUmidadeSemanal);

module.exports = router;
