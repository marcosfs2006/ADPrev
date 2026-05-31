#' Extrai dados da Contribuição do DRAA da API do CADPREV
#'
#' Função para a obtenção de dados relativos à Contribuição do 
#' Demonstrativo de Resultados da Avaliação Atuarial - DRAA à SPREV,
#' utilizando a API do CADPREV cuja documentação pode ser consultada em 
#' \url{https://apicadprev.trabalho.gov.br/api-docs/}.
#' 
#' Embora a função aceite como parâmetros qualquer um dos que possam ser passados
#' ao ponto de acesso \code{DRAA_CONTRIBUICAO} recomendamos utilizar os 
#' parâmetros abaixo elencados e depois realizar os filtros desejados.
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
#'  para a consulta ao contribuicao do DRAA.  
#' @return Um \code{data frame} contendo os dados requisitados.
#' @examples
#' \dontrun{ 
#' # Obtém dados da Contribuição do DRAA feito pelos RPPS do RJ
#' draa_contribuicao_RJ <- get_draa_contribuicao(sg_uf="RJ") 
#' 
#' # Obtém dados da Contribuição do DRAA feito pelo RPPS de Quatis - RJ
#' draa_contribuicao_QuatisRJ <- get_draa_contribuicao(nr_cnpj_entidade = "39560008000148")
#' }
#' @export
get_draa_contribuicao <- function(...){
  
  consulta <- list(...) # Repassa parametros a api
  pagina <- 0
  dados_draa_contribuicao <- data.frame()
  continuar <- TRUE
  
  while(continuar){
    
    # Acessando API:
    draa_contribuicao <- httr::GET("https://apicadprev.trabalho.gov.br/DRAA_CONTRIBUICAO", 
                                      query = c(consulta, list(offset = pagina)))
    
    # Mensagem se o site estiver fora do ar ou der erro:
    httr::stop_for_status(draa_contribuicao, task = "Connect to the server! Try again later.")
    
    # Convertendo dados em lista:
    draa_contribuicao_json <- jsonlite::fromJSON(httr::content(draa_contribuicao, as = "text", encoding = "UTF-8"))
    
    # Empilhando dados (o padrao e 5000):
    dados_draa_contribuicao <- dplyr::bind_rows(dados_draa_contribuicao, draa_contribuicao_json[["data"]])
    
    # Se alcancar o limite (5000), vai continuar a busca:
    continuar <- draa_contribuicao_json[["count"]] == draa_contribuicao_json[["limit"]]
    
    # Avança o offset para a proxima pagina:
    pagina <- pagina + draa_contribuicao_json[["limit"]]
    
    Sys.sleep(1)
  }
  
  return(dados_draa_contribuicao)
}
