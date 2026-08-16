normalize_year_tokens <- function(years) {
  if (missing(years) || length(years) == 0) {
    rlang::abort("`years` debe contener al menos un valor.")
  }

  if (length(years) == 1) {
    year_text <- trimws(as.character(years))

    if (is.na(year_text) || year_text == "") {
      rlang::abort("`years` no puede ser vacio.")
    }

    if (grepl(",", year_text, fixed = TRUE)) {
      tokens <- strsplit(year_text, ",", fixed = TRUE)[[1]]
      return(trimws(tokens))
    }

    return(year_text)
  }

  trimws(as.character(years))
}

validate_year_token <- function(x, arg = "years") {
  if (length(x) != 1 || is.na(x) || !grepl("^[0-9]{4}$", x)) {
    rlang::abort(paste0("`", arg, "` debe usar anios de cuatro digitos."))
  }

  invisible(TRUE)
}

validate_month_token <- function(x, arg = "years") {
  if (length(x) != 1 || is.na(x) || !grepl("^[0-9]{1,2}$", x)) {
    rlang::abort(
      paste0("`", arg, "` para inventario debe usar el formato `anio,mes`.")
    )
  }

  month_value <- suppressWarnings(as.integer(x))

  if (is.na(month_value) || month_value < 1 || month_value > 12) {
    rlang::abort("El mes de `years` para inventario debe estar entre 1 y 12.")
  }

  invisible(TRUE)
}

normalize_geo_code <- function(x, width, arg) {
  if (length(x) != 1 || is.na(x)) {
    rlang::abort(paste0("`", arg, "` debe ser escalar y no `NA`."))
  }

  normalized <- stringr::str_pad(
    string = trimws(as.character(x)),
    width = width,
    side = "left",
    pad = "0"
  )

  if (!grepl(paste0("^[0-9]{", width, "}$"), normalized)) {
    rlang::abort(
      paste0("`", arg, "` debe ser una clave de ", width, " digitos.")
    )
  }

  normalized
}

sniiv_validate_years <- function(servicio, years) {
  resolved <- resolve_sniiv_service(servicio)
  year_mode <- resolved$year_mode[[1]]
  tokens <- normalize_year_tokens(years)

  if (identical(year_mode, "year_month")) {
    if (length(tokens) != 2) {
      rlang::abort("`years` para inventario debe usar el formato `anio,mes`.")
    }

    validate_year_token(tokens[[1]])
    validate_month_token(tokens[[2]])

    return(paste0(tokens[[1]], ",", as.integer(tokens[[2]])))
  }

  if (!length(tokens) %in% c(1, 2)) {
    rlang::abort("`years` debe contener uno o dos anios.")
  }

  purrr::walk(tokens, validate_year_token)
  paste(tokens, collapse = ",")
}

sniiv_validate_geo <- function(state = "00", municipality = "000") {
  list(
    state = normalize_geo_code(state, width = 2, arg = "state"),
    municipality = normalize_geo_code(municipality, width = 3, arg = "municipality")
  )
}

sniiv_validate_dimensions <- function(servicio, dimensions) {
  if (missing(dimensions) || length(dimensions) == 0) {
    rlang::abort("`dimensions` debe contener al menos una dimension.")
  }

  normalized <- trimws(as.character(dimensions))

  if (any(is.na(normalized)) || any(normalized == "")) {
    rlang::abort("`dimensions` no puede contener valores vacios o `NA`.")
  }

  if (length(normalized) > 5) {
    rlang::abort("El SNIIV permite hasta cinco dimensiones por consulta.")
  }

  allowed <- sniiv_dimensions(servicio)
  unknown <- setdiff(normalized, allowed)

  if (length(unknown) > 0) {
    rlang::abort(
      paste0(
        "Dimensiones no validas para `", resolve_sniiv_service(servicio)$servicio[[1]], "`: ",
        paste(unknown, collapse = ", ")
      )
    )
  }

  unique(normalized)
}
