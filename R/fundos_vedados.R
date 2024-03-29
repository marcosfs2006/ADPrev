#' Relação dos Fundos de Investimentos Vedados
#'
#' Conjunto de dados contendo a relação dos fundos de investimentos nos quais os
#' RPPS estão vedados de fazer investimentos.
#'
#' @name fundos_vedados
#' @format Data frame contendo 138 observações e 12 variáveis na versão de 21.12.2018 da relação
#' \describe{
#'   \item{cnpj}{CNPJ do fundo de investimento}
#'   \item{nm_fundo}{nome do fundo de investimento}
#'   \item{classe}{categoria do fundo de investimento}
#'   \item{sub_classe}{tipo do fundo de investimento}
#'   \item{tx_adm}{percentual da taxa de administração do fundo de investimento}
#'   \item{administrador}{nome do administrador do fundo de investimento}
#'   \item{gestor}{nome do gestor do fundo de investimento}
#'   \item{carencia}{prazo para que seja possível solicitar o resgate de cotas}
#'   \item{conv_cotas}{quantidade de dias até que as cotas resgatadas sejam convertidas em numerário}
#'   \item{disp_resgate}{quantidade de dias até que os recursos relativos às cotas resgatadas estejam disponíveis}
#'   \item{tx_saida}{percentual cobrado do investidor sobre o valor resgatado caso o resgate ocorra antes do prazo acordado}
#'   \item{motivo}{motivo do fundo de investimento ser vedado ao RPPS}
#' }
#' @details 
#' Os dados referem-se à listagem de fundos de investimentos vedados aos RPPS
#' disponibilizada pela SPREV com data de 21.12.2018. Refere-se aos fundos de
#' investimento que na data em referência possuiam aplicações dos RPPS.
#' 
#' É possível a existência de outros fundos de investimentos vedados que não 
#' constem do conjunto de dados.
#' 
#' Exemplos de uso deste conjunto de dados podem ser vistos no
#' tutorial [Análise de Dados Previdenciários - ADPrev](https://marcosfs2006.github.io/ADPrevBook/) 
#'   
#' @source \url{https://www.gov.br/previdencia/pt-br/assuntos/previdencia-no-servico-publico/menu-investimentos/investimento-estatisticas-e-informacoes}
#' @md
"fundos_vedados"
