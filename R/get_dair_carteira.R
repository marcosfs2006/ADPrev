#' Extrai dados da carteira de investimentos da API do CADPREV
#'
#' Função para a obtenção de dados relativos às carteiras de investimentos dos RPPS
#' a partir da API do CADPREV cuja documentação pode ser consultada em
#' \url{https://apicadprev.economia.gov.br/api-docs/}.
#' 
#' Embora a função aceite como parâmetros qualquer um dos que possam ser passados
#' ao ponto de acesso \code{DAIR_CARTEIRA} recomendamos utilizar 
#' os parâmtros abaixo elencados e depois realizar os filtros desejados.
#' 
#' 
#' \itemize{
#'   \item \code{nr_cnpj_entidade} caractere indicando o CNPJ do Ente a que
#'    pertence o RPPS
#'   \item \code{no_ente} caractere indicando o nome do Ente a que pertence o RPPS
#'   \item \code{sg_uf} caractere indicando a sigla da unidade da federação a
#'    que pertence o RPPS
#'   \item \code{dt_ano} inteiro indicando o ano da posição da carteira
#'   \item \code{dt_mes_bimestre} inteiro indicando o mês (ou bimestre)
#'    da posição da carteira
#' }
#' 
#' A sigla da UF deve ser fornecida em letras maiúsculas.
#' 
#' O nome do Ente deve ser fornecido exatamente como consta da base de dados.
#' 
#' Para evitar erros devidos a incorreções no nome do Ente recomenda-se utilizar
#' o CNPJ do Ente para consultas relativas a um RPPS específico.
#' 
#' Até 20216 a posição das carteiras de investimento dos RPPS era apresentada
#' ao término de cada bimestre. A partir de 2017 a posição da carteira passou
#' a ser disponibilizada mensalmente, isto é, ao término de cada mês. 
#'   
#' @param ... Qualquer um dos parâmetros de consulta disponibilizados pela API
#'  para a consulta ao DAIR - Carteira.  
#' @return Um \code{data frame} contendo os dados requisitados.
#' @examples
#' \dontrun{ 
#' # Obtém os dados da carteira de investimento dos RPPS do RJ para
#' # todos os mesess do ano de 2021
#' 
#' dair_RJ2021 <- get_dair_carteira(sg_uf="RJ", dt_ano=2021) 
#' 
#' # Obtém os dados da carteira de investimento dos RPPS do RJ no mês de julho de 2020
#' dair_RJ2020JUL <- get_dair_carteira(sg_uf="RJ", dt_ano=2021, dt_mes_bimestre=7)
#' 
#' # Obtem os dados da carteira de investimento do RPPS de Quatis - RJ em
#' # todos os meses de 2021
#' dair_QuatisRJ <- get_crp(nr_cnpj_entidade = "39560008000148", dt_ano=2021)
#' }
get_dair_carteira <- function(...){
  
  flag <- TRUE
  pagina = 0
  consulta <- list(...)
  dados_dair_carteira  <- data.frame()

  while(flag){
    dair_carteira <- httr::GET("https://apicadprev.economia.gov.br/DAIR_CARTEIRA?", query=append(consulta, list(offset = pagina)))
    httr::stop_for_status(dair_carteira , task="Connect to the server! Try again later.")
    dair_carteira_txt   <- httr::content(dair_carteira, as="text", encoding="UTF-8")
    dair_carteira_json  <- jsonlite::fromJSON(dair_carteira_txt, flatten = FALSE)
    dair_carteira_df    <- as.data.frame(dair_carteira_json[["results"]][["data"]])
    dados_dair_carteira <- dplyr::bind_rows(dados_dair_carteira, dair_carteira_df)
    flag <- dair_carteira_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }
  
  return(dados_dair_carteira)
}
