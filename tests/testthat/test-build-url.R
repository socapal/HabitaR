test_that("sniiv_build_url construye URL valida para servicios regulares", {
  url <- HabitaR::sniiv_build_url(
    servicio = "infonavit",
    years = c(2024, 2025),
    state = "00",
    municipality = "000",
    dimensions = c("anio", "estado", "modalidad")
  )

  expect_equal(
    url,
    paste0(
      "https://sniiv.sedatu.gob.mx/api/CuboAPI/",
      "GetInfonavit/2024,2025/00/000/anio,estado,modalidad"
    )
  )
})

test_that("sniiv_build_url acepta el formato anio,mes para inventario", {
  url <- HabitaR::sniiv_build_url(
    servicio = "inventario",
    years = c(2024, 6),
    state = 0,
    municipality = 0,
    dimensions = c("estado", "pcu", "avance_obra")
  )

  expect_equal(
    url,
    paste0(
      "https://sniiv.sedatu.gob.mx/api/CuboAPI/",
      "GetInventario/2024,6/00/000/estado,pcu,avance_obra"
    )
  )
})

test_that("sniiv_build_url valida servicio, dimensiones y claves geo", {
  expect_error(
    HabitaR::sniiv_build_url(
      servicio = "foo",
      years = 2024,
      dimensions = "anio"
    ),
    "no es valido"
  )

  expect_error(
    HabitaR::sniiv_build_url(
      servicio = "infonavit",
      years = c(2024, 2025),
      dimensions = c("anio", "mes", "estado", "municipio", "genero", "modalidad")
    ),
    "hasta cinco dimensiones"
  )

  expect_error(
    HabitaR::sniiv_build_url(
      servicio = "infonavit",
      years = c(2024, 2025),
      dimensions = c("anio", "foo")
    ),
    "Dimensiones no validas"
  )

  expect_error(
    HabitaR::sniiv_build_url(
      servicio = "infonavit",
      years = c(2024, 2025),
      state = "999",
      municipality = "000",
      dimensions = c("anio", "estado")
    ),
    "state"
  )

  expect_error(
    HabitaR::sniiv_build_url(
      servicio = "infonavit",
      years = c(2024, 2025),
      state = "00",
      municipality = "9999",
      dimensions = c("anio", "estado")
    ),
    "municipality"
  )
})
