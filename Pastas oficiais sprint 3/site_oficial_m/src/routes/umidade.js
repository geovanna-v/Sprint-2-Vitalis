var express = require("express");
var router = express.Router();
var umidadeController = require("../controllers/umidadeController");

// Rotas para os gráficos e cards
router.get("/kpiMediaUmidade/:idEmpresa", umidadeController.kpiMediaUmidade);
router.get("/kpiContarSensor/:idPlantacao", umidadeController.kpiContarSensor);

router.get("/diaria/:idPlantacao", umidadeController.buscarUmidadeDiaria);
router.get("/semanal/:idPlantacao", umidadeController.buscarUmidadeSemanal);

router.get("/diariaFill/:idPlantacao", umidadeController.buscarUmidadeDiariaFill);
router.get("/semanalFill/:idPlantacao", umidadeController.buscarUmidadeSemanalFill);

module.exports = router;

