var express = require("express");
var router = express.Router();
var umidadeController = require("../controllers/umidadeController");

// Para as KPI's
router.get("/atual/:idPlantacao", umidadeController.kpiMediaUmidade);
router.get("/atual/:idPlantacao", umidadeController.kpiContarSensor);

// Atualizar com um dado novo
router.get("/diaria/:idPlantacao", umidadeController.buscarUmidadeDiaria);
router.get("/semanal/:idPlantacao", umidadeController.buscarUmidadeSemanal);

// Fill para preencher o gráfico com os dados
router.get("/diariaFill/:idPlantacao", umidadeController.buscarUmidadeDiariaFill);
router.get("/semanalFill/:idPlantacao", umidadeController.buscarUmidadeSemanalFill);

module.exports = router;
