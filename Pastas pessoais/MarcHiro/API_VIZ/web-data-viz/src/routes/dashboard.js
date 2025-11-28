var express = require("express");
var router = express.Router();
var conviteController = require("../controllers/dashboardController"); // << caminho correto?

router.get("/quantidade/:idEmpresa", conviteController.obterQuantidade);
router.get("/ranking/total", conviteController.rankingTotal);

module.exports = router;