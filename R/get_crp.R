#' Extrai dados do CRP da API do CADPREV
#'
#' Função para a obtenção de dados relativos ao Certificado de Regularidade
#' Previdenciária - CRP a partir da API do CADPREV cuja documentação pode ser
#' consultada em \url{https://apicadprev.economia.gov.br/api-docs/}.
#' 
#' Embora a função aceite como parâmetros qualquer um dos que possam ser passados
#' ao ponto de acesso \code{RPPS_CRP} recomendamos utilizar os 
#' parâmtros abaixo elencados e depois realizar os filtros desejados.
#' 
#' 
#' \itemize{
#'   \item \code{nr_cnpj_entidade} caractere indicando o CNPJ do Ente a que pertence o RPPS
#'   \item \code{no_ente} caractere indicando o nome do Ente a que pertence o RPPS
#'   \item \code{sg_uf} caractere indicando a sigla da unidade da federação a que pertence o RPPS
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
#'  para a consulta ao CRP.  
#' @return Um \code{data frame} contendo os dados requisitados.
#' @examples
#' \dontrun{ 
#' # Obtém os dados do CRP dos RPPS do RJ
#' crp_RJ <- get_crp(sg_uf="RJ") 
#' 
#' # Obtém os dados do CRP do RPPS de Quatis - RJ
#' crp_QuatisRJ <- get_crp(nr_cnpj_entidade = "39560008000148")
#' }
get_crp <- function(...){
  
  flag <- TRUE
  pagina = 0
  consulta <- list(...)
  dados_crp <- data.frame()
  
  while(flag){
    crp <- httr::GET("https://apicadprev.economia.gov.br/RPPS_CRP?", query=append(consulta, list(offset = pagina)))
    httr::stop_for_status(crp, task="Connect to the server! Try again later.")
    crp_txt   <- httr::content(crp, as="text", encoding="UTF-8")
    crp_json  <- jsonlite::fromJSON(crp_txt, flatten = FALSE)
    crp_df    <- as.data.frame(crp_json[["results"]][["data"]])
    dados_crp <- dplyr::bind_rows(dados_crp, crp_df)
    flag <- crp_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }
  
  return(dados_crp)
}
