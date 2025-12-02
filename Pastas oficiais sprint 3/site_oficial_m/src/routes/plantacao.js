var express = require("express");
var router = express.Router();

var plantacaoController = require("../controllers/plantacaoController");

router.get("/:empresaId", function (req, res) {
  plantacaoController.buscarPlantacaoEmpresa(req, res);
});

router.post("/adcionarPlantacao", function (req, res) {
  plantacaoController.adcionarPlantacao(req, res);
})

module.exports = router;