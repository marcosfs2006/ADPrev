#' Dados dos compromissos do RPPS constantes do DRAA
#' 
#' Este conjunto de dados contém informações sobre os compromissos dos RPPS
#' informados no Demonstrativo do Resultado da Avaliação Atuarial - DRAA.
#' O conjunto de dados contém dados dos anos 2019 e 2020 (os dados originais 
#' possuem informação desde 2015)
#' 
#' @name draa_compromissos
#' @format Data frame com 13 variáveis
#' \describe{
#'   \item{cnpj}{CNPJ do ente}
#'   \item{uf}{sigla da unidade da federação em que o RPPS está localizado}
#'   \item{ente}{nome do ente}
#'   \item{exercicio}{exercício a que se refere o DRAA}
#'   \item{dt_envio}{data de envio do DRAA à SPREV}
#'   \item{sit_draa}{Situação do DRAA na SPREV}
#'   \item{tipo_plano}{tipo do plano - `Previdenciário` ou `Financeiro`}
#'   \item{tipo_massa}{tipo da massa de participantes a que se refere o DRAA - `Civil`, `Militar`}
#'   \item{codigo}{codigo da variável}
#'   \item{descr}{descrição da variável}
#'   \item{categoria}{indicação de que a variável é um `Título` ou `Resultado`}
#'   \item{vlr_geracao_atual}{valor da variável considerando a geração atual}
#'   \item{vlr_geracao_futura}{valor da variável considerando a geração futura}
#' }
"draa_compromissos"
