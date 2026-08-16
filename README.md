# HabitaR

## Descripcion

**HabitaR** es un paquete en R para consultar de forma reproducible la API
publica del Sistema Nacional de Informacion e Indicadores de Vivienda (SNIIV).
La primera version del paquete se concentra en una arquitectura minima:

- catalogo interno de endpoints publicos;
- catalogo de dimensiones por servicio;
- validacion de anios, claves geoestadisticas y dimensiones;
- construccion de URLs reproducibles;
- consultas HTTP con `httr2`;
- parsing y limpieza de respuestas JSON a `tibble`.

El paquete usa solo contratos publicamente documentados del SNIIV.

## Endpoints cubiertos

- `GetFinanciamiento`
- `GetCONAVI`
- `GetFOVISSSTE`
- `GetInfonavit`
- `GetCNBV`
- `GetInsus`
- `GetInventario`
- `GetRegistro`

Quedan fuera de este MVP los endpoints no documentados con suficiente detalle,
como verificacion y produccion.

## Instalacion local

Desde una sesion de R:

```r
install.packages("remotes")
remotes::install_local(
  "C:/NonCloudStorage/G13B_HabitaR/HabitaR",
  upgrade = "never",
  dependencies = TRUE
)
```

O desde terminal, descargando el paquete y ejecutando los siguientes pasos:

```sh
R CMD INSTALL .
```

## Inicio rapido

### 1. Cargar el paquete

```r
library(HabitaR)
```

### 2. Ver endpoints disponibles

```r
sniiv_endpoints()
```

### 3. Ver dimensiones de un servicio

```r
sniiv_dimensions("infonavit")
```

### 4. Construir una URL valida

```r
sniiv_build_url(
  servicio = "infonavit",
  years = c(2024, 2025),
  state = "00",
  municipality = "000",
  dimensions = c("anio", "estado", "modalidad")
)
```

### 5. Probar el parser en modo offline

```r
raw_text <- paste(
  readLines(
    system.file("extdata", "mock-sniiv-response.json", package = "HabitaR"),
    warn = FALSE
  ),
  collapse = "\n"
)

out <- HabitaR:::parse_sniiv_response(
  raw_text = raw_text,
  dimensions = c("anio", "estado", "modalidad")
)

out
```

### 6. Ejecutar una consulta real

```r
# Ejecuta una llamada HTTP real al SNIIV
resultado <- get_financiamiento(
  years = c(2024, 2025),
  state = "00",
  municipality = "000",
  dimensions = c("anio", "estado", "organismo")
)
```

## Convenciones

- `state` siempre usa una clave de dos digitos.
- `municipality` siempre usa una clave de tres digitos.
- Cada consulta acepta entre una y cinco dimensiones.
- `inventario` usa el formato especial `anio,mes`.
- Las respuestas se limpian a nombres ASCII en `snake_case`.

## Estructura del paquete

```text
HabitaR/
├── DESCRIPTION
├── NAMESPACE
├── R/
│   ├── aaa-package.R
│   ├── sniiv-catalog.R
│   ├── sniiv-validate.R
│   ├── sniiv-client.R
│   └── sniiv-wrappers.R
├── inst/
│   └── extdata/
│       └── mock-sniiv-response.json
├── tests/
│   └── testthat/
└── vignettes/
    └── introduccion-sniiv.Rmd
```

## Fuente

Datos publicos del Sistema Nacional de Informacion e Indicadores de Vivienda
(SNIIV) de SEDATU.
