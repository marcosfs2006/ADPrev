#' Extrai dados do DIPR na API do CADPREV
#'
#' Função para a obtenção de dados relativos ao  Demonstrativo de Informações 
#' Previdenciárias e Repasses - DIPR utilizando a API do CADPREV cuja documentação
#' pode ser consultada em \url{https://apicadprev.trabalho.gov.br/api-docs/}.
#' 
#' Embora a função aceite como parâmetros qualquer um dos que possam ser passados
#' ao ponto de acesso \code{DIPR} recomendamos utilizar os 
#' parâmetros abaixo elencados e depois realizar os filtros desejados.
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
#' @export
get_dipr <- function(...){
  
  consulta <- list(...) # Repassa parametros a api
  pagina <- 0
  dados_dipr <- data.frame()
  continuar <- TRUE
  
  while(continuar){
    
    # Acessando API:
    dipr <- httr::GET("https://apicadprev.trabalho.gov.br/DIPR", 
                      query = c(consulta, list(offset = pagina)))
    
    # Mensagem se o site estiver fora do ar ou der erro:
    httr::stop_for_status(dipr, task = "Connect to the server! Try again later.")
    
    # Convertendo dados em lista:
    dipr_json <- jsonlite::fromJSON(httr::content(dipr, as = "text", encoding = "UTF-8"))
    
    # Empilhando dados (o padrao e 5000):
    dados_dipr <- dplyr::bind_rows(dados_dipr, dipr_json[["data"]])
    
    # Se alcancar o limite (5000), vai continuar a busca:
    continuar <- dipr_json[["count"]] == dipr_json[["limit"]]
    
    # Avança o offset para a proxima pagina:
    pagina <- pagina + dipr_json[["limit"]]
    
    Sys.sleep(1)
  }
  
  return(dados_dipr)
}

