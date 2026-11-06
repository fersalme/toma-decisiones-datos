# =============================================================================
# Simulación de los datos de ejemplo: Análisis Predictivo en Business Intelligence
# -----------------------------------------------------------------------------
# Genera los tres conjuntos de datos usados en la presentación y en los
# notebooks de ejemplo (R y Python) y los guarda en la carpeta `datos/`:
#
#   datos/ventas_electronica.csv  Caso 1. Estimación de la demanda
#   datos/telco_churn.csv         Caso 2. Fuga de clientes (churn)
#   datos/retail_rfm.csv          Caso 3. Segmentación de clientes (RFM)
#
# Ejecutar desde la raíz del proyecto:  Rscript simular_datos.R
# =============================================================================

library(tidyverse)

dir.create("datos", showWarnings = FALSE)

# -----------------------------------------------------------------------------
# Caso 1. Ventas mensuales de cinco productos de electrónica (2016-2023)
# -----------------------------------------------------------------------------
set.seed(2026)

productos <- tibble(
  producto = c("Smartphone", "Laptop", "Audífonos", "Smartwatch", "Tablet"),
  precio_base = c(800, 1200, 80, 250, 450),
  ventas_base = c(2000, 800, 5000, 1500, 1000),
  elasticidad = c(-1.8, -0.6, -2.3, -1.2, -0.9) # desconocida para el analista
)

ventas <- productos |>
  crossing(
    fecha = seq(as.Date("2016-01-01"), as.Date("2023-12-01"), by = "month")
  ) |>
  mutate(
    precio = round(precio_base * exp(rnorm(n(), 0, 0.12)), 2),
    cantidad = round(
      ventas_base *
        (precio / precio_base)^elasticidad *
        exp(rnorm(n(), 0, 0.15))
    )
  ) |>
  select(producto, fecha, precio, cantidad)

write_csv(ventas, "datos/ventas_electronica.csv")

# -----------------------------------------------------------------------------
# Caso 2. Clientes de una empresa de telecomunicaciones
# -----------------------------------------------------------------------------
set.seed(2026)
n <- 5000

telco <- tibble(
  antiguedad = sample(1:72, n, replace = TRUE),
  cargo_mensual = round(pmin(pmax(rnorm(n, 70, 25), 20), 150), 1),
  contrato = sample(
    c("Mensual", "Anual", "Bianual"),
    n,
    replace = TRUE,
    prob = c(0.55, 0.25, 0.20)
  ),
  llamadas_soporte = rpois(n, 1.5),
  pago_electronico = rbinom(n, 1, 0.4)
)

# Proceso generador de la fuga (desconocido para el analista)
z <- with(
  telco,
  -0.6 -
    0.04 * antiguedad +
    0.02 * (cargo_mensual - 70) +
    0.45 * llamadas_soporte -
    1.2 * (contrato == "Anual") -
    2.0 * (contrato == "Bianual") +
    0.5 * pago_electronico +
    1.2 * (antiguedad < 12 & cargo_mensual > 90)
)
telco$churn <- rbinom(n, 1, plogis(z)) # 1 = Fuga, 0 = Permanece

# Partición estratificada 70 % / 30 %: se guarda en los datos para que R y
# Python entrenen y evalúen los modelos con exactamente los mismos clientes
set.seed(2026)
telco <- telco |>
  mutate(id_cliente = row_number(), .before = 1) |>
  group_by(churn) |>
  mutate(
    conjunto = if_else(
      row_number() %in% sample(n(), round(0.7 * n())),
      "entrenamiento",
      "prueba"
    )
  ) |>
  ungroup()

write_csv(telco, "datos/telco_churn.csv")

# -----------------------------------------------------------------------------
# Caso 3. Comportamiento de compra de clientes de retail (RFM)
# -----------------------------------------------------------------------------
set.seed(2026)

# Perfiles latentes (desconocidos para el analista)
perfiles <- tibble(
  n = c(300, 700, 400, 600),
  rec = c(10, 35, 70, 220),
  freq = c(24, 12, 4, 2),
  ticket = c(120, 60, 180, 40)
)

retail <- perfiles |>
  pmap(\(n, rec, freq, ticket) {
    tibble(
      recencia = round(pmin(pmax(rnorm(n, rec, rec * 0.35), 1), 365)),
      frecuencia = rpois(n, freq) + 1,
      ticket_promedio = round(pmax(rnorm(n, ticket, ticket * 0.2), 5), 1)
    )
  }) |>
  list_rbind() |>
  slice_sample(prop = 1) |> # mezclar las filas: el orden no revela el perfil
  mutate(id_cliente = row_number(), .before = 1)

write_csv(retail, "datos/retail_rfm.csv")

# -----------------------------------------------------------------------------
cat("Datos guardados en la carpeta datos/:\n")
cat(sprintf("  ventas_electronica.csv  %5d filas\n", nrow(ventas)))
cat(sprintf("  telco_churn.csv         %5d filas\n", nrow(telco)))
cat(sprintf("  retail_rfm.csv          %5d filas\n", nrow(retail)))
