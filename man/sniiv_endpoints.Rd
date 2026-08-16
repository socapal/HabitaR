\name{sniiv_endpoints}
\alias{sniiv_endpoints}
\title{Ver catalogo de endpoints publicos del SNIIV}
\usage{
sniiv_endpoints()
}
\value{
Un \code{tibble} con el nombre del servicio, endpoint documentado,
tema de referencia y modo de validacion temporal.
}
\description{
Devuelve el catalogo interno de servicios publicamente documentados del SNIIV
que usa el paquete.
}
\examples{
sniiv_endpoints()
}
\seealso{
\code{\link{sniiv_dimensions}},
\code{\link{sniiv_build_url}}
}
