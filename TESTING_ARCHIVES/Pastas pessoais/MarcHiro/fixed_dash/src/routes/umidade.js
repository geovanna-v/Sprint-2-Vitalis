var express = require("express");
var router = express.Router();
var umidadeController = require("../controllers/umidadeController");

// Rotas para os gráficos e cards

router.get("/diaria/:idPlantacao", umidadeController.buscarUmidadeDiaria);
router.get("/semanal/:idPlantacao", umidadeController.buscarUmidadeSemanal);

router.get("/diariaFill/:idPlantacao", umidadeController.buscarUmidadeDiariaFill);
router.get("/semanalFill/:idPlantacao", umidadeController.buscarUmidadeSemanalFill);

module.exports = router;
