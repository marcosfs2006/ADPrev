
get_draa_valores_compromissos <- function(...){
  
  # Opções de consulta disponíveis para a função
  #---------------------------------------------
  # nr_cnpj_entidade
  # no_ente
  # sg_uf
  # dt_exercicio

  # todo: incluir um parâmetro "clean=" que possibilita limpar os dados depois de puxar da API
  
  require(dplyr)
  require(httr)
  require(jsonlite)
  require(tidyr)
  
  flag <- TRUE
  pagina = 0
  consulta <- list(...)
  dados_draa_valores_compromissos <- data.frame()
  
  while(flag){
    draa_valores_compromissos <- GET("https://apicadprev.economia.gov.br/DRAA_VALORES_COMPROMISSOS?", query=append(consulta, list(offset = pagina)))
    stop_for_status(draa_valores_compromissos, task="connect to the server! Try again later.")
    draa_valores_compromissos_txt  <- content(draa_valores_compromissos, as="text", encoding="UTF-8")
    draa_valores_compromissos_json <- fromJSON(draa_valores_compromissos_txt, flatten = FALSE) 
    draa_valores_compromissos_df   <- as.data.frame(draa_valores_compromissos_json[["results"]][["data"]])
    dados_draa_valores_compromissos <- bind_rows(dados_draa_valores_compromissos, draa_valores_compromissos_df)
    flag <- draa_valores_compromissos_json[["results"]][["rowLimitExceeded"]]
    pagina <- pagina + 1
    Sys.sleep(1)
  }
  
  return(dados_draa_valores_compromissos)  
}
