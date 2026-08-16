\name{sniiv_build_url}
\alias{sniiv_build_url}
\title{Construir una URL valida de consulta al SNIIV}
\usage{
sniiv_build_url(
  servicio,
  years,
  state = "00",
  municipality = "000",
  dimensions
)
}
\arguments{
  \item{servicio}{Alias del servicio o nombre del endpoint.}
  \item{years}{Uno o dos anios, o \code{anio,mes} para inventario.}
  \item{state}{Clave estatal de dos digitos.}
  \item{municipality}{Clave municipal de tres digitos.}
  \item{dimensions}{Vector de una a cinco dimensiones.}
}
\value{
Texto con la URL completa del endpoint.
}
\description{
Valida servicio, periodo, claves geoestadisticas y dimensiones, y construye la
URL final al endpoint publico del SNIIV.
}
\examples{
sniiv_build_url(
  servicio = "infonavit",
  years = c(2024, 2025),
  state = "00",
  municipality = "000",
  dimensions = c("anio", "estado", "modalidad")
)

sniiv_build_url(
  servicio = "inventario",
  years = c(2024, 6),
  dimensions = c("estado", "pcu", "avance_obra")
)
}
\seealso{
\code{\link{sniiv_dimensions}},
\code{\link{sniiv_get}}
}
