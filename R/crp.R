#' Certificado de Regularidade Previdenciária - CRP
#'
#' Este conjunto de dados contém informações sobre o Certificado de Regularidade
#' previdenciária - CRP de todos os entes do Brasil, vinculados ao RGPS e ao RPPS.
#'
#' @name crp
#' @format Data frame contendo oito variáveis.
#' \describe{
#'   \item{uf}{sigla da unidade da federação na qual o RPPS está localizado}
#'   \item{ente}{nome do ente}
#'   \item{num_crp}{número do CRP}
#'   \item{dt_emissao}{data de emissão do CRP}
#'   \item{dt_validade}{data de validade do CRP (o CRP tem validade de 6 meses
#'   a partir de sua emissão)}
#'   \item{judicial}{indica se o CRP foi obtido por via judicial - `SIM`, `NÃO`}
#'   \item{tipo_regime}{tipo de regime previdenciário ao qual o ente está
#'   vinculado - `RGPS` ou `RPPS`}
#'   \item{situacao}{situação do CRP - `VÁLIDO` ou `VENCIDO`}
#' }
#' @details 
#' Os dados referem-se à atualização de DEZ/2020 disponibilizada em 20.01.2021.
#' 
#' Data de extração: 20.01.2021
#' 
#' A base de dados original relaciona todos os entes, tanto os vinculados ao RGPS 
#' quanto os vinculados ao RPPS. Esta base de dados contempla apenas os CRP dos
#' entes vinculados ao RPPS.
#' 
#' Quando a data de validade do CRP coincide com a data de extração dos dados, a
#' situação do CRP é `VENCIDO`.
#' 
#' Exemplos de uso deste conjunto de dados podem ser vistos no
#' tutorial [Análise de Dados Previdenciários - ADPrev](https://marcosfs2006.github.io/ADPrevBook/) 
#'   
#' @source \url{https://www.gov.br/previdencia/pt-br/assuntos/previdencia-no-servico-publico/estatisticas-e-informacoes-dos-rpps-1/estatisticas-e-informacoes-dos-rpps}
#' @md
"crp"
