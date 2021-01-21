#' Alíquotas de Contribuição
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
"aliquotas"
