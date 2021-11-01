#' Extrai dados do DIPR na API do CADPREV
#'
#' Função para a obtenção de dados relativos ao  Demonstrativo de Informações 
#' Previdenciárias e Repasses - DIPR utilizando a API do CADPREV cuja documentação
#' pode ser consultada em \url{https://apicadprev.economia.gov.br/api-docs/}.
#' 
#' Embora a função aceite como parâmetros qualquer um dos que possam ser passados
#' ao ponto de acesso \code{DIPR} recomendamos utilizar os 
#' parâmtros abaixo elencados e depois realizar os filtros desejados.
#' 
#' 
#' \itemize{
#'   \item \code{nr_cnpj_entidade} caractere indicando o CNPJ do Ente a que pertence o RPPS
#'   \item \code{no_ente} caractere indicando o nome do Ente a que pertence o RPPS
#'   \item \code{sg_uf} caractere indicando a sigla da unidade da federação a que pertence o RPPS
#'   \item \code{dt_ano} inteiro indicando o ano de competência do DIPR 
#'   \item \code{dt_mes} inteiro indicadno o mês de competência do DIPR
#' }
#' 
#' A sigla da UF deve ser fornecida em letras maiúsculas.
#' 
#' O nome do Ente deve ser fornecido exatamente como consta da base de dados.
#' 
#' Para evitar erros devidos a incorreções no nome do Ente recomenda-se utilizar
#' o CNPJ do Ente para consultas relativas a um RPPS específico.
#'   
#' @param ... Qualquer um dos parâmetros de consulta disponibilizados pela API
#'  para a consulta aos dados do DIPR.  
#' @return Um \code{data frame} contendo os dados requisitados.
#' @examples
#' \dontrun{ 
#' # Obtém dados dos DIPR dos RPPS do RJ no mês de janeiro de 2020
#' dipr_RJ <- get_dipr(sg_uf="RJ", dt_mes=1, dt_ano=2020) 
#' 
#' # Obtém dados dos DIPR do RPPS de Quatis - RJ em todos os meses de 2021
#' dipr_QuatisRJ2021 <- get_dipr(nr_cnpj_entidade = "39560008000148", dt_ano=2021)
#' }
#'
get_dipr <- function(...){ 

  flag <- TRUE
  pagina = 0
  consulta <- list(...)
  dados_dipr <- data.frame()

  while(flag){
    dipr <- httr::GET("https://apicadprev.economia.gov.br/DIPR?", query=append(consulta, list(offset = pagina)))
    httr::stop_for_status(dipr, task="Error to connect to the server! Try again later.")
    dipr_txt   <- httr::content(dipr, as="text", encoding="UTF-8")
    dipr_json  <- jsonlite::fromJSON(dipr_txt, flatten = FALSE)
    dipr_df    <- as.data.frame(dipr_json[["results"]][["data"]])
    dados_dipr <- dplyr::bind_rows(dados_dipr, dipr_df)
    flag <- dipr_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }
  
  return(dados_dipr)
  
}

