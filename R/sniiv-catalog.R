SNIIV_BASE_URL <- "https://sniiv.sedatu.gob.mx/api/CuboAPI"

sniiv_endpoint_catalog <- function() {
  tibble::tribble(
    ~servicio,         ~endpoint,             ~tema,                    ~year_mode,
    "financiamiento",  "GetFinanciamiento",   "Creditos y subsidios",   "year_range",
    "conavi",          "GetCONAVI",           "Subsidios CONAVI",       "year_range",
    "fovissste",       "GetFOVISSSTE",        "Creditos FOVISSSTE",     "year_range",
    "infonavit",       "GetInfonavit",        "Creditos INFONAVIT",     "year_range",
    "cnbv",            "GetCNBV",             "Creditos bancarios",     "year_range",
    "insus",           "GetInsus",            "Regularizacion",         "year_range",
    "inventario",      "GetInventario",       "Inventario RUV",         "year_month",
    "registro",        "GetRegistro",         "Registro RUV",           "year_range"
  )
}

sniiv_dimension_catalog <- function() {
  list(
    financiamiento = c(
      "anio", "mes", "estado", "municipio", "zona", "destino_credito",
      "genero", "grupo_organismo", "modalidad", "organismo",
      "poblacion_indigena", "rango_edad", "rango_salarial",
      "tipo_credito", "valor_vivienda"
    ),
    conavi = c(
      "anio", "mes", "estado", "municipio", "zona", "modalidad",
      "organismo_ejecutor_obra", "desarrollo_certificado", "esquema",
      "tipo_entidad_ejecutora", "entidad_ejecutora", "genero",
      "poblacion_indigena", "pcu", "rango_edad", "rango_salarial",
      "tipo_vivienda"
    ),
    fovissste = c(
      "anio", "mes", "estado", "municipio", "zona", "esquema",
      "entidad_financiera", "genero", "linea_credito", "modalidad",
      "poblacion_indigena", "rango_edad", "rango_salarial",
      "valor_vivienda"
    ),
    infonavit = c(
      "anio", "mes", "estado", "municipio", "estado_civil", "esquema",
      "genero", "intermediario_financiero", "linea_credito", "modalidad",
      "rango_edad", "rango_salarial", "tipo_credito", "valor_vivienda",
      "vivienda"
    ),
    cnbv = c(
      "anio", "mes", "estado", "municipio", "zona", "esquema",
      "genero", "intermediario_financiero", "linea_credito", "modalidad",
      "poblacion_indigena", "rango_edad", "rango_salarial",
      "valor_vivienda"
    ),
    insus = c(
      "anio", "mes", "estado", "municipio", "zona", "rango_edad",
      "genero", "escolaridad", "estado_civil", "discapacidad",
      "condicion_indigena", "alfabetismo", "intentos_desalojo",
      "pavimentacion", "alumbrado", "transporte_publico",
      "numero_integrantes", "numero_cuartos", "poblacion_indigena"
    ),
    inventario = c(
      "estado", "municipio", "avance_obra", "segmento_uma",
      "tipo_vivienda", "pcu", "segmento", "subsidio"
    ),
    registro = c(
      "anio", "mes", "estado", "municipio", "pcu", "segmento",
      "segmento_uma", "tipo_vivienda", "superficie", "recamara"
    )
  )
}

normalize_lookup_key <- function(x) {
  gsub("[^a-z0-9]+", "", tolower(trimws(as.character(x))))
}

validate_single_string <- function(x, arg) {
  if (!is.character(x) || length(x) != 1 || is.na(x) || trimws(x) == "") {
    rlang::abort(paste0("`", arg, "` debe ser texto de longitud 1 y no vacio."))
  }

  invisible(TRUE)
}

resolve_sniiv_service <- function(servicio) {
  validate_single_string(servicio, "servicio")

  lookup <- normalize_lookup_key(servicio)
  catalog <- sniiv_endpoint_catalog()
  alias_map <- list(
    financiamiento = c("financiamiento", "financiamientos", "getfinanciamiento"),
    conavi = c("conavi", "getconavi"),
    fovissste = c("fovissste", "getfovissste"),
    infonavit = c("infonavit", "getinfonavit", "getinfonavit"),
    cnbv = c("cnbv", "getcnbv"),
    insus = c("insus", "getinsus"),
    inventario = c("inventario", "getinventario"),
    registro = c("registro", "getregistro")
  )

  matched_service <- names(alias_map)[vapply(
    alias_map,
    function(values) lookup %in% values,
    logical(1)
  )]

  if (length(matched_service) != 1) {
    rlang::abort(
      paste0(
        "`servicio` no es valido. Usa uno de: ",
        paste(catalog$servicio, collapse = ", ")
      )
    )
  }

  catalog[catalog$servicio == matched_service, , drop = FALSE]
}

#' Ver catalogo de endpoints publicos del SNIIV
#'
#' @return Un `tibble` con el nombre del servicio, endpoint documentado,
#'   tema de referencia y modo de validacion temporal.
#' @export
sniiv_endpoints <- function() {
  sniiv_endpoint_catalog()
}

#' Obtener dimensiones validas para un servicio del SNIIV
#'
#' @param servicio Alias del servicio o nombre del endpoint.
#'
#' @return Vector caracter con las dimensiones permitidas.
#' @export
sniiv_dimensions <- function(servicio) {
  resolved <- resolve_sniiv_service(servicio)
  sniiv_dimension_catalog()[[resolved$servicio[[1]]]]
}
