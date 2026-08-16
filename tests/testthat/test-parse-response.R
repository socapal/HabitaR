test_that("parse_sniiv_response convierte fixture local a tibble limpio", {
  raw_path <- testthat::test_path("..", "..", "inst", "extdata", "mock-sniiv-response.json")
  raw_text <- paste(readLines(raw_path, warn = FALSE), collapse = "\n")

  out <- HabitaR:::parse_sniiv_response(
    raw_text = raw_text,
    dimensions = c("anio", "estado", "modalidad")
  )

  expect_s3_class(out, "tbl_df")
  expect_equal(nrow(out), 2)
  expect_named(out, c("anio", "estado", "modalidad", "acciones", "monto"))
  expect_equal(out$acciones, c(10, 12))
  expect_equal(out$monto, c(1500000, 1750000))
})

test_that("parse_sniiv_response devuelve tibble vacio tipado para respuestas vacias", {
  out <- HabitaR:::parse_sniiv_response(
    raw_text = "[]",
    dimensions = c("anio", "estado", "modalidad")
  )

  expect_s3_class(out, "tbl_df")
  expect_equal(nrow(out), 0)
  expect_named(out, c("anio", "estado", "modalidad", "acciones", "monto"))
  expect_type(out$anio, "character")
  expect_type(out$acciones, "double")
  expect_type(out$monto, "double")
})

test_that("parse_sniiv_response falla con JSON invalido", {
  expect_error(
    HabitaR:::parse_sniiv_response("{"),
    "parsear"
  )
})
