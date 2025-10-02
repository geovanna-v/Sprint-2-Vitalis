// var label_explaination = document.getElementById("lavel_title_div_explanation");
var div_explanation = document.getElementById("div_explanation");

var recomendacao_agua = 5000;
// Recomendação Técnica: 5000 m³/ha/ano
var valor_kg_castanha_venda = 4;
// Preço médio da castanha de caju
var qtd_media_castanha_plantacao = 600;
// Média de castanhas por hectare

function economia_agua() {
  var hectare = Number(input_hectare.value); // Área da fazenda
  var consumoAT = Number(input_consumo_agua_atual.value); // Consumo de água atual em m³/ha/ano
  var gasto_atual = hectare * consumoAT;
  // Consumo de água atual da fazenda em m³/ano
  var gasto_ideal = hectare * recomendacao_agua;
  // Consumo de água pela recomendação em m³/ano
  var desperdicio = gasto_atual - gasto_ideal;
  // Quantidade de m³ utilizados a mais do que o recomendado

  var gasto_a_mais_por_ano = desperdicio * 0.4;
  // Preço pago em água a mais por ano, 0,40 é o valor do m³ de água para fazendas
  var gasto_total_ano_atual = gasto_atual * 0.4;
  // Preço pago em água atual
  var gasto_total_ano_ideal = gasto_ideal * 0.4;
  // Preço pago em água seguindo a recomendação

  if (desperdicio < 0) {
    desperdicio = gasto_ideal - gasto_atual;
    gasto_total_ano_ideal = desperdicio * 0.4;

    div_mensage.innerHTML = 
            `Sem os nossos sensores de umidade do solo se perde o controle de água correto a ser utilizada na plantação.
            <br>
            <br>
            Hoje, sua fazenda consome por volta de <b>${gasto_atual} m³/ano de água no total</b>. 
            <br>
            <br> 
            Com essa irrigação, você gasta por volta de <b>R$${gasto_total_ano_atual.toFixed(2)}</b>.
            <br>
            <br> 
            Você está utilizando <b>${desperdicio} m³/ano de água a menos que o ideal</b>, e que custa por volta de <b>R$${gasto_total_ano_ideal.toFixed(2)}</b> para uma fazenda desse porte, isso pode ressecar os frutos e te trazer perdas, essa "economia" de água pode prejudicar a qualidade dos frutos.
            <br>
            <br> 
            Com os nossos sensores para te auxiliar você gastará o ideal na sua irrigação de acordo com seus hectares, que é em torno de <b>${gasto_ideal} m³/ano</b> de água, gasto no qual ganhará lucro pelo aumento da qualidade do caju.<br><br>`;
  } else if (desperdicio == 0) {
    div_mensage.innerHTML = `Sem os nossos sensores de umidade do solo se perde o controle de agua correto que você irriga sua plantação. <br><br>
                Hoje, sua fazenda consome <b>${gasto_atual} m³/ano de água</b>. <br><br> 
                Com essa irrigação você gasta <b>R$${gasto_total_ano_atual.toFixed(
                  2
                )}</b>.<br><br> 
                Você utiliza a quantidade ideal para sua plantação até o momento, nossos sensores podem te auxiliar a 
                <b>manter essa assertividade</b> por muito mais tempo, o que acha?`;
  } else {
    div_mensage.innerHTML = `Sem os nossos sensores de umidade do solo se perde o controle de agua correto que voce está irrigando sua plantação.<br><br>
                    Hoje, sua fazenda consome <b>${gasto_atual} m³/ano de água</b>. <br><br> 
                    Com essa irrigação você gasta <b>R$${gasto_total_ano_atual.toFixed(
                      2
                    )}</b>.<br><br> 
                    Com o desperdício de <b>${desperdicio} m³/ano de água</b>.<br><br> 
                    Com os nossos sensores para te auxiliar você gastará o ideal na sua irrigação de acordo com o porte da fazenda, que é em torno de <b>${gasto_ideal} m³/ano de água</b>.<br><br> 
                    E assim economizará na faixa de <b>R$${gasto_total_ano_ideal.toFixed(
                      2
                    )}</b>.<br><br>`;
  }
}

function economia_castanha() {
  var hectare = Number(input_hectare.value); // Área da fazenda em hectares
  var producao_atual = Number(input_producao_atual.value); // Produção de castanhas atual em Kg/ha

  var producao_atual_calculo = producao_atual * hectare; // Produção atual em Kg/ha/ano
  var receita_atual = producao_atual_calculo * valor_kg_castanha_venda;
  var producao_potencial = hectare * qtd_media_castanha_plantacao; // Produção que pode ser alcançada com o monitoramento ideal
  var perda_de_producao = producao_potencial - producao_atual_calculo; // Produção a menos por causa da falta de monitoramento
  var perda_receita = perda_de_producao * valor_kg_castanha_venda; // Valor perdido
  var lucro = producao_potencial * valor_kg_castanha_venda;
  var porcentagem_lucro = 100 - (receita_atual / lucro) * 100;

  if (producao_atual_calculo < producao_potencial) {
    var subtracao_media_de_producao_castanha = 600 - producao_atual;
    var media_ideal = producao_potencial - producao_atual_calculo;
    div_mensage1.innerHTML = `A sua produção atual sem nossos sensores é de <b>${producao_atual_calculo} Kg/ano de castanhas, a produção ideal para sua fazenda é em torno de ${producao_potencial} Kg. Para a produção atingir a média faltam ${media_ideal} Kg </b>. <br><br> 
            No entanto, com nossos sensores monitorando a umidade e te ajudando com a irrigação ideal do solo, sua produção poderá alcançar em média <b>${producao_potencial} Kg/ano de castanhas</b>.<br><br> 
            Sem nosso projeto sua fazenda tem em média um prejuizo de <b>${media_ideal} Kg/ano de castanhas</b> na produção.<br><br>
            Isso equivale a aproximadamente <b>R$${perda_receita.toFixed(
              2
            )} de receita não aproveitada</b>.<br><br> O lucro com nossos sensores serão em torno de ${porcentagem_lucro.toFixed(
      1
    )}% <br><br>
            Mas isso pode mudar com a implantação do controle adequado de umidade do solo.`;
  } else if (producao_atual_calculo == producao_potencial) {
    div_mensage1.innerHTML = `A sua produção atual sem nossos sensores é de <b>${producao_atual_calculo} Kg/ano de castanhas</b>.<br><br> 
                Sua produção de castanhas está na <b>média estimada</b> para fazendas do mesmo porte.<br><br>
                O monitoramento de umidade do solo ajudará a <b>manter essa assertividade por mais tempo</b>.`;
  } else {
    div_mensage1.innerHTML = `Sua produção de castanhas está <b>acima da média estimada</b> para uma fazenda desse porte.<br><br>
                    Parabéns pelo manejo, o monitoramento pode contribuir para manter esse desempenho.`;
  }
}
