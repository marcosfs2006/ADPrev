#' Extrai dados das APR da API do CADPREV
#'
#' Função para a obtenção de dados relativos às Autorizações para Aplicações e
#' Resgates - APR a partir da API do CADPREV cuja documentação pode ser
#' consultada em \url{https://apicadprev.trabalho.gov.br/api-docs/}.
#' 
#' Embora a função aceite como parâmetros qualquer um dos que possam ser passados
#' ao ponto de acesso \code{DAIR_APLICACOES_RESGATE} recomendamos utilizar 
#' os parâmetros abaixo elencados e depois realizar os filtros desejados.
#' 
#' 
#' \itemize{
#'   \item \code{nr_cnpj_entidade} caractere indicando o CNPJ do Ente a que pertence o RPPS
#'   \item \code{no_ente} caractere indicando o nome do Ente a que pertence o RPPS
#'   \item \code{sg_uf} caractere indicando a sigla da unidade da federação a que pertence o RPPS
#'   \item \code{dt_ano} inteiro indicando o ano de realização da operação
#'   \item \code{dt_mes} inteiro indicando o mês de realizçaõ da operação
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
#'  para a consulta ao DAIR - Aplicações e Resgate.  
#' @return Um \code{data frame} contendo os dados requisitados.
#' @examples
#' \dontrun{ 
#' # Obtém os dados das APR emitidas pelos RPPS do RJ para o ano de 2021
#' apr_RJ2021 <- get_dair_aplicacoes_resgate(sg_uf="RJ", dt_ano=2021) 
#' 
#' # Obtém os dados das APR emitidas pelos RPPS do RJ em julho de 2020
#' apr_RJ2020JUL <- get_dair_aplicacoes_resgate(sg_uf="RJ", dt_ano=2021, dt_mes=7)
#' 
#' # Obtem os dados das APR emitidas pelo RPPS de Quatis - RJ em 2021
#' apr_QuatisRJ2021 <- get_dair_aplicacoes_resgate(nr_cnpj_entidade = "39560008000148", dt_ano=2021)
#' }
#' @export
get_dair_aplicacoes_resgate <- function(...){
  
  consulta <- list(...) # Repassa parametros a api
  pagina <- 0
  dados_dair_aplicacoes_resgate <- data.frame()
  continuar <- TRUE
  
  while(continuar){
    
    # Acessando API:
    dair_aplicacoes_resgate <- httr::GET("https://apicadprev.trabalho.gov.br/DAIR_APLICACOES_RESGATE", 
                                         query = c(consulta, list(offset = pagina)))
    
    # Mensagem se o site estiver fora do ar ou der erro:
    httr::stop_for_status(dair_aplicacoes_resgate, task = "Connect to the server! Try again later.")
    
    # Convertendo dados em lista:
    dair_aplicacoes_resgate_json <- jsonlite::fromJSON(httr::content(dair_aplicacoes_resgate, as = "text", encoding = "UTF-8"))
    
    # Empilhando dados (o padrao e 5000):
    dados_dair_aplicacoes_resgate <- dplyr::bind_rows(dados_dair_aplicacoes_resgate, dair_aplicacoes_resgate_json[["data"]])
    
    # Se alcancar o limite (5000), vai continuar a busca:
    continuar <- dair_aplicacoes_resgate_json[["count"]] == dair_aplicacoes_resgate_json[["limit"]]
    
    # Avança o offset para a proxima pagina:
    pagina <- pagina + dair_aplicacoes_resgate_json[["limit"]]
    
    Sys.sleep(1)
  }
  
  return(dados_dair_aplicacoes_resgate)
}
