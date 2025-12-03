// Total de convites usados por cada usuário
function leituraEmpresas(idEmpresa) {    var instrucao = `
   SELECT 
    dataLeitura,
    leituraUmidadeSolo,
    fkSensor
    FROM leitura
		WHERE fkSensor = ${idEmpresa}
        ORDER BY dataLeitura;
    `;
    return database.executar(instrucao);
}

module.exports = {
    leituraEmpresas
};