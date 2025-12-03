const mysql = require("mysql2");
let x = 0;
let y = Number();

let value;
let idSensor;
let poolBancoDados = mysql
  .createPool({
    host: "127.0.0.1",
    user: "aluno",
    password: "sptech",
    database: "vitalis",
    port: 3306,
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

idSensor = pickRandom();

  x += 0.025;
  y = Math.sin(x) * 100;
  if (y >= 0) {
    return y;
  } else {
    return Math.abs(y);
  }
}
function pickRandom() {
    const nums = 
    [
      1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
    ];

    const randomIndex = Math.floor(Math.random() * nums.length);
    return nums[randomIndex];
}


setInterval(() => {
  for (let i = 0; i < 4; i++) {
    asyncCall().catch(console.error);
  }
}, 100);
