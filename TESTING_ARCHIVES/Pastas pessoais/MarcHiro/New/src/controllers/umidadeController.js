var umidadeModel = require("../models/umidadeModel");

function buscarUmidadeDiaria(req, res) {
    const idPlantacao = req.params.idPlantacao;

    umidadeModel.buscarUmidadeDiaria(idPlantacao)
        .then(resultado => res.json(resultado)) // Mais antigo → mais recente
        .catch(erro => {
            console.log("ERRO controller umidadeDiaria:", erro);
            res.status(500).json(erro);
        });
}

function buscarUmidadeSemanal(req, res) {
    const idPlantacao = req.params.idPlantacao;

    umidadeModel.buscarUmidadeSemanal(idPlantacao)
        .then(resultado => {
        

            

            res.json(resultado);
        })
        .catch(erro => {
            console.log("ERRO controller umidadeSemanal:", erro);
            res.status(500).json(erro);
        });
}



function buscarUmidadeDiariaFill(req, res) {
    const idPlantacao = req.params.idPlantacao;

    umidadeModel.buscarUmidadeDiariaFill(idPlantacao)
        .then(resultado => res.json(resultado)) // Mais antigo → mais recente
        .catch(erro => {
            console.log("ERRO controller umidadeDiaria:", erro);
            res.status(500).json(erro);
        });
}

function buscarUmidadeSemanalFill(req, res) {
    const idPlantacao = req.params.idPlantacao;

    umidadeModel.buscarUmidadeSemanalFill(idPlantacao)
        .then(resultado => { res.json(resultado);})
        .catch(erro => {
            console.log("ERRO controller umidadeSemanal:", erro);
            res.status(500).json(erro);
        });
}

module.exports = {
    buscarUmidadeDiaria,
    buscarUmidadeSemanal,
    buscarUmidadeDiariaFill,
    buscarUmidadeSemanalFill
};
