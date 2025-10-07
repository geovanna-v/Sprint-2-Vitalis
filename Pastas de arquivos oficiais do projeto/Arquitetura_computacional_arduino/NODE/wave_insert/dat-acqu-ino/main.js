const mysql = require('mysql2');
let x = 0;
let y = Number();

let value;
let sensor;
let poolBancoDados = mysql.createPool(
    {
            host: 'localhost',
            user: 'root',
            password: 'Alucard22*',
            database: 'vitalis',
            port: 3306
    }
).promise();


async function asyncCall() {
  console.log("tentando executar");
    value = waveFunc();
    sensor = getRandomInt(1, 4);
    await poolBancoDados.execute(
        'INSERT INTO leituraSensor (umidadeSolo, fkSensor) VALUES (?, ?)',
        [value , sensor]
    );
    console.log("valores inseridos no banco: " + value + '  em  ' + sensor);
}

function waveFunc(){
    x += 1;
    y = (Math.sin(x) * 100);
    if (y >= 0 ){
        return y
    } 
    else {
        return Math.abs(y)
    }
}
function getRandomInt(min, max) {
  min = Math.ceil(min);
  max = Math.floor(max);
  return (Math.floor((Math.random() * (max - min + 1)) + min));
}

const intervalId = setInterval(() => {
  asyncCall();
}, 5000);