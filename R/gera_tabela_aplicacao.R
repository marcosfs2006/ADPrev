gera_tabela_aplicacao <- function(dair, cadastro=NULL, cnpj.fundo, uf=NULL){
  
  
  # A ideia da função é gerar uma tabela com os RPPS que aplicam recursos no fundo
  # explicitado 
  
  # uf - se for colocada uma sigla, a tabela se restringe aos fundos de RPPS da citada UF
  #      
  # dair - base de dados do dair
  
  # cnpj.fundo = vetor de cnpj de fundos de investimentos (ampliar para um vetor de fundos.)
  
  require(dplyr)
  require(tidyr)
  
  # limpar o fundo.
  cnpj.fundo <- gsub("[[:punct:]]", "", cnpj.fundo)
  
  dair <- dair %>% 
    filter(ident_ativo == cnpj.fundo) %>%
    arrange(competencia) %>% 
    select(cnpj, ente, uf, competencia, vlr_total_atual) %>% 
    pivot_wider(id_cols = c(cnpj, ente, uf), 
                names_from = competencia,
                values_from = vlr_total_atual,
                values_fn = max) %>% 
    arrange(uf, ente) %>% 
    mutate(cnpj_fundo = cnpj.fundo, .before=cnpj) #%>% 
    #relocate(cnpj_fundo, .before=ente)
  
    # todo: se o RPPS não entregou o DAIR, colocar um valor específico 
  if(is.null(uf)){
    dair
  } else {
    dair %>% filter(uf == uf)
  }

}


