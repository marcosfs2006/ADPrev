
get_draa_encaminhamento <- function(...){
  
  # Opções de consulta disponíveis para a função
  #---------------------------------------------
  # nr_cnpj_entidade
  # no_ente
  # sg_uf
  # dt_exercicio
  
  require(dplyr)
  require(httr)
  require(jsonlite)
  require(tidyr)
  
  flag <- TRUE
  pagina = 0
  consulta <- list(...)
  dados_draa_encaminhamento <- data.frame()
  
  while(flag){
    draa_encaminhamento <- GET("https://apicadprev.economia.gov.br/DRAA_ENCAMINHAMENTO?", query=append(consulta, list(offset = pagina)))
    stop_for_status(draa_encaminhamento, task="connect to the server! Try again later.")
    draa_encaminhamento_txt  <- content(draa_encaminhamento, as="text", encoding="UTF-8")
    draa_encaminhamento_json <- fromJSON(draa_encaminhamento_txt, flatten = FALSE) 
    draa_encaminhamento_df   <- as.data.frame(draa_encaminhamento_json[["results"]][["data"]])
    dados_draa_encaminhamento <- bind_rows(dados_draa_encaminhamento, draa_encaminhamento_df)
    flag <- draa_encaminhamento_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }

  return(dados_draa_encaminhamento)  
}