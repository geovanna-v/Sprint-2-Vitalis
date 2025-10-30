const mysql = require("mysql2");
let x = 0;
let y = Number();

let value;
let idSensor;
let poolBancoDados = mysql
  .createPool({
    host: "127.0.0.1",
    user: "aluno",
    password: "Sptech#2024",
    database: "vitalis",
    port: 3307,
  })
  .promise();

async function asyncCall() {
  console.log("tentando executar");
  value = waveFunc();
  await poolBancoDados.execute(
    "INSERT INTO leitura (fkSensor, leituraUmidadeSolo) VALUES (?, ?)",
    [idSensor, value]
  );
  console.log(`valores inseridos em ${idSensor}:` + value);
}

function waveFunc() {

idSensor = Math.floor(Math.random() * 511) + 1;

  x += 0.025;
  y = Math.sin(x) * 100;
  if (y >= 0) {
    return y;
  } else {
    return Math.abs(y);
  }
}

const intervalId = setInterval(() => {
  asyncCall();
}, 100);
