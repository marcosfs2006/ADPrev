#' Dados do Certificado de Regularidade Previdenciária - CRP
#'
#' Este conjunto de dados contém informações sobre o CRP de todos os entes
#' do Brasil, vinculados ao RGPS e ao RPPS.
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
#' @source \url{https://www.gov.br/previdencia/pt-br/assuntos/previdencia-no-servico-publico/estatisticas-e-informacoes-dos-rpps-1/estatisticas-e-informacoes-dos-rpps}
"crp"