# Função para extração dos dados das APR
#

get_dair_aplicacoes_resgate <- function(...){ 
  
  # Opções de consulta disponíveis para a função
  #---------------------------------------------
  # nr_cnpj_entidade
  # no_ente
  # sg_uf
  # dt_ano
  # dt_mes

  require(dplyr)
  require(httr)
  require(jsonlite)
  require(tidyr)
  
  
  flag <- TRUE
  pagina = 0
  consulta <- list(...)
  dados_dair_aplicacoes_resgate <- data.frame()

  while(flag){
    dair_aplicacoes_resgate <- GET("https://apicadprev.economia.gov.br/DAIR_APLICACOES_RESGATE?", query=append(consulta, list(offset = pagina))) 
    stop_for_status(dair_aplicacoes_resgate, task="Error to connect to the server! Try again later.")
    dair_aplicacoes_resgate_txt   <- content(dair_aplicacoes_resgate, as="text", encoding="UTF-8")
    dair_aplicacoes_resgate_json  <- fromJSON(dair_aplicacoes_resgate_txt, flatten = FALSE)
    dair_aplicacoes_resgate_df    <- as.data.frame(dair_aplicacoes_resgate_json[["results"]][["data"]])
    dados_dair_aplicacoes_resgate <- bind_rows(dados_dair_aplicacoes_resgate, dair_aplicacoes_resgate_df)
    flag <- dair_aplicacoes_resgate_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }
  
return(dados_dair_aplicacoes_resgate)
  
}
