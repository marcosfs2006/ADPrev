get_dair_carteira <- function(...){
  
  # Opções de consulta disponíveis para a função
  #---------------------------------------------
  # nr_cnpj_entidade
  # no_ente
  # sg_uf
  # dt_ano
  # dt_mes_bimestre
  
  
  
  require(dplyr)
  require(httr)
  require(jsonlite)
  require(tidyr)
  
  flag <- TRUE
  pagina = 0
  consulta <- list(...)
  dados_dair_carteira  <- data.frame()

  while(flag){
    dair_carteira <- GET("https://apicadprev.economia.gov.br/DAIR_CARTEIRA?", query=append(consulta, list(offset = pagina)))
    stop_for_status(dair_carteira , task="Connect to the server! Try again later.")
    dair_carteira_txt   <- content(dair_carteira, as="text", encoding="UTF-8")
    dair_carteira_json  <- fromJSON(dair_carteira_txt, flatten = FALSE)
    dair_carteira_df    <- as.data.frame(dair_carteira_json[["results"]][["data"]])
    dados_dair_carteira <- bind_rows(dados_dair_carteira, dair_carteira_df)
    flag <- dair_carteira_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }
  
  return(dados_dair_carteira)
}
