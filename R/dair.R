#' Carteira de Investimentos e Demais Ativos do RPPS
#' 
#' Este conjunto de dados contém informações sobre os ativos garantidores do RPPS
#' informados no Demonstrativo das Aplicações e Investimento dos Rercursos - DAIR
#' 
#' @name dair
#' @format Data frame contendo 15 variáveis
#' \describe{
#'   \item{cnpj}{CNPJ do ente}
#'   \item{uf}{sigla da unidade da federação}
#'   \item{ente}{nome do ente intituidor do RPPS}
#'   \item{competencia}{mês e ano de referência dos dados}
#'   \item{segmento}{segmento ao qual pertence o ativo. dentro de um segmento é possível ter diversos tipos de ativos}
#'   \item{tipo_ativo}{especificação do ativo no segmento}
#'   \item{limite_resol_cmn}{percentual máximo dos recursos do RPPS que pode ser investido no ativo conforme Resolução CMN 3922/10}
#'   \item{ident_ativo}{identificação do ativo}
#'   \item{nm_ativo}{nome do ativo}
#'   \item{qtd_quotas}{quantidade de cotas do ativo que o RPPS possui}
#'   \item{vlr_atual_ativo}{valor da unidade de ativo que o RPPS possui}
#'   \item{vlr_total_atual}{valor total do ativo que o RPPS possui}
#'   \item{perc_recursos_rpps}{percentual dos recursos do RPPS aplicado no ativo}
#'   \item{pl_fundo}{patrimônio líquido do fundo de investimento}
#'   \item{perc_pl_fundo}{percentual do patrimônio líquido do fundo de investimentos que o investimento do RPPS representa}
#'}
#' @details 
#' Os dados referem-se à atualização de SET-DEZ/2020 disponibilizada em 14.01.2021 mas
#' contém apenas dados de 2020.
#' 
#' Data de extração: 13.01.2021
#' 
#' Exemplos de uso deste conjunto de dados podem ser vistos no
#' tutorial [Análise de Dados Previdenciários - ADPrev](https://marcosfs2006.github.io/ADPrevBook/) 
#'   
#' @source \url{https://www.gov.br/previdencia/pt-br/assuntos/previdencia-no-servico-publico/estatisticas-e-informacoes-dos-rpps-1/estatisticas-e-informacoes-dos-rpps}
#' @md
"dair" 