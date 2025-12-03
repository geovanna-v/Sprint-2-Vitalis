// var ambiente_processo = 'producao';
var ambiente_processo = 'desenvolvimento';
var caminho_env = ambiente_processo === 'producao' ? '.env' : '.env.dev';
// Acima, temos o uso do operador ternário para definir o caminho do arquivo .env
// A sintaxe do operador ternário é: condição ? valor_se_verdadeiro : valor_se_falso

require("dotenv").config({ path: caminho_env });

const { GoogleGenAI } = require("@google/genai");

var express = require("express");
var cors = require("cors");
var path = require("path");

var PORTA_APP = process.env.APP_PORT;
var HOST_APP = process.env.APP_HOST;

const PORTA_SERVIDOR = process.env.PORTA;
const chatIA = new GoogleGenAI({ apiKey: process.env.MINHA_CHAVE });


var app = express();

var indexRouter = require("./src/routes/index");
var usuarioRouter = require("./src/routes/usuarios");
var plantacaoRouter = require("./src/routes/plantacao");
var umidadeRouter = require("./src/routes/umidade");

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));

app.use(cors());


app.use("/", indexRouter);
app.use("/usuarios", usuarioRouter);
app.use("/umidade", umidadeRouter);
app.use("/plantacao", plantacaoRouter);


app.listen(PORTA_APP, function () {
    console.log(`
  
__/\\\\\\________/\\\\\\___/\\\\\\\\\\\\\\\\\\\\\\___/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\______/\\\\\\\\\\\\\\\\\\______/\\\\\\_______________/\\\\\\\\\\\\\\\\\\\\\\______/\\\\\\\\\\\\\\\\\\\\\\___        
 _\\/\\\\\\_______\\/\\\\\\__\\/////\\\\\\///___\\///////\\\\\\/////_____/\\\\\\\\\\\\\\\\\\\\\\\\\\___\\/\\\\\\______________\\/////\\\\\\///_____/\\\\\\/////////\\\\\\_       
  _\\//\\\\\\______/\\\\\\_______\\/\\\\\\____________\\/\\\\\\_________/\\\\\\/////////\\\\\\__\\/\\\\\\__________________\\/\\\\\\_______\\//\\\\\\______\\///__      
   __\\//\\\\\\____/\\\\\\________\\/\\\\\\____________\\/\\\\\\________\\/\\\\\\_______\\/\\\\\\__\\/\\\\\\__________________\\/\\\\\\________\\////\\\\\\_________     
    ___\\//\\\\\\__/\\\\\\_________\\/\\\\\\____________\\/\\\\\\________\\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\__\\/\\\\\\__________________\\/\\\\\\___________\\////\\\\\\______    
     ____\\//\\\\\\/\\\\\\__________\\/\\\\\\____________\\/\\\\\\________\\/\\\\\\/////////\\\\\\__\\/\\\\\\__________________\\/\\\\\\______________\\////\\\\\\___   
      _____\\//\\\\\\\\\\___________\\/\\\\\\____________\\/\\\\\\________\\/\\\\\\_______\\/\\\\\\__\\/\\\\\\__________________\\/\\\\\\_______/\\\\\\______\\//\\\\\\__  
       ______\\//\\\\\\_________/\\\\\\\\\\\\\\\\\\\\\\________\\/\\\\\\________\\/\\\\\\_______\\/\\\\\\__\\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\___/\\\\\\\\\\\\\\\\\\\\\\__\\///\\\\\\\\\\\\\\\\\\\\\\/___ 
        _______\\///_________\\///////////_________\\///_________\\///________\\///___\\///////////////___\\///////////_____\\///////////_____ 
    \n\n\n                                                                                                 
    Servidor do seu site já está rodando! Acesse o caminho a seguir para visualizar .: http://${HOST_APP}:${PORTA_APP} :. \n\n
    Você está rodando sua aplicação em ambiente de .:${process.env.AMBIENTE_PROCESSO}:. \n\n
    \tSe .:desenvolvimento:. você está se conectando ao banco local. \n
    \tSe .:producao:. você está se conectando ao banco remoto. \n\n
    \t\tPara alterar o ambiente, comente ou descomente as linhas 1 ou 2 no arquivo 'app.js'\n\n`);
});



app.use(express.json());
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept');
    next();
});

app.listen(PORTA_SERVIDOR, () => {
    console.info(`A API BobIA iniciada, acesse http://localhost:${PORTA_SERVIDOR}`);
});

app.post("/perguntar", async (req, res) => {
    const pergunta = req.body.pergunta;

    try {
        const resultado = await gerarResposta(pergunta);
        res.json({ resultado });
    } catch (error) {
        res.status(500).json({ error: 'Erro interno do servidor' });
    }

});

async function gerarResposta(mensagem) {

    try {
        // gerando conteúdo com base na pergunta
        const modeloIA = chatIA.models.generateContent({
            model: "gemini-2.0-flash",
            contents: `Em um parágrafo responda: ${mensagem}`

        });
        const resposta = (await modeloIA).text;
        const tokens = (await modeloIA).usageMetadata;

        console.log(resposta);
        console.log("Uso de Tokens:", tokens);

        return resposta;
    } catch (error) {
        console.error(error);
        throw error;
    }
}