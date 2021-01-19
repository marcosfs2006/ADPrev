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
"fundos_vedados"