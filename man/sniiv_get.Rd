\name{sniiv_get}
\alias{sniiv_get}
\title{Consultar un servicio publico del SNIIV}
\usage{
sniiv_get(
  servicio,
  years,
  state = "00",
  municipality = "000",
  dimensions,
  timeout_seconds = 60
)
}
\arguments{
  \item{servicio}{Alias del servicio o nombre del endpoint.}
  \item{years}{Uno o dos anios, o \code{anio,mes} para inventario.}
  \item{state}{Clave estatal de dos digitos.}
  \item{municipality}{Clave municipal de tres digitos.}
  \item{dimensions}{Vector de una a cinco dimensiones.}
  \item{timeout_seconds}{Tiempo maximo por consulta.}
}
\value{
Un \code{tibble} con la respuesta parseada y nombres homologados.
}
\description{
Ejecuta una consulta HTTP contra un endpoint publico del SNIIV y devuelve la
respuesta JSON como \code{tibble}, con columnas normalizadas a ASCII en
\code{snake_case}.
}
\details{
Si la respuesta es vacia, el paquete devuelve un \code{tibble} vacio tipado.
Si la consulta falla por HTTP o por parametros invalidos, se emite un mensaje
de error claro.
}
\examples{
\dontrun{
sniiv_get(
  servicio = "financiamiento",
  years = c(2024, 2025),
  state = "00",
  municipality = "000",
  dimensions = c("anio", "estado", "organismo")
)
}
}
\seealso{
\code{\link{sniiv_build_url}},
\code{\link{get_financiamiento}}
}
