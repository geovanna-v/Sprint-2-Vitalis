const int PINO_SENSOR_UMIDADE_SOLO = A0;
const int ValorAr = 550;
const int ValorAgua = 230;

// int umidade_maxima = 80;
// int umidade_minima = 75;

int leituraSensor = 0;


void setup() {
  Serial.begin(9600);
  pinMode(PINO_SENSOR_UMIDADE_SOLO, INPUT);
}

void loop() {
  int leituraSensor = analogRead(PINO_SENSOR_UMIDADE_SOLO); 

  int faixa = ValorAr - ValorAgua;

  int distancia = ValorAr - leituraSensor;
  
  float porcentagemUmidade = (float(distancia) / faixa) * 100.0;
  porcentagemUmidade = constrain(porcentagemUmidade, 0.0, 100.0);
  Serial.println(porcentagemUmidade);
  delay(1000);
} 