coerce_metric_column <- function(x) {
  if (is.numeric(x)) {
    return(as.numeric(x))
  }

  cleaned <- as.character(x)
  cleaned <- gsub("\\s+", "", cleaned)
  cleaned <- gsub(",", "", cleaned, fixed = TRUE)

  suppressWarnings(as.numeric(cleaned))
}

looks_numeric_like <- function(x) {
  if (is.numeric(x)) {
    return(TRUE)
  }

  values <- as.character(x)
  values <- trimws(values)
  values <- values[!is.na(values) & values != ""]

  if (length(values) == 0) {
    return(FALSE)
  }

  values <- gsub(",", "", values, fixed = TRUE)
  all(grepl("^-?[0-9]+(\\.[0-9]+)?$", values))
}

clean_dimension_names <- function(dimensions) {
  if (is.null(dimensions) || length(dimensions) == 0) {
    return(character())
  }

  template <- as.list(rep.int(list(character()), length(dimensions)))
  names(template) <- dimensions

  names(sniiv_clean_names(tibble::as_tibble(template)))
}

sniiv_clean_names <- function(data) {
  current_names <- names(data)
  transliterated <- iconv(current_names, from = "", to = "ASCII//TRANSLIT")
  transliterated[is.na(transliterated)] <- current_names[is.na(transliterated)]

  cleaned_names <- transliterated
  cleaned_names <- tolower(cleaned_names)
  cleaned_names <- gsub("[^a-z0-9]+", "_", cleaned_names)
  cleaned_names <- gsub("(^_+|_+$)", "", cleaned_names)
  cleaned_names <- gsub("(^|_)ano($|_)", "\\1anio\\2", cleaned_names)

  names(data) <- cleaned_names
  data
}

build_empty_sniiv_tibble <- function(dimensions = NULL) {
  cleaned_dimensions <- clean_dimension_names(dimensions)

  base_columns <- c(cleaned_dimensions, "acciones", "monto")
  base_columns <- unique(base_columns)

  out <- lapply(base_columns, function(column_name) {
    if (column_name %in% c("acciones", "monto")) {
      numeric()
    } else {
      character()
    }
  })

  names(out) <- base_columns
  tibble::as_tibble(out)
}

normalize_sniiv_text <- function(raw_text) {
  if (length(raw_text) != 1 || !is.character(raw_text) || is.na(raw_text)) {
    rlang::abort("`raw_text` debe ser texto de longitud 1.")
  }

  normalized <- enc2utf8(raw_text)
  normalized <- gsub("\ufeff", "", normalized, fixed = TRUE)
  trimws(normalized)
}

extract_sniiv_payload <- function(parsed) {
  if (is.data.frame(parsed)) {
    return(tibble::as_tibble(parsed))
  }

  if (is.list(parsed) && length(parsed) == 0) {
    return(tibble::tibble())
  }

  if (is.list(parsed) && !is.null(parsed$data)) {
    if (is.data.frame(parsed$data)) {
      return(tibble::as_tibble(parsed$data))
    }

    return(dplyr::bind_rows(parsed$data))
  }

  if (is.list(parsed)) {
    return(dplyr::bind_rows(parsed))
  }

  rlang::abort("La respuesta del SNIIV no pudo convertirse a tabla.")
}

parse_sniiv_response <- function(raw_text, dimensions = NULL) {
  normalized_text <- normalize_sniiv_text(raw_text)

  if (identical(normalized_text, "")) {
    return(build_empty_sniiv_tibble(dimensions = dimensions))
  }

  parsed <- tryCatch(
    jsonlite::fromJSON(normalized_text, simplifyVector = TRUE),
    error = function(e) e
  )

  if (inherits(parsed, "error")) {
    rlang::abort(paste("No fue posible parsear la respuesta JSON:", parsed$message))
  }

  out <- extract_sniiv_payload(parsed)

  if (nrow(out) == 0) {
    return(build_empty_sniiv_tibble(dimensions = dimensions))
  }

  out <- sniiv_clean_names(out)
  protected_columns <- unique(c(
    clean_dimension_names(dimensions),
    "clave_estado",
    "clave_municipio"
  ))

  for (column_name in names(out)) {
    if (column_name %in% protected_columns) {
      next
    }

    if (looks_numeric_like(out[[column_name]])) {
      out[[column_name]] <- coerce_metric_column(out[[column_name]])
    }
  }

  tibble::as_tibble(out)
}

sniiv_perform_request <- function(url, timeout_seconds = 60) {
  httr2::request(url) |>
    httr2::req_headers(Accept = "application/json") |>
    httr2::req_user_agent("HabitaR/0.0.1") |>
    httr2::req_timeout(timeout_seconds) |>
    httr2::req_error(is_error = function(resp) FALSE) |>
    httr2::req_perform()
}

#' Construir una URL valida de consulta al SNIIV
#'
#' @param servicio Alias del servicio o nombre del endpoint.
#' @param years Uno o dos anios, o `anio,mes` para inventario.
#' @param state Clave estatal de dos digitos.
#' @param municipality Clave municipal de tres digitos.
#' @param dimensions Vector de una a cinco dimensiones.
#'
#' @return Texto con la URL completa del endpoint.
#' @export
sniiv_build_url <- function(servicio,
                            years,
                            state = "00",
                            municipality = "000",
                            dimensions) {
  resolved <- resolve_sniiv_service(servicio)
  year_text <- sniiv_validate_years(resolved$servicio[[1]], years)
  geo <- sniiv_validate_geo(state = state, municipality = municipality)
  dimension_text <- paste(
    sniiv_validate_dimensions(resolved$servicio[[1]], dimensions),
    collapse = ","
  )

  paste(
    SNIIV_BASE_URL,
    resolved$endpoint[[1]],
    year_text,
    geo$state,
    geo$municipality,
    dimension_text,
    sep = "/"
  )
}

#' Consultar un servicio publico del SNIIV
#'
#' @param servicio Alias del servicio o nombre del endpoint.
#' @param years Uno o dos anios, o `anio,mes` para inventario.
#' @param state Clave estatal de dos digitos.
#' @param municipality Clave municipal de tres digitos.
#' @param dimensions Vector de una a cinco dimensiones.
#' @param timeout_seconds Tiempo maximo por consulta.
#'
#' @return Un `tibble` con la respuesta parseada y nombres homologados.
#' @export
sniiv_get <- function(servicio,
                      years,
                      state = "00",
                      municipality = "000",
                      dimensions,
                      timeout_seconds = 60) {
  resolved <- resolve_sniiv_service(servicio)
  normalized_dimensions <- sniiv_validate_dimensions(resolved$servicio[[1]], dimensions)

  url <- sniiv_build_url(
    servicio = resolved$servicio[[1]],
    years = years,
    state = state,
    municipality = municipality,
    dimensions = normalized_dimensions
  )

  response <- tryCatch(
    sniiv_perform_request(url = url, timeout_seconds = timeout_seconds),
    error = function(e) e
  )

  if (inherits(response, "error")) {
    rlang::abort(paste("Error al consultar el SNIIV:", response$message))
  }

  status <- httr2::resp_status(response)

  if (status >= 400) {
    rlang::abort(paste0("La consulta al SNIIV fallo con codigo HTTP: ", status))
  }

  raw_text <- httr2::resp_body_string(response)
  parse_sniiv_response(raw_text = raw_text, dimensions = normalized_dimensions)
}
