get_crp <- function(...){
  
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
  dados_crp <- data.frame()
  
  while(flag){
    crp <- GET("https://apicadprev.economia.gov.br/RPPS_CRP?", query=append(consulta, list(offset = pagina)))
    stop_for_status(crp, task="Connect to the server! Try again later.")
    crp_txt   <- content(crp, as="text", encoding="UTF-8")
    crp_json  <- fromJSON(crp_txt, flatten = FALSE)
    crp_df    <- as.data.frame(crp_json[["results"]][["data"]])
    dados_crp <- bind_rows(dados_crp, crp_df)
    flag <- crp_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }
  
  return(dados_crp)
}
