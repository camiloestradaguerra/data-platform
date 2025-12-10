# ===============================
# Cooperativa Financiera - Data Pipeline
# ===============================

.PHONY: help ingest transform validate store visualize run-all clean

# Variables generales
PYTHON=python3
DATA_DIR=data
RAW_DIR=$(DATA_DIR)/raw
PROCESSED_DIR=$(DATA_DIR)/processed
HIST_DIR=$(DATA_DIR)/historical
REPORTS_DIR=reports

help:
	@echo "Pipeline Cooperativa Financiera"
	@echo "make ingest       -> Extraer datos (JSON + SQL)"
	@echo "make transform    -> Transformar datos (Python)"
	@echo "make validate     -> Validar reglas de negocio"
	@echo "make store        -> Guardar histórico"
	@echo "make visualize    -> Generar visualizaciones"
	@echo "make run-all      -> Ejecutar todo el pipeline"
	@echo "make clean        -> Limpiar archivos temporales"

# -------------------------------
# 1. Ingesta de datos
# -------------------------------
ingest:
	@echo "🔹 Ingestando datos desde Virtualcoop (JSON) y Oracle (SQL)..."
	$(PYTHON) src/ingest_json_virtualcoop.py --output $(RAW_DIR)
	$(PYTHON) src/ingest_sql_oracle.py --output $(RAW_DIR)

# -------------------------------
# 2. Transformación
# -------------------------------
transform:
	@echo "🧠 Transformando datos con lógica de negocio..."
	$(PYTHON) src/transform_data.py \
		--input $(RAW_DIR) \
		--output $(PROCESSED_DIR)

# -------------------------------
# 3. Validación de reglas
# -------------------------------
validate:
	@echo "✅ Validando métricas según definiciones de negocio..."
	$(PYTHON) src/validate_business_rules.py \
		--input $(PROCESSED_DIR)

# -------------------------------
# 4. Persistencia histórica
# -------------------------------
store:
	@echo "🗄️ Guardando histórico..."
	$(PYTHON) src/store_historical.py \
		--input $(PROCESSED_DIR) \
		--output $(HIST_DIR)

# -------------------------------
# 5. Visualización
# -------------------------------
visualize:
	@echo "📊 Generando visualizaciones y metadata..."
	$(PYTHON) src/generate_metadata.py --input $(HIST_DIR)
	streamlit run app/dashboard.py

# -------------------------------
# Pipeline completo
# -------------------------------
run-all: ingest transform validate store visualize

# -------------------------------
# Limpieza
# -------------------------------
clean:
	@echo "🧹 Limpiando temporales..."
	rm -rf $(RAW_DIR)/*
	rm -rf $(PROCESSED_DIR)/*
