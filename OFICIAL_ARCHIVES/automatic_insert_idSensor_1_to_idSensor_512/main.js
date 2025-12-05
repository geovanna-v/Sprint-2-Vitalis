const mysql = require("mysql2");
let x = 0;
let y = Number();

let value;
let idSensor;

let poolBancoDados = mysql
  .createPool({
    host: "127.0.0.1",
    user: "Vitalis",
    password: "Caju#2024",
    database: "vitalis",
    port: 3307,
  })
.promise();


// let poolBancoDados = mysql
//   .createPool({
//     host: "127.0.0.1",
//     user: "root",
//     password: "",
//     database: "vitalis",
//     port: 3306,
//   })
//   .promise();

async function asyncCall() {
  value = waveFunc();
  // const dataLeitura = randomDateLast7Days();

  await poolBancoDados.execute(
    "INSERT INTO leitura (fkSensor, leituraUmidadeSolo) VALUES (?, ?)",
    [idSensor, value]
  );

  console.log(`Inserido -> ID: ${idSensor}, Valor: ${value}`);
}

function waveFunc() {
  idSensor = pickRandom();
  x += 0.025;
  y = Math.sin(x) * 25 + 25;

  return Math.abs(y);
}

function pickRandom() {
  const nums = Array.from({ length: 512 }, (_, i) => i + 1);

  const randomIndex = Math.floor(Math.random() * nums.length);
  return nums[randomIndex];
}

// ------------------------------------------------------------
//  FUNCTION: Generate random date in the last 7 days
// ------------------------------------------------------------
// function randomDateLast7Days() {
// const now = new Date();
// const nowMs = now.getTime();

// // random time within the past 7 days
// const sevenDays = 7 * 24 * 60 * 60 * 1000;
// const randomPast = Math.floor(Math.random() * sevenDays);
// const randomDate = new Date(nowMs - randomPast);

// // If the date is today, clamp the hour so it does not exceed the current hour
// const isSameDay =
//   randomDate.getFullYear() === now.getFullYear() &&
//   randomDate.getMonth() === now.getMonth() &&
//   randomDate.getDate() === now.getDate();

// if (isSameDay && randomDate.getHours() > now.getHours()) {
//   randomDate.setHours(now.getHours());
//   randomDate.setMinutes(Math.floor(Math.random() * 60));
//   randomDate.setSeconds(Math.floor(Math.random() * 60));
// }

// // Format output: YYYY-MM-DD HH:MM:SS
// const finalDate = randomDate.toISOString().slice(0, 19).replace("T", " ");
// return finalDate;
// }

// ------------------------------------------------------------

setInterval(() => {
  
    asyncCall().catch(console.error);
  
}, 20);