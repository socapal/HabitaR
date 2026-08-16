#' Consultar financiamientos del SNIIV
#'
#' @inheritParams sniiv_get
#'
#' @return Un `tibble`.
#' @export
get_financiamiento <- function(years,
                               state = "00",
                               municipality = "000",
                               dimensions,
                               timeout_seconds = 60) {
  sniiv_get(
    servicio = "financiamiento",
    years = years,
    state = state,
    municipality = municipality,
    dimensions = dimensions,
    timeout_seconds = timeout_seconds
  )
}

#' Consultar subsidios CONAVI del SNIIV
#'
#' @inheritParams sniiv_get
#'
#' @return Un `tibble`.
#' @export
get_conavi <- function(years,
                       state = "00",
                       municipality = "000",
                       dimensions,
                       timeout_seconds = 60) {
  sniiv_get(
    servicio = "conavi",
    years = years,
    state = state,
    municipality = municipality,
    dimensions = dimensions,
    timeout_seconds = timeout_seconds
  )
}

#' Consultar creditos FOVISSSTE del SNIIV
#'
#' @inheritParams sniiv_get
#'
#' @return Un `tibble`.
#' @export
get_fovissste <- function(years,
                          state = "00",
                          municipality = "000",
                          dimensions,
                          timeout_seconds = 60) {
  sniiv_get(
    servicio = "fovissste",
    years = years,
    state = state,
    municipality = municipality,
    dimensions = dimensions,
    timeout_seconds = timeout_seconds
  )
}

#' Consultar creditos INFONAVIT del SNIIV
#'
#' @inheritParams sniiv_get
#'
#' @return Un `tibble`.
#' @export
get_infonavit <- function(years,
                          state = "00",
                          municipality = "000",
                          dimensions,
                          timeout_seconds = 60) {
  sniiv_get(
    servicio = "infonavit",
    years = years,
    state = state,
    municipality = municipality,
    dimensions = dimensions,
    timeout_seconds = timeout_seconds
  )
}

#' Consultar creditos CNBV del SNIIV
#'
#' @inheritParams sniiv_get
#'
#' @return Un `tibble`.
#' @export
get_cnbv <- function(years,
                     state = "00",
                     municipality = "000",
                     dimensions,
                     timeout_seconds = 60) {
  sniiv_get(
    servicio = "cnbv",
    years = years,
    state = state,
    municipality = municipality,
    dimensions = dimensions,
    timeout_seconds = timeout_seconds
  )
}

#' Consultar acciones INSUS del SNIIV
#'
#' @inheritParams sniiv_get
#'
#' @return Un `tibble`.
#' @export
get_insus <- function(years,
                      state = "00",
                      municipality = "000",
                      dimensions,
                      timeout_seconds = 60) {
  sniiv_get(
    servicio = "insus",
    years = years,
    state = state,
    municipality = municipality,
    dimensions = dimensions,
    timeout_seconds = timeout_seconds
  )
}

#' Consultar inventario de vivienda del SNIIV
#'
#' @param year_month Texto o vector en formato `anio,mes`.
#' @inheritParams sniiv_get
#'
#' @return Un `tibble`.
#' @export
get_inventario <- function(year_month,
                           state = "00",
                           municipality = "000",
                           dimensions,
                           timeout_seconds = 60) {
  sniiv_get(
    servicio = "inventario",
    years = year_month,
    state = state,
    municipality = municipality,
    dimensions = dimensions,
    timeout_seconds = timeout_seconds
  )
}

#' Consultar registro de vivienda del SNIIV
#'
#' @inheritParams sniiv_get
#'
#' @return Un `tibble`.
#' @export
get_registro <- function(years,
                         state = "00",
                         municipality = "000",
                         dimensions,
                         timeout_seconds = 60) {
  sniiv_get(
    servicio = "registro",
    years = years,
    state = state,
    municipality = municipality,
    dimensions = dimensions,
    timeout_seconds = timeout_seconds
  )
}
