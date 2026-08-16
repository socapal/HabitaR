test_that("sniiv_endpoints devuelve el catalogo publico esperado", {
  endpoints <- HabitaR::sniiv_endpoints()

  expect_s3_class(endpoints, "tbl_df")
  expect_equal(nrow(endpoints), 8)
  expect_named(endpoints, c("servicio", "endpoint", "tema", "year_mode"))
  expect_true(all(c("financiamiento", "inventario", "registro") %in% endpoints$servicio))
})

test_that("sniiv_dimensions resuelve aliases y devuelve dimensiones validas", {
  dims <- HabitaR::sniiv_dimensions("GetFinanciamiento")

  expect_true(is.character(dims))
  expect_true(all(c("anio", "estado", "organismo") %in% dims))
})

test_that("sniiv_dimensions falla con servicio invalido", {
  expect_error(
    HabitaR::sniiv_dimensions("foo"),
    "no es valido"
  )
})
