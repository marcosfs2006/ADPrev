#' Extrai dados de encaminhamento do DRAA da API do CADPREV
#'
#' Função para a obtenção de dados relativos ao encaminhamento do 
#' Demonstrativo de Resultados da Avaliação Atuarial - DRAA à SPREV,
#' utilizando a API do CADPREV cuja documentação pode ser consultada em 
#' \url{https://apicadprev.economia.gov.br/api-docs/}.
#' 
#' Embora a função aceite como parâmetros qualquer um dos que possam ser passados
#' ao ponto de acesso \code{DRAA_ENCAMINHAMENTO} recomendamos utilizar os 
#' parâmtros abaixo elencados e depois realizar os filtros desejados.
#' 
#' 
#' \itemize{
#'   \item \code{nr_cnpj_entidade} caractere indicando o CNPJ do Ente a que pertence o RPPS
#'   \item \code{no_ente} caractere indicando o nome do Ente a que pertence o RPPS
#'   \item \code{sg_uf} caractere indicando a sigla da unidade da federação a que pertence o RPPS
#'   \item \code{dt_exercicio} inteiro indicando o ano do DRAA
#' }
#' 
#' A sigla da UF deve ser fornecida em letras maiúsculas.
#' 
#' O nome do Ente deve ser fornecido exatamente como consta da base de dados.
#' 
#' Para evitar erros devidos a incorreções no nome do Ente recomenda-se utilizar
#' o CNPJ do Ente para consultas relativas a um RPPS específico.
#' 
#' O ano do DRAA (\code{dt_exercicio}) é o ano posterior ao ano da data base
#' da avaliação atuarial.
#' 
#' Se a avaliação atuarial tem data base em 31/12/2019 o ano do DRAA é 2020. 
#'   
#' @param ... Qualquer um dos parâmetros de consulta disponibilizados pela API
#'  para a consulta ao encaminhamento do DRAA.  
#' @return Um \code{data frame} contendo os dados requisitados.
#' @examples
#' \dontrun{ 
#' # Obtém dados de encaminhamento do DRAA feito pelos RPPS do RJ
#' draa_encaminhamnto_RJ <- get_draa_encaminhamento(sg_uf="RJ") 
#' 
#' # Obtém dados de encaminhamento do DRAA feito pelo RPPS de Quatis - RJ
#' draa_encaminhamento_QuatisRJ <- get_draa_encaminhamento(nr_cnpj_entidade = "39560008000148")
#' }
#'
get_draa_encaminhamento <- function(...){

  flag <- TRUE
  pagina = 0
  consulta <- list(...)
  dados_draa_encaminhamento <- data.frame()
  
  while(flag){
    draa_encaminhamento <- httr::GET("https://apicadprev.economia.gov.br/DRAA_ENCAMINHAMENTO?", query=append(consulta, list(offset = pagina)))
    httr::stop_for_status(draa_encaminhamento, task="connect to the server! Try again later.")
    draa_encaminhamento_txt  <- httr::content(draa_encaminhamento, as="text", encoding="UTF-8")
    draa_encaminhamento_json <- jsonlite::fromJSON(draa_encaminhamento_txt, flatten = FALSE) 
    draa_encaminhamento_df   <- as.data.frame(draa_encaminhamento_json[["results"]][["data"]])
    dados_draa_encaminhamento <- dplyr::bind_rows(dados_draa_encaminhamento, draa_encaminhamento_df)
    flag <- draa_encaminhamento_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }

  return(dados_draa_encaminhamento)  
}