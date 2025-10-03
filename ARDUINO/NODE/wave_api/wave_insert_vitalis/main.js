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
            database: 'test_vitalis',
            port: 3306
    }
).promise();


async function asyncCall() {
  console.log("tentando executar");
    value = waveFunc();
    await poolBancoDados.execute(
        'INSERT INTO leituraSensor (fkSensorLote, fkPlantacao, fkEmpresa, umidadeSolo) VALUES (?, ?, ?, ?)',
        ['a0', 1, 1, value]
    );
    console.log("valores inseridos em a0: " + value);

    value = waveFunc();
    await poolBancoDados.execute(
        'INSERT INTO leituraSensor (fkSensorLote, fkPlantacao, fkEmpresa, umidadeSolo) VALUES (?, ?, ?, ?)',
        ['a1', 1, 1, value]
    );
      await poolBancoDados.execute(
        'INSERT INTO leituraSensor (fkSensorLote, fkPlantacao, fkEmpresa, umidadeSolo) VALUES (?, ?, ?, ?)',
        ['b0', 1, 1, value]
    );
    console.log("valores inseridos em a1 e b0: " + value);

    value = waveFunc();
    await poolBancoDados.execute(
        'INSERT INTO leituraSensor (fkSensorLote, fkPlantacao, fkEmpresa, umidadeSolo) VALUES (?, ?, ?, ?)',
        ['a2', 1, 1, value]
    );
    await poolBancoDados.execute(
        'INSERT INTO leituraSensor (fkSensorLote, fkPlantacao, fkEmpresa, umidadeSolo) VALUES (?, ?, ?, ?)',
        ['b1', 1, 1, value]
    );
    await poolBancoDados.execute(
        'INSERT INTO leituraSensor (fkSensorLote, fkPlantacao, fkEmpresa, umidadeSolo) VALUES (?, ?, ?, ?)',
        ['c0', 1, 1, value]
    );
    console.log("valores inseridos em a2, b1 e c0: " + value);

    value = waveFunc();
    await poolBancoDados.execute(
        'INSERT INTO leituraSensor (fkSensorLote, fkPlantacao, fkEmpresa, umidadeSolo) VALUES (?, ?, ?, ?)',
        ['b2', 1, 1, value]
    );
      await poolBancoDados.execute(
        'INSERT INTO leituraSensor (fkSensorLote, fkPlantacao, fkEmpresa, umidadeSolo) VALUES (?, ?, ?, ?)',
        ['c1', 1, 1, value]
    );
    console.log("valores inseridos em b2 e c1: " + value);

    value = waveFunc();
    await poolBancoDados.execute(
        'INSERT INTO leituraSensor (fkSensorLote, fkPlantacao, fkEmpresa, umidadeSolo) VALUES (?, ?, ?, ?)',
        ['c2', 1, 1, value]
    );
    console.log("valores inseridos em a0: " + value);
}


function waveFunc(){
    x += 0.025;
    y = (Math.sin(x) * 100);
    if (y >= 0 ){
        return y
    } 
    else {
        return Math.abs(y)
    }
}
const intervalId = setInterval(() => {
  asyncCall();
}, 2500);