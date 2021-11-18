# Pacote ADPrev - Análise de Dados Previdenciários dos RPPS

O objetivo do pacote é facilitar o uso dos dados previdenciários dos RPPS
diponibilizados pela Subsecretaria dos Regimes Próprios de Previdência Social - SPREV
por intermédio da [API disponibilizada com esse objetivo](https://apicadprev.economia.gov.br/api-docs/).

Para tanto o pacote oferece um conjunto de funções para extração dos dados da
API e limpeza dos mesmos. Além disso, outras funções utilitárias também são
disponibilizadas sempre com o objetivo de facilitar a análise dos dados
previdenciários.

Grande parte dos dados disponibilizados pela API no presente momento provêm dos
seguintes demonstrativos:

* DAIR - Demonstrativo das Aplicações e Investimentos dos Recursos
* DIPR - Demonstrativo de Informações Previdenciárias e Repasses
* DRAA - Demonstrativo de Resultados da Avaliação Atuarial 

Além disso, também é possível obter dados relativos às alíquotas de contribuição praticadas
pelos RPPS, a relação dos entes federativos com informações sobre a qual regime
previdenciário estão vinculados e informações sobre o Certificado de Regularidade 
Previdenciária - CRP.

Espera-se que num futuro próximo, a API disponibilize também dados relativos ao DPIN,
aos Fluxos Atuariais, aos Termos de Parcelamento de Débitos e às
Compensações Previdenciária - COMPREV.



## Instalação

O pacote pode ser instalado através do GitHub utilizando o seguinte código em R:

```
# install.packages("devtools")
devtools::install_github("marcosfs2006/ADPrev")
library(ADPrev)

```

## Como usar?

O pacote possui um conjunto de funções cujo objetivo é facilitar a obtenção dos
dados disponibilizados na API do CADPREV Web. Exemplos de uso de cada função
podem ser obtidos na ajuda das mesmas. 

Caso haja interesse, por exemplo, em se obter os dados do CRP para os RPPS do
estado do Rio de Janeiro pode-se utilizar a função `get_crp()` para extrair os dados da API


```
crp_rj <- get_crp(sg_uf="RJ")

```

## Status 

O pacote está ainda em estágio bem inicial de desenvolvimento. As funções ainda estão sendo
desenvolvidas, testadas e modificadas.


## Como contribuir

Contribuições são bem-vindas. Para sugestões de alteração mais profundas favor abrir
inicialmente uma issue com o objetivo de discutirmos o que você gostaria de
modificar.


## Licença
----

[MIT](https://choosealicense.com/licenses/mit/)
