test_that("get_financiamiento delega en sniiv_get con defaults nacionales", {
  testthat::local_mocked_bindings(
    sniiv_get = function(servicio,
                         years,
                         state = "00",
                         municipality = "000",
                         dimensions,
                         timeout_seconds = 60) {
      expect_equal(servicio, "financiamiento")
      expect_equal(years, c(2024, 2025))
      expect_equal(state, "00")
      expect_equal(municipality, "000")
      expect_equal(dimensions, c("anio", "estado"))
      expect_equal(timeout_seconds, 60)

      tibble::tibble(ok = TRUE)
    },
    .package = "HabitaR"
  )

  out <- HabitaR::get_financiamiento(
    years = c(2024, 2025),
    dimensions = c("anio", "estado")
  )

  expect_equal(out$ok, TRUE)
})

test_that("get_inventario usa el servicio y parametro temporal esperados", {
  testthat::local_mocked_bindings(
    sniiv_get = function(servicio,
                         years,
                         state = "00",
                         municipality = "000",
                         dimensions,
                         timeout_seconds = 60) {
      expect_equal(servicio, "inventario")
      expect_equal(years, c(2024, 6))
      expect_equal(state, "00")
      expect_equal(municipality, "000")
      expect_equal(dimensions, c("estado", "pcu"))
      expect_equal(timeout_seconds, 60)

      tibble::tibble(ok = TRUE)
    },
    .package = "HabitaR"
  )

  out <- HabitaR::get_inventario(
    year_month = c(2024, 6),
    dimensions = c("estado", "pcu")
  )

  expect_equal(out$ok, TRUE)
})
