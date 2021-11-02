#' Extrai dados do DRAA da API do CADPREV
#'
#' Função para a obtenção de dados relativos aos valores dos compromissos 
#' obtidos na avaliação atuarial anual do RPPS e registrados no  
#' Demonstrativo de Resultados da Avaliação Atuarial - DRAA,
#' utilizando a API do CADPREV cuja documentação pode ser consultada em 
#' \url{https://apicadprev.economia.gov.br/api-docs/}.
#' 
#' Embora a função aceite como parâmetros qualquer um dos que possam ser passados
#' ao ponto de acesso \code{DRAA_VALORES_COMPROMISSOS} recomendamos utilizar os 
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
#'  para a consulta aos dados de compromissos do DRAA.  
#' @return Um \code{data frame} contendo os dados requisitados.
#' @examples
#' \dontrun{ 
#' # Obtém dados dos valores dos compromissos dos DRAA  dos RPPS do RJ para todos
#' # os anos disponíveis na base de dados (2015 em diante)
#' draa_RJ <- get_draa_valores_compromissos(sg_uf="RJ") 
#' 
#' # Obtém dados dos valores dos compromissos do DRAA do RPPS de Quatis - RJ do ano de 2019
#' draa_QuatisRJ2019 <- get_draa_valores_compromissos(nr_cnpj_entidade = "39560008000148",
#'                                                    dt_exercicio=2019)
#' }
#'
get_draa_valores_compromissos <- function(...){

  flag <- TRUE
  pagina = 0
  consulta <- list(...)
  dados_draa_valores_compromissos <- data.frame()
  
  while(flag){
    draa_valores_compromissos <- httr::GET("https://apicadprev.economia.gov.br/DRAA_VALORES_COMPROMISSOS?", query=append(consulta, list(offset = pagina)))
    httr::stop_for_status(draa_valores_compromissos, task="connect to the server! Try again later.")
    draa_valores_compromissos_txt  <- httr::content(draa_valores_compromissos, as="text", encoding="UTF-8")
    draa_valores_compromissos_json <- jsonlite::fromJSON(draa_valores_compromissos_txt, flatten = FALSE) 
    draa_valores_compromissos_df   <- as.data.frame(draa_valores_compromissos_json[["results"]][["data"]])
    dados_draa_valores_compromissos <- dplyr::bind_rows(dados_draa_valores_compromissos, draa_valores_compromissos_df)
    flag <- draa_valores_compromissos_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }
  
  return(dados_draa_valores_compromissos)  
}
