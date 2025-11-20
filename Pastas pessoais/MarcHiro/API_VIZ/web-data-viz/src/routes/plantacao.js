var express = require("express");
var router = express.Router();

var plantacaoController = require("../controllers/plantacaoController");

router.get("/:empresaId", function (req, res) {
  plantacaoController.buscarPlantacaoEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  plantacaoController.cadastrar(req, res);
})

module.exports = router;