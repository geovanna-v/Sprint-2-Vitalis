var umidadeModel = require("../models/umidadeModel");
function buscarUmidadeAtual(req, res) {
    const idPlantacao = req.params.idPlantacao;

    umidadeModel.buscarUmidadeAtual(idPlantacao)
        .then(resultado => res.json(resultado[0] || { valor: null }))
        .catch(erro => {
            console.log("ERRO controller umidadeAtual:", erro);
            res.status(500).json(erro);
        });
}

function buscarUmidadeDiaria(req, res) {
    const idPlantacao = req.params.idPlantacao;

    umidadeModel.buscarUmidadeDiaria(idPlantacao)
        .then(resultado => res.json(resultado.reverse())) // Mais antigo → mais recente
        .catch(erro => {
            console.log("ERRO controller umidadeDiaria:", erro);
            res.status(500).json(erro);
        });
}

function buscarUmidadeSemanal(req, res) {
    const idPlantacao = req.params.idPlantacao;

    umidadeModel.buscarUmidadeSemanal(idPlantacao)
        .then(resultado => {
            const dadosFormatados = [];

            for (let i = 0; i < resultado.length; i++) {
                const item = resultado[i];
                dadosFormatados.push({
                    dia: item.dia.toISOString().slice(0, 10), // YYYY-MM-DD
                    media: item.media
                });
            }

            res.json(dadosFormatados);
        })
        .catch(erro => {
            console.log("ERRO controller umidadeSemanal:", erro);
            res.status(500).json(erro);
        });
}

module.exports = {
    buscarUmidadeAtual,
    buscarUmidadeDiaria,
    buscarUmidadeSemanal
};
