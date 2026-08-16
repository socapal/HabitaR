\name{get_financiamiento}
\alias{get_financiamiento}
\alias{get_conavi}
\alias{get_fovissste}
\alias{get_infonavit}
\alias{get_cnbv}
\alias{get_insus}
\alias{get_inventario}
\alias{get_registro}
\title{Wrappers por servicio del SNIIV}
\usage{
get_financiamiento(
  years,
  state = "00",
  municipality = "000",
  dimensions,
  timeout_seconds = 60
)

get_conavi(
  years,
  state = "00",
  municipality = "000",
  dimensions,
  timeout_seconds = 60
)

get_fovissste(
  years,
  state = "00",
  municipality = "000",
  dimensions,
  timeout_seconds = 60
)

get_infonavit(
  years,
  state = "00",
  municipality = "000",
  dimensions,
  timeout_seconds = 60
)

get_cnbv(
  years,
  state = "00",
  municipality = "000",
  dimensions,
  timeout_seconds = 60
)

get_insus(
  years,
  state = "00",
  municipality = "000",
  dimensions,
  timeout_seconds = 60
)

get_inventario(
  year_month,
  state = "00",
  municipality = "000",
  dimensions,
  timeout_seconds = 60
)

get_registro(
  years,
  state = "00",
  municipality = "000",
  dimensions,
  timeout_seconds = 60
)
}
\arguments{
  \item{years}{Uno o dos anios, o \code{anio,mes} para inventario.}
  \item{year_month}{Texto o vector en formato \code{anio,mes}.}
  \item{state}{Clave estatal de dos digitos.}
  \item{municipality}{Clave municipal de tres digitos.}
  \item{dimensions}{Vector de una a cinco dimensiones.}
  \item{timeout_seconds}{Tiempo maximo por consulta.}
}
\value{
Un \code{tibble}.
}
\description{
Estas funciones son envoltorios semanticos sobre \code{\link{sniiv_get}} para
facilitar la consulta de cada servicio documentado del SNIIV.
}
\details{
\itemize{
  \item \code{get_financiamiento()} consulta \code{GetFinanciamiento}.
  \item \code{get_conavi()} consulta \code{GetCONAVI}.
  \item \code{get_fovissste()} consulta \code{GetFOVISSSTE}.
  \item \code{get_infonavit()} consulta \code{GetInfonavit}.
  \item \code{get_cnbv()} consulta \code{GetCNBV}.
  \item \code{get_insus()} consulta \code{GetInsus}.
  \item \code{get_inventario()} consulta \code{GetInventario}.
  \item \code{get_registro()} consulta \code{GetRegistro}.
}
}
\examples{
\dontrun{
get_financiamiento(
  years = c(2024, 2025),
  dimensions = c("anio", "estado")
)

get_inventario(
  year_month = c(2024, 6),
  dimensions = c("estado", "pcu")
)
}
}
\seealso{
\code{\link{sniiv_get}},
\code{\link{sniiv_build_url}}
}
