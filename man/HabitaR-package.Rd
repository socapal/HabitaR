\name{HabitaR-package}
\alias{HabitaR}
\alias{HabitaR-package}
\docType{package}
\title{HabitaR: consultas reproducibles al SNIIV}
\description{
HabitaR organiza una primera capa reproducible para consultar la API publica
del Sistema Nacional de Informacion e Indicadores de Vivienda (SNIIV).
}
\details{
La arquitectura del paquete separa cinco tareas principales:

\itemize{
  \item catalogo interno de endpoints y dimensiones disponibles;
  \item validacion de anios, claves geoestadisticas y dimensiones;
  \item construccion de URLs al patron
  \code{endpoint/anios/estado/municipio/dimensiones};
  \item transporte HTTP con \code{httr2};
  \item normalizacion de respuestas JSON a \code{tibble}s listos para analisis.
}

El paquete usa solo endpoints publicamente documentados del SNIIV.
}
\section{Puntos de entrada principales}{
\code{\link{sniiv_endpoints}},
\code{\link{sniiv_dimensions}},
\code{\link{sniiv_build_url}},
\code{\link{sniiv_get}},
\code{\link{get_financiamiento}} y
\code{\link{get_inventario}}.
}
\section{Convenciones del paquete}{
\itemize{
  \item \code{state} siempre usa dos digitos y \code{municipality} tres.
  \item Cada consulta acepta entre una y cinco dimensiones.
  \item \code{inventario} usa el modo especial \code{anio,mes}.
  \item Las respuestas se homologan a nombres ASCII en \code{snake_case}.
}
}
\seealso{
\code{\link{sniiv_endpoints}},
\code{\link{sniiv_build_url}},
\code{\link{sniiv_get}}
}
