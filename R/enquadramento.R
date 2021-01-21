#' Enquadramento dos Fundos de Investimentos
#'
#' Conjunto de dados contendo o enquadramento dos fundos de investimento
#' realizado pela Secretaria de Previdência Social - SPREV, conforme
#' Resolução n. 3922/10 do Conselho Monetário Nacional.
#'
#' @name enquadramento
#' @format Data frame contendo 651 observações e 5 variáveis na versão do dia 12.03.2020
#' \describe{
#'   \item{nm_fundo}{nome do fundo de investimento}
#'   \item{cnpj}{CNPJ do fundo de investimento}
#'   \item{cnpj_admin}{CNPJ do administrador do fundo de investimentos}
#'   \item{cnpj_gestor}{CNPJ do gestor do fundo de investimentos}
#'   \item{enquad_sprev}{enquadramento do fundo de investimento segundo a SPREV}
#' }
#' @details 
#' Os dados referem-se à `Planilha de Enquadramento dos Fundos CGACI-RPPS`
#' disponibilizada pela SPREV com data de 12.03.2020. 
#' 
#' Exemplos de uso deste conjunto de dados podem ser vistos no
#' tutorial [Análise de Dados Previdenciários - ADPrev](https://marcosfs2006.github.io/ADPrevBook/) 
#'   
#' @source \url{https://www.gov.br/previdencia/pt-br/assuntos/previdencia-no-servico-publico/menu-investimentos/investimento-estatisticas-e-informacoes}
#' @md

"enquadramento"
