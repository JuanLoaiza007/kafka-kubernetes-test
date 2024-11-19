from fastapi import FastAPI
from pydantic import BaseModel
from confluent_kafka import Producer

kafka_address = "my-cluster-kafka-bootstrap.kafka.svc.cluster.local:9092"
topic_name = "my-topic"

print(f"kafka address is: {kafka_address}")
print(f"topic is: {topic_name}")

app = FastAPI()

producer_config = {
    "bootstrap.servers": kafka_address,
}
producer = Producer(producer_config)


class Message(BaseModel):
    message: str


@app.post("/produce")
async def produce_message(payload: Message):
    topic = topic_name
    try:
        producer.produce(topic, value=payload.message)
        producer.flush()  # Assert messages are sent
        return {"status": "Message sent", "message": payload.message}
    except Exception as e:
        return {"status": "Error", "error": str(e)}
