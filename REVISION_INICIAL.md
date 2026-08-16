# Revision inicial de HabitaR

Fecha de corte: 2026-08-16

## Objetivo

Esta revision establece una linea base tecnica para el primer incremento de
HabitaR. El alcance evaluado es exclusivamente la consulta reproducible de los
endpoints publicos documentados del SNIIV.

## Alcance del MVP

El paquete ya separa las responsabilidades principales en catalogos,
validacion, construccion de URLs, transporte HTTP, parsing y wrappers. Para
este MVP se mantienen los ocho servicios declarados por `sniiv_endpoints()`:

- financiamiento;
- CONAVI;
- FOVISSSTE;
- Infonavit;
- CNBV;
- INSUS;
- inventario;
- registro.

No se propone integrar otra API en esta etapa. Otras fuentes de informacion de
vivienda pueden evaluarse como **posible alcance futuro**, una vez estabilizado
el contrato publico del modulo SNIIV. Esa posibilidad no implica compromiso de
implementacion ni debe ampliar las dependencias o abstracciones actuales.

## Estado observado

| Area | Estado | Evidencia en el repositorio |
| --- | --- | --- |
| Metadatos | Implementado | `DESCRIPTION` declara R >= 4.2.0, dependencias y licencia GPL-3. |
| Catalogos | Implementado | Catalogos internos de endpoints y dimensiones en `R/sniiv-catalog.R`. |
| Validacion | Implementado | Validacion temporal, geografica y de dimensiones en `R/sniiv-validate.R`. |
| Cliente | Implementado | URL, transporte, errores HTTP y parsing en `R/sniiv-client.R`. |
| Interfaz | Implementado | Un wrapper exportado por cada servicio en `R/sniiv-wrappers.R`. |
| Pruebas offline | Parcial | Hay pruebas de catalogo, URLs, parser y delegacion de dos wrappers. |
| Documentacion | Parcial | README, ayuda generada y vignette introductoria disponibles. |
| Verificacion en vivo | Pendiente | No hay una prueba de integracion optativa contra el SNIIV. |

## Hallazgos y riesgos

### Prioridad alta

1. **Falta ejecutar la verificacion estandar del paquete.** La revision debe
   cerrarse en un entorno con R y las dependencias instaladas mediante
   `R CMD build .` y `R CMD check --as-cran <tarball>`.
2. **El contrato remoto puede cambiar.** Los catalogos de endpoints y
   dimensiones estan codificados en el paquete. Antes de una liberacion deben
   contrastarse con la documentacion publica vigente del SNIIV y registrarse
   la fecha de verificacion.

### Prioridad media

1. **Cobertura desigual de wrappers.** Las pruebas verifican la delegacion de
   financiamiento e inventario, pero no la de los otros seis wrappers.
2. **Casos limite del parser.** Conviene cubrir respuestas con un objeto
   `data`, valores nulos, BOM, nombres con acentos y errores HTTP simulados.
3. **Parametros operativos.** `timeout_seconds` se entrega directamente a
   `httr2`; falta documentar y probar el comportamiento ante valores invalidos.

### Prioridad baja

1. **Instalacion local dependiente de una ruta de ejemplo.** La ruta de
   Windows del README es ilustrativa; a futuro puede reemplazarse por una
   instruccion neutral o por la URL del repositorio cuando exista una fuente
   publica estable.
2. **Consistencia editorial.** Una pasada posterior puede homologar acentos y
   terminologia en mensajes, README, ayuda y vignette sin cambiar la API.

## Siguiente incremento recomendado

Para mantener avances pequenos y verificables, el siguiente cambio deberia
concentrarse solamente en la calidad del modulo SNIIV:

1. ejecutar `R CMD build .` y `R CMD check --as-cran` en un entorno con R;
2. corregir los errores o advertencias reproducibles encontrados;
3. completar las pruebas unitarias de los seis wrappers restantes;
4. agregar casos offline del parser antes de considerar una prueba en vivo.

## Criterio de salida de esta revision

La revision inicial se considera atendida cuando:

- el alcance vigente y el alcance futuro estan diferenciados;
- el estado del paquete y sus riesgos estan registrados;
- existe un siguiente incremento acotado al SNIIV;
- cualquier integracion con otras APIs permanece solo como posibilidad futura.
