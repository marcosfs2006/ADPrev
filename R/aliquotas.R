#' Dados das alíquotas de contribuição dos RPPS
#'
#' Este conjunto de dados contém informações sobre as alíquotas de contribuição
#' praticadas nos RPPS.
#'
#' @name aliquotas
#' @format Data frame com nove variáveis.
#' \describe{
#'   \item{cnpj_ente}{CNPJ do ente}
#'   \item{ente}{nome do ente}
#'   \item{uf}{sigla da unidade da federação do RPPS}
#'   \item{plano_segregacao}{indica o plano: `FINANCEIRO` ou `PREVIDENCIÁRIO`}
#'   \item{sujeito_passivo}{indica o contribuinte da alíquota. `Ativos`, `Aposentados`, `Pensionistas`, `Ente` e `Ente-suplementar`}
#'   \item{aliquota}{percentual da alíquota de contribuição}
#'   \item{inic_vigencia}{data de início de vigência da alíquota}
#'   \item{fim_vigencia}{data de término de vigência da alíquota}
#' }
"aliquotas"
