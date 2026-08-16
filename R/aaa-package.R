#' HabitaR: consultas reproducibles al SNIIV
#'
#' `HabitaR` organiza una primera capa reproducible para consultar la API
#' publica del Sistema Nacional de Informacion e Indicadores de Vivienda
#' (SNIIV). La arquitectura sigue la separacion de capas validada en
#' `AnaliSIIs`, pero usa exclusivamente contratos publicos del SNIIV.
#'
#' El paquete cubre cinco tareas:
#'
#' - catalogo interno de endpoints y dimensiones disponibles;
#' - validacion de anios, claves geoestadisticas y dimensiones;
#' - construccion de URLs al patron `endpoint/anios/estado/municipio/dimensiones`;
#' - transporte HTTP con `httr2`;
#' - normalizacion de respuestas JSON a `tibble`s listos para analisis.
#'
#' @section Puntos de entrada principales:
#' \itemize{
#'   \item \code{\link{sniiv_endpoints}}
#'   \item \code{\link{sniiv_dimensions}}
#'   \item \code{\link{sniiv_build_url}}
#'   \item \code{\link{sniiv_get}}
#'   \item \code{\link{get_financiamiento}}
#'   \item \code{\link{get_inventario}}
#' }
#'
#' @section Convenciones del paquete:
#' \itemize{
#'   \item Solo usa endpoints publicamente documentados del SNIIV.
#'   \item `state` siempre usa dos digitos y `municipality` tres.
#'   \item Cada consulta acepta entre una y cinco dimensiones.
#'   \item `inventario` usa el modo especial `anio,mes`.
#'   \item Las respuestas se homologan a nombres ASCII en `snake_case`.
#' }
#'
#' @keywords internal
"_PACKAGE"
