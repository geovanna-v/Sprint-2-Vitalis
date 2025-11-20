var usuarioModel = require("../models/usuarioModel");
var plantacaoModel = require("../models/plantacaoModel");

function autenticar(req, res) {
  var email = req.body.emailServer;
  var senha = req.body.senhaServer;

  if (email == undefined) {
    res.status(400).send("Seu email está undefined!");
  } else if (senha == undefined) {
    res.status(400).send("Sua senha está indefinida!");
  } else {
    usuarioModel
      .autenticar(email, senha)
      .then(function (resultadoAutenticar) {
        console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
        console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String
        if (resultadoAutenticar.length == 1) {
          console.log(resultadoAutenticar);
          plantacaoModel
            .buscarplantacaosPorEmpresa(resultadoAutenticar[0].idEmpresa)
            .then((resultadoplantacoes) => {
              if (resultadoplantacoes.length > 0) {
                res.json({
                  idEmpresa: resultadoAutenticar[0].idEmpresa,
                  email: resultadoAutenticar[0].email,
                  razaoSocial: resultadoAutenticar[0].razaoSocial,
                  senha: resultadoAutenticar[0].senha,
                  plantacoes: resultadoplantacoes,
                });
              }
            });
        } else if (resultadoAutenticar.length == 0) {
          usuarioModel
            .autenticar_user(email, senha)
            .then(function (resultadoAutenticar) {
              console.log(
                `\nResultados encontrados: ${resultadoAutenticar.length}`
              );
              console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String
              console.log(resultadoAutenticar);
              plantacaoModel
                .buscarplantacoesPorEmpresa(resultadoAutenticar[0].fkEmpresa)
                .then((resultadoplantacoes) => {
                  if (resultadoplantacoes.length > 0) {
                    res.json({
                      idUsuario: resultadoAutenticar[0].idUsuario,
                      fkEmpresa: resultadoAutenticar[0].fkEmpresa,
                      apelidoUsuario: resultadoAutenticar[0].apelidoUsuario,
                      email: resultadoAutenticar[0].email,
                      plantacoes: resultadoplantacoes,
                    });
                  }
                });
            });
        }
      })
      .catch(function (erro) {
        console.log(erro);
        console.log(
          "\nHouve um erro ao realizar o login! Erro: ",
          erro.sqlMessage
        );
        res.status(500).json(erro.sqlMessage);
      });
  }
}

function cadastrar(req, res) {
  // Crie uma variável que vá recuperar os valores do arquivo cadastro.html

  // empresaServer: empresaVar,
  // cnpjServer: cnpjVar,
  // emailServer: emailVar,
  // senhaServer: senhaVar
  var empresa = req.body.empresaServer;
  var cnpj = req.body.cnpjServer;
  var email = req.body.emailServer;
  var senha = req.body.senhaServer;

  // Faça as validações dos valores
  if (empresa == undefined) {
    res.status(400).send("Seu empresa está undefined!");
  } else if (email == undefined) {
    res.status(400).send("Seu email está undefined!");
  } else if (senha == undefined) {
    res.status(400).send("Sua senha está undefined!");
  } else if (cnpj == undefined) {
    res.status(400).send("Sua empresa a vincular está undefined!");
  } else {
    // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
    usuarioModel
      .cadastrar(empresa, email, senha, cnpj)
      .then(function (resultado) {
        res.json(resultado);
      })
      .catch(function (erro) {
        console.log(erro);
        console.log(
          "\nHouve um erro ao realizar o cadastro! Erro: ",
          erro.sqlMessage
        );
        res.status(500).json(erro.sqlMessage);
      });
  }
}

module.exports = {
  autenticar,
  cadastrar,
};
