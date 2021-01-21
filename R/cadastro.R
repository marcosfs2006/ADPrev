#' Regime Previdenciário do Ente
#'
#' Este conjunto de dados consiste na relação dos entes com a indicação do
#' regime previdenciário (`RGPS` ou `RPPS`) ao qual está vinculado.
#'
#' @name cadastro
#' @format Data frame contendo quatro variáveis
#' \describe{
#'   \item{cnpj}{número do CNPJ do ente}
#'   \item{uf}{sigla da unidade da federação}
#'   \item{ente}{nome do ente}
#'   \item{regime}{regime previdenciário ao qual o ente está vinculado.`RGPS`, `RPPS` ou `RPPS em Extinção`}
#' }
#' @details 
#' Os dados referem-se à atualização de DEZ/2020 disponibilizada em 20.01.2021.
#' 
#' Data de extração: 20.01.2021
#'  
#' Exemplos de uso deste conjunto de dados podem ser vistos no
#' tutorial [Análise de Dados Previdenciários - ADPrev](https://marcosfs2006.github.io/ADPrevBook/)
#'    
#' @source \url{https://www.gov.br/previdencia/pt-br/assuntos/previdencia-no-servico-publico/estatisticas-e-informacoes-dos-rpps-1/estatisticas-e-informacoes-dos-rpps}
#' @md
"cadastro"
