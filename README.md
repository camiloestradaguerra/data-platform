# Plataforma de Datos – Cooperativa Financiera

## 1. Propósito del proyecto

Este proyecto define una **plataforma de datos** para una cooperativa financiera cuyo objetivo es:

- Transformar datos operativos y transaccionales en **información confiable**.
- Aplicar reglas de negocio claras y auditables.
- Generar **visualizaciones e indicadores** para apoyar la toma de decisiones.
- Implementar **buenas prácticas de DataOps** desde el inicio.

El enfoque está centrado en **Python como motor principal**, con capacidad de escalar hacia BI, web y analítica avanzada.

---

## 2. Visión general del flujo de datos (arquitectura lógica)

El flujo completo sigue esta lógica conceptual:

1. **Fuentes de datos**
   - Sistemas operativos (ej. Virtualcoop) entregan datos en formato JSON.
   - Bases de datos transaccionales (Oracle) entregan datos vía SQL.

2. **Conocimiento y reglas de negocio**
   - Definiciones funcionales (qué es mora, cliente activo, colocación, etc.).
   - Estas reglas no son datos, son *criterios* que gobiernan los cálculos.

3. **Lógica central (Python)**
   - Lectura de JSON y consultas SQL.
   - Limpieza y transformación de datos.
   - Aplicación de reglas de negocio.
   - Cálculo de métricas financieras.

4. **Histórico (flujo offline)**
   - Persistencia de resultados procesados.
   - Permite auditoría, reprocesos y análisis temporal.

5. **Metadata y métricas**
   - Estructuras que describen:
     - volúmenes
     - calidad
     - fechas de proceso
     - indicadores derivados

6. **Visualización y consumo**
   - Streamlit (Python).
   - Power BI.
   - Interfaces web responsivas.

Este flujo combina **procesamiento online** (datos recientes) y **offline** (histórico), lo cual es ideal para contextos financieros.

---

## 3. Entorno de desarrollo con `uv`

### 3.1 ¿Por qué `uv`?

`uv` es un gestor moderno de entornos y dependencias para Python. Permite:

- Ambientes virtuales rápidos.
- Dependencias reproducibles.
- Control mediante `pyproject.toml` y `uv.lock`.

Esto elimina inconsistencias entre equipos y ambientes.

### 3.2 Inicialización del proyecto

```bash
uv init
uv venv
```

Activación del entorno:

- Linux / Mac:
```bash
source .venv/bin/activate
```

- Windows:
```powershell
.venv\Scripts\activate
```

### 3.3 Instalación de dependencias

```bash
uv add pandas numpy matplotlib seaborn plotly streamlit sqlalchemy
```

Archivos clave:

- `pyproject.toml` → definición del proyecto.
- `uv.lock` → versionado exacto de dependencias.

---

## 4. Estructura recomendada del proyecto

```text
cooperativa-data-platform/
│
├── .venv/
├── pyproject.toml
├── uv.lock
├── Makefile
│
├── src/
│   ├── ingest/        # Ingesta de JSON y SQL
│   ├── transform/     # Transformaciones de datos
│   ├── validate/      # Reglas de calidad y negocio
│   └── store/         # Persistencia histórica
│
├── app/
│   └── dashboard.py   # Aplicación Streamlit
│
├── data/
│   ├── raw/
│   ├── processed/
│   └── historical/
│
└── README.md
```

---

## 5. Automatización del flujo (Makefile)

El proyecto utiliza un `Makefile` como **orquestador simple** del pipeline:

- `make ingest` → extracción de datos.
- `make transform` → transformación central.
- `make validate` → control de calidad.
- `make store` → guardado histórico.
- `make visualize` → visualización.
- `make run-all` → ejecución completa.

Esto garantiza **repetibilidad** y **estandarización**.

---

## 6. Aplicación de DataOps al proyecto

### 6.1 ¿Qué es DataOps en este contexto?

DataOps es la práctica de garantizar que los datos:

- Lleguen a tiempo.
- Sean confiables.
- Sean auditables.
- Se procesen de forma repetible.

En una cooperativa financiera, DataOps **reduce riesgo operativo y reputacional**.

---

### 6.2 DataOps aplicado por etapas

#### Etapa 1 – Reproducibilidad

- Ambientes controlados (`uv`).
- Ejecución estándar (`Makefile`).

#### Etapa 2 – Calidad de datos

- Validaciones automáticas en Python.
- Fallos bloquean visualizaciones.

#### Etapa 3 – Versionado de datos

- Histórico por fecha de proceso.
- Capacidad de auditoría y reprocesos.

#### Etapa 4 – Observabilidad

- Métricas de volumen, nulos, outliers.
- Metadata visible y medible.

#### Etapa 5 – Data Products

- Indicadores con:
  - definición clara
  - responsable
  - frecuencia
  - fuente

---

## 7. Visualización como producto de datos

Las visualizaciones no son “gráficos sueltos”, sino **productos de datos**:

Ejemplos:
- Termómetro de mora.
- Indicador de colocación.
- Semáforo de desempeño por oficina.

Cada uno se construye sobre datos validados, versionados y observables.

---

## 8. Principios clave del proyecto

- Python como lenguaje central.
- Reglas de negocio explícitas.
- Automatización antes que ejecución manual.
- Datos antes que gráficos.
- Confianza antes que velocidad.

---

## 9. Mensaje final

Este proyecto no es solo un pipeline técnico:

> Es una **plataforma de decisiones basada en datos**, diseñada con mentalidad DataOps desde el inicio.

Permite que la cooperativa pase de *ver datos* a **confiar en ellos**.

