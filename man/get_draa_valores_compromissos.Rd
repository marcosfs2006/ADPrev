% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_draa_valores_compromissos.R
\name{get_draa_valores_compromissos}
\alias{get_draa_valores_compromissos}
\title{Extrai dados do DRAA da API do CADPREV}
\usage{
get_draa_valores_compromissos(...)
}
\arguments{
\item{...}{Qualquer um dos parâmetros de consulta disponibilizados pela API
para a consulta aos dados de compromissos do DRAA.}
}
\value{
Um \code{data frame} contendo os dados requisitados.
}
\description{
Função para a obtenção de dados relativos aos valores dos compromissos 
obtidos na avaliação atuarial anual do RPPS e registrados no  
Demonstrativo de Resultados da Avaliação Atuarial - DRAA,
utilizando a API do CADPREV cuja documentação pode ser consultada em 
\url{https://apicadprev.economia.gov.br/api-docs/}.
}
\details{
Embora a função aceite como parâmetros qualquer um dos que possam ser passados
ao ponto de acesso \code{DRAA_VALORES_COMPROMISSOS} recomendamos utilizar os 
parâmtros abaixo elencados e depois realizar os filtros desejados.


\itemize{
  \item \code{nr_cnpj_entidade} caractere indicando o CNPJ do Ente a que pertence o RPPS
  \item \code{no_ente} caractere indicando o nome do Ente a que pertence o RPPS
  \item \code{sg_uf} caractere indicando a sigla da unidade da federação a que pertence o RPPS
  \item \code{dt_exercicio} inteiro indicando o ano do DRAA
}

A sigla da UF deve ser fornecida em letras maiúsculas.

O nome do Ente deve ser fornecido exatamente como consta da base de dados.

Para evitar erros devidos a incorreções no nome do Ente recomenda-se utilizar
o CNPJ do Ente para consultas relativas a um RPPS específico.

O ano do DRAA (\code{dt_exercicio}) é o ano posterior ao ano da data base
da avaliação atuarial.

Se a avaliação atuarial tem data base em 31/12/2019 o ano do DRAA é 2020.
}
\examples{
\dontrun{ 
# Obtém dados dos valores dos compromissos dos DRAA  dos RPPS do RJ para todos
# os anos disponíveis na base de dados (2015 em diante)
draa_RJ <- get_draa_valores_compromissos(sg_uf="RJ") 

# Obtém dados dos valores dos compromissos do DRAA do RPPS de Quatis - RJ do ano de 2019
draa_QuatisRJ2019 <- get_draa_valores_compromissos(nr_cnpj_entidade = "39560008000148",
                                                   dt_exercicio=2019)
}

}
