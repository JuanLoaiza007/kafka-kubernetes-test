from fastapi import FastAPI, HTTPException
from confluent_kafka import Producer
import os
import uvicorn

# Variables de entorno
kafka_address = os.getenv("KAFKA_ADDRESS")
topic_name = os.getenv("TOPIC_NAME")
fixed_message = "Konnichiwa, kore wa Samuel no purodyūsā desu!"

print(f"kafka address is: {kafka_address}")
print(f"topic is: {topic_name}")

# Configuración de Kafka Producer
producer_config = {
    "bootstrap.servers": kafka_address,
}
producer = Producer(producer_config)

# Crear la aplicación FastAPI
app = FastAPI()

# Endpoint para producir mensajes
@app.post("/produce/samuel")
async def produce_message():
    try:
        # Enviar mensaje al topic de Kafka
        producer.produce(topic_name, value=fixed_message)
        producer.flush()
        return {"status": "Message sent", "message": fixed_message}
    except Exception as e:
        raise HTTPException(status_code=500, detail={"status": "Error", "error": str(e)})

# Ejecutar la aplicación
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=5001)
