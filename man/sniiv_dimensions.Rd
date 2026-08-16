\name{sniiv_dimensions}
\alias{sniiv_dimensions}
\title{Obtener dimensiones validas para un servicio del SNIIV}
\usage{
sniiv_dimensions(servicio)
}
\arguments{
  \item{servicio}{Alias del servicio o nombre del endpoint.}
}
\value{
Vector caracter con las dimensiones permitidas.
}
\description{
Resuelve un servicio del SNIIV y devuelve las dimensiones aceptadas por el
catalogo interno del paquete.
}
\examples{
sniiv_dimensions("infonavit")
sniiv_dimensions("GetFinanciamiento")
}
\seealso{
\code{\link{sniiv_endpoints}},
\code{\link{sniiv_build_url}}
}
