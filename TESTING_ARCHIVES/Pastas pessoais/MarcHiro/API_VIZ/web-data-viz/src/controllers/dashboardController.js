function TotalLeiturasEmpresa(req, res) {
    conviteModel.leituraEmpresas()
        .then(resultado => res.status(200).json(resultado))
        .catch(erro => res.status(500).json(erro.sqlMessage));
}


module.exports = {
    TotalLeiturasEmpresa
};