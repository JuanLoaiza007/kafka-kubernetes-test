FROM python:3.11-slim

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar los archivos del proyecto al contenedor
COPY requirements.txt .

# Instalar las dependencias necesarias
RUN pip install --no-cache-dir -r requirements.txt

COPY producer-samuel.py .

# Exponer el puerto que utilizará la aplicación FastAPI
EXPOSE 5001

# Comando para ejecutar el servidor Uvicorn
CMD ["uvicorn", "producer-samuel:app", "--host", "0.0.0.0", "--port", "5001"]