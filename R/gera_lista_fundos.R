gera_lista_fundos <- function(dair){   #, uf, cnpj.ente, ano
  
  # dair - base de dados do dair conforme importada para exibição no painel
  
  require(stringr)
  
  dair %>% 
    filter(str_detect(ident_ativo, "\\d{8}0001\\d{2}"),
           nchar(ident_ativo) == 14,
           str_detect(tipo_ativo, "^(Fundos?|FI|ETF)"))
}
