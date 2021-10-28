get_progestao <- function(pdf){
  
  if(!require(tabulizer)) stop("Pacote tabulizer não instalado!")

  # extração dos dados
  progestao <- extract_tables(pdf)
  progestao <- as.data.frame(do.call(rbind, progestao))
  progestao <- progestao[-1,-1] # exclui 1a linha e 1a coluna
  
  names(progestao) <- c("cnpj", "ente", "uf", "dt_recebimento",
                        "dt_termo_adesao", "dt_certificacao", "nivel")
  
  progestao$ente <- iconv(progestao$ente, from="utf-8", to="latin1")
  progestao
}
