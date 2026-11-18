# Toma de decisiones basada en datos

Materiales del curso de **Business Intelligence y toma de decisiones basada en datos**: presentaciones y notebooks con ejemplos en R y Python.

**Autor:** Fernando Salcedo Mejía Eco, Ms — Escuela de Transformación Digital (ETD), UTB · Programa de Ciencia de Datos

## 1. Business Analytics

| Material | Tipo |
|---|---|
| [Introducción a la Visualización y Analítica de Datos en Negocios](https://fersalme.github.io/toma-decisiones-datos/01_business_analytics/business_analytics.html) | Presentación |

## 2. Evaluación de alternativas

| Material | Tipo |
|---|---|
| [Evaluación de Alternativas en Business Intelligence](https://fersalme.github.io/toma-decisiones-datos/02_evaluacion_bi/evaluacion_bi.html) | Presentación |

Análisis de sensibilidad (diagrama de tornado) y simulación de Monte Carlo.

## 3. Análisis predictivo

| Material | Tipo |
|---|---|
| [Análisis Predictivo en Business Intelligence](https://fersalme.github.io/toma-decisiones-datos/03_prediccion_bi/prediccion_bi.html) | Presentación |

Notebooks de ejemplo, por tema y lenguaje:

| Tema | Caso de estudio | R | Python |
|---|---|---|---|
| **Regresión** | Estimación y pronóstico de la demanda | [Regresión en R](https://fersalme.github.io/toma-decisiones-datos/03_prediccion_bi/prediccion_bi_regresion_R.html) | [Regresión en Python](https://fersalme.github.io/toma-decisiones-datos/03_prediccion_bi/prediccion_bi_regresion_python.html) |
| **Clasificación** | Fuga de clientes (churn) | [Clasificación en R](https://fersalme.github.io/toma-decisiones-datos/03_prediccion_bi/prediccion_bi_clasificacion_R.html) | [Clasificación en Python](https://fersalme.github.io/toma-decisiones-datos/03_prediccion_bi/prediccion_bi_clasificacion_python.html) |
| **Agrupamiento (cluster)** | Segmentación de clientes (RFM) | [Segmentación en R](https://fersalme.github.io/toma-decisiones-datos/03_prediccion_bi/prediccion_bi_cluster_R.html) | [Segmentación en Python](https://fersalme.github.io/toma-decisiones-datos/03_prediccion_bi/prediccion_bi_cluster_python.html) |

Los datos de los notebooks son simulados y están en [`03_prediccion_bi/datos/`](03_prediccion_bi/datos/). Se generan con el script [`simular_datos.R`](03_prediccion_bi/simular_datos.R).

## Cómo generar los HTML

Cada presentación y notebook es un archivo [Quarto](https://quarto.org/) (`.qmd`). Para generar su HTML, desde la carpeta del archivo:

```bash
quarto render nombre_del_archivo.qmd
```
