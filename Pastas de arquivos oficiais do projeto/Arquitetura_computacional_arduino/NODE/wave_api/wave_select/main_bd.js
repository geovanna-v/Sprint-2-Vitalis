const mysql = require("mysql2/promise"); // Use the promise version of mysql2
const express = require("express");
const port = 3300;

// Initialize an empty array to store sensor values
const valoresSensorAnalogico = [];

const poolBancoDados = mysql.createPool({
  // Configure your database connection here
        host: 'localhost',
        user: 'root',
        password: 'Alucard22*',
        database: 'test_vitalis',
        port: 3306
});

let page = 1; // Start with page 1
const pageSize = 9;


const fetchSensorData = async () => {
  const offset = ((page - 1) * pageSize);
  const pageSizeNum = Number(pageSize);
  const offsetNum = Number(offset);

  if (isNaN(pageSizeNum) || isNaN(offsetNum)) {
    throw new Error("pageSize ou offset inválidos");
  }
  try {
    const [rows] = await poolBancoDados.execute(
      `SELECT fkSensorLote,
              umidadeSolo
              FROM leituraSensor
              ORDER BY idLeitura
              LIMIT ${pageSizeNum} 
              OFFSET ${offsetNum}`
    );
    console.log(rows);
    if (rows.length === 0) {
      // If no data is returned, reset to page 1 for the next cycle
      page = 1;
      return [];
    } else {
      page++;
      return rows;
    }
  } catch (err) {
    console.error("Erro na query:", err.message);
    return []; // Return an empty array on error
  }
};


const updateSensorDataLoop = async () => {
  try {
    const newReadings = await fetchSensorData();
    // Clear the old data and add the new readings
    valoresSensorAnalogico.splice(0, valoresSensorAnalogico.length, ...newReadings);
  } catch (err) {
    console.error("Erro no loop de atualização:", err.message);
  } finally {
    // Schedule the next update after a delay
    setTimeout(updateSensorDataLoop, 2500);
  }
};

/**
 * Sets up and starts the Express server.
 */
const startServer = () => {
  const app = express();

  // CORS middleware
  app.use((request, response, next) => {
    response.header("Access-Control-Allow-Origin", "*");
    response.header("Access-Control-Allow-Headers", "Origin, Content-Type, Accept");
    next();
  });

  // API endpoint
  app.get("/sensores/Analogico", (_, response) => {
    return response.json(valoresSensorAnalogico);
  });

  // Start the server
  app.listen(port, () => {
    console.log(`API executada com sucesso na porta ${port}`);
  });
};
// Main execution block
(async () => {
  // Perform the initial data load
  const initialData = await fetchSensorData();
  valoresSensorAnalogico.push(...initialData);

  // Start the Express server
  startServer();

  // Start the periodic data update loop
  updateSensorDataLoop();
})();
