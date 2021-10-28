
get_aliquota <- function(...){

  # Opções de consulta disponíveis para a função
  #---------------------------------------------
  # nr_cnpj_entidade
  # no_ente
  # sg_uf
  
    
  require(dplyr)
  require(httr)
  require(jsonlite)
  require(tidyr)

  flag <- TRUE
  pagina = 0
  consulta <- list(...)
  dados_aliquota <- data.frame()
  
  while(flag){
    aliquota <- GET("https://apicadprev.economia.gov.br/RPPS_ALIQUOTA?", query=append(consulta, list(offset = pagina)))
    stop_for_status(aliquota, task="Cannot connect to the server! Try again later.")
    aliquota_txt  <- content(aliquota, as="text", encoding="UTF-8")
    aliquota_json <- fromJSON(aliquota_txt, flatten = FALSE) 
    aliquota_df   <- as.data.frame(aliquota_json[["results"]][["data"]])
    dados_aliquota <- bind_rows(dados_aliquota, aliquota_df)
    flag <- aliquota_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }
  
  return(dados_aliquota)
  
}




