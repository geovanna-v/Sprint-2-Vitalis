
//DECLARAÇÕES DE VARIAVEIS:
const int PINO_SENSOR_UMIDADE_SOLO = A0;
const int ValorAr = 550;      // VALOR RECEBIDO QUANDO SECO      //500ma 0ma // CONSIDERANDO ESPECIFICAÇÕES DO SENSOR E ANOMALIAS RECORENTES
const int ValorAgua = 230;    // VALOR RECEBIDO QUANDO SUBMERSO   //500ma 0ma
//medida depende da caracteristica eletrônica
//R = V/i
//LEI DE ÔHM
//
//P = V * i
//LEI DA POTÊNCIA

int leituraSensor = 0;


void setup() {
  // PROCESSO DE CONFIGURAÇÃO PARA INTERPRETADOR EXTERNO
  Serial.begin(9600); // baud rate -- quanta informacao é transmitida pela porta serial
  pinMode(PINO_SENSOR_UMIDADE_SOLO, INPUT);
}

void loop() {
  // PROCESSO DE EXECUÇÃO/LEITURA

  int leituraSensor = analogRead(PINO_SENSOR_UMIDADE_SOLO); 

  int faixa = ValorAr - ValorAgua; // valor minimo(seco/550) - valor maximo(molhado/230)
  int leitura = ValorAr - leituraSensor; // valor minimo(seco/550) - valor medido(pelo sensor, leitura analog A0)

  // int >> NUMERO INTEIRO
  // float >> NUMERO COM DECIMAL

  float porcentagemUmidade = (float(leitura) / faixa) * 100.0;

  //porcentagemUmidade = constrain(porcentagemUmidade, 0.0, 100.0); 
  //CONSTRAINT ATUALMENTE NÃO NESSESSARIA;

  Serial.println(porcentagemUmidade);
 

  delay(1000); //MILISEGUNDO












} 