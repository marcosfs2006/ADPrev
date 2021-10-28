get_dipr <- function(...){ 
  
  
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
  dados_dipr <- data.frame()
  

  while(flag){
    dipr <- GET("https://apicadprev.economia.gov.br/DIPR?", query=append(consulta, list(offset = pagina)))
    stop_for_status(dipr, task="Error to connect to the server! Try again later.")
    dipr_txt   <- content(dipr, as="text", encoding="UTF-8")
    dipr_json  <- fromJSON(dipr_txt, flatten = FALSE)
    dipr_df    <- as.data.frame(dipr_json[["results"]][["data"]])
    dados_dipr <- bind_rows(dados_dipr, dipr_df)
    flag <- dipr_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }
  
  return(dados_dipr)
  
}

