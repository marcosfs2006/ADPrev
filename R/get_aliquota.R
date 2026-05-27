#' Extrai dados de alíquotas da API do CADPREV
#'
#' Função para a obtenção de dados relativos às alíquotas praticadas pelos RPPS,
#' utilizando a API do CADPREV cuja documentação pode ser consultada em 
#' \url{https://apicadprev.trabalho.gov.br/api-docs/}.
#' 
#' Embora a função aceite como parâmetros qualquer um dos que possam ser passados
#' ao ponto de acesso \code{RPPS_ALIQUOTA} recomendamos utilizar os 
#' parâmetros abaixo elencados e depois realizar os filtros desejados.
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
#'  para a consulta às alíquotas praticadas pelo(s) RPPS.  
#' @return Um \code{data frame} contendo os dados requisitados.
#' @examples
#' \dontrun{ 
#' # Obtém dados das alíquotas praticadas pelos RPPS do RJ
#' aliquotas_RJ <- get_aliquota(sg_uf="RJ") 
#' 
#' # Obtém dados das alíquotas praticadas pelo RPPS de Quatis - RJ
#' aliquotas_QuatisRJ <- get_aliquota(nr_cnpj_entidade = "39560008000148")
#' }
#' @export
get_aliquota <- function(...){
  
  consulta <- list(...) # Repassa parametros a api
  pagina <- 0
  dados_aliquota <- data.frame()
  continuar <- TRUE
  
  while(continuar){
    
    # Acessando API:
    aliquota <- httr::GET("https://apicadprev.trabalho.gov.br/RPPS_ALIQUOTA", 
                               query = c(consulta, list(offset = pagina)))
    
    # Mensagem se o site estiver fora do ar ou der erro:
    httr::stop_for_status(aliquota, task = "Connect to the server! Try again later.")
    
    # Convertendo dados em lista:
    aliquota_json <- jsonlite::fromJSON(httr::content(aliquota, as = "text", encoding = "UTF-8"))
    
    # Empilhando dados (o padrao e 5000):
    dados_aliquota <- dplyr::bind_rows(dados_aliquota, aliquota_json[["data"]])
    
    # Se alcancar o limite (5000), vai continuar a busca:
    continuar <- aliquota_json[["count"]] == aliquota_json[["limit"]]
    
    # Avança o offset para a proxima pagina:
    pagina <- pagina + aliquota_json[["limit"]]
    
    Sys.sleep(1)
  }
  
  return(dados_aliquota)
}




