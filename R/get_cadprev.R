#' Extrai dados da API do CADPREV repassando o ponto de acesso
#'
#' Função para a obtenção de todos os dados da API do CADPREV cuja documentação
#' pode ser consultada em \url{https://apicadprev.trabalho.gov.br/api-docs/}.
#' 
#' Embora a função aceite como parâmetros qualquer um dos que possam ser passados,
#' os parâmentros mudam de acordo com o ponto de acesso. Verifique a documentação
#' para associá-los da forma correta. Utilize poucos parâmetros (como Ano, CNPJ, Mês, Estado, Nome) 
#' e depois realize os filtros desejados.
#' 
#' A sigla da UF deve ser fornecida em letras maiúsculas.
#' 
#' O nome do Ente deve ser fornecido exatamente como consta da base de dados.
#' 
#' Para evitar erros devidos a incorreções no nome do Ente recomenda-se utilizar
#' o CNPJ do Ente para consultas relativas a um RPPS específico.
#'   
#' @param ... Qualquer um dos parâmetros de consulta disponibilizados pela API
#'  para a consulta aos dados.  
#' @return Um \code{data frame} contendo os dados requisitados.
#' @examples
#' \dontrun{ 
#' # Obtém dados do Fluxo Atuarial do DRAA feito pelo RPPS de Quatis - RJ
#' draa_fluxo_atuarial_QuatisRJ <- get_cadprev(endpoint = "DRAA_FLUXO_ATUARIAL", nr_cnpj_entidade = "39560008000148")
#' 
#' # Obtém dados de Estatísticas do DRAA feito pelo RPPS de Quatis - RJ
#' draa_estatistica_QuatisRJ <- get_cadprev(endpoint = "DRAA_ESTATISTICA", nr_cnpj_entidade = "39560008000148")
#' 
#' # Obtem os dados da carteira de investimento do RPPS de Quatis - RJ em todos os meses de 2021
#' dair_QuatisRJ <- get_cadprev(endpoint = "DAIR_CARTEIRA", nr_cnpj_entidade = "39560008000148", dt_ano = 2021)
#' 
#' # Obtém os dados do CRP do RPPS de Quatis - RJ
#' crp_QuatisRJ <- get_cadprev(endpoint = "RPPS_CRP", nr_cnpj_entidade = "39560008000148")
#' 
#' # Obtém dados dos DIPR do RPPS de Quatis - RJ em todos os meses de 2021
#' dipr_QuatisRJ2021 <- get_cadprev(endpoint = "DIPR", nr_cnpj_entidade = "39560008000148", dt_ano = 2021)
#' }
#' @export
get_cadprev <- function(..., endpoint){
  
  consulta <- list(...) # Repassa parametros a api
  pagina <- 0
  dados_cadprev <- data.frame()
  continuar <- TRUE
  
  while(continuar){
    
    # Acessando API:
    cadprev <- httr::GET(paste0("https://apicadprev.trabalho.gov.br/", endpoint), 
                      query = c(consulta, list(offset = pagina)))
    
    # Mensagem se o site estiver fora do ar ou der erro:
    httr::stop_for_status(cadprev, task = "Connect to the server! Try again later.")
    
    # Convertendo dados em lista:
    cadprev_json <- jsonlite::fromJSON(httr::content(cadprev, as = "text", encoding = "UTF-8"))
    
    # Empilhando dados (o padrao e 5000):
    dados_cadprev <- dplyr::bind_rows(dados_cadprev, cadprev_json[["data"]])
    
    # Se alcancar o limite (5000), vai continuar a busca:
    continuar <- cadprev_json[["count"]] == cadprev_json[["limit"]]
    
    # Avança o offset para a proxima pagina:
    pagina <- pagina + cadprev_json[["limit"]]
    
    Sys.sleep(1)
  }
  
  return(dados_cadprev)
}
