get_regime_previdenciario <- function(...){
  
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
  pagina=0
  consulta <- list(...)
  dados_regime_previdenciario <- data.frame()
  
  while(flag){
    regime_previdenciario <- GET("https://apicadprev.economia.gov.br/RPPS_REGIME_PREVIDENCIARIO?", query=append(consulta, list(offset = pagina)))
    stop_for_status(regime_previdenciario, task="Error to connect to the server! Try again later.")
    regime_previdenciario_txt   <- content(regime_previdenciario, as="text", encoding="UTF-8")
    regime_previdenciario_json  <- fromJSON(regime_previdenciario_txt, flatten = FALSE)
    regime_previdenciario_df    <- as.data.frame(regime_previdenciario_json[["results"]][["data"]])
    dados_regime_previdenciario <- bind_rows(dados_regime_previdenciario, regime_previdenciario_df)
    flag <- regime_previdenciario_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }
  
  return(dados_regime_previdenciario)
  
}


  
  
  
