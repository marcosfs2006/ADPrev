#' Extrai dados do regime previdenciário da API do CADPREV
#'
#' Função para a obtenção de dados relativos ao regime previdenciário a que
#' pertence o RPPS utilizando a API do CADPREV cuja documentação pode ser consultada em 
#' \url{https://apicadprev.economia.gov.br/api-docs/}.
#' 
#' Embora a função aceite como parâmetros qualquer um dos que possam ser passados
#' ao ponto de acesso \code{RPPS_REGIME_PREVIDENCIARIO} recomenda-se utilizar os 
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
#'  para a consultas quanto ao regime previdenciário a que pertencem os RPPS.  
#' @return Um \code{data frame} contendo os dados requisitados.
#' @examples
#' \dontrun{ 
#' # Obtém dados do regime previdenciário a que os Entes do RJ estão vinvulados
#' reg_prev_RJ <- get_regime_previdenciario(sg_uf="RJ") 
#' 
#' # Obtém dados do regime previdenciário ao qual o município de Quatis - RJ
#' # está vinculado
#' reg_prev_QuatisRJ <- get_regime_previdenciario(nr_cnpj_entidade = "39560008000148")
#' }
#'
get_regime_previdenciario <- function(...){


  flag <- TRUE
  pagina=0
  consulta <- list(...)
  dados_regime_previdenciario <- data.frame()
  
  while(flag){
    regime_previdenciario <- httr::GET("https://apicadprev.economia.gov.br/RPPS_REGIME_PREVIDENCIARIO?", query=append(consulta, list(offset = pagina)))
    httr::stop_for_status(regime_previdenciario, task="Error to connect to the server! Try again later.")
    regime_previdenciario_txt   <- httr::content(regime_previdenciario, as="text", encoding="UTF-8")
    regime_previdenciario_json  <- jsonlite::fromJSON(regime_previdenciario_txt, flatten = FALSE)
    regime_previdenciario_df    <- as.data.frame(regime_previdenciario_json[["results"]][["data"]])
    dados_regime_previdenciario <- dplyr::bind_rows(dados_regime_previdenciario, regime_previdenciario_df)
    flag <- regime_previdenciario_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }
  
  return(dados_regime_previdenciario)
  
}


  
  
  
