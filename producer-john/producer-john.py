from flask import Flask, jsonify
from confluent_kafka import Producer
import os

kafka_address = os.getenv("KAFKA_ADDRESS")
topic_name = os.getenv("TOPIC_NAME")
fixed_message = "Hola, este es el productor de John!"

print(f"kafka address is: {kafka_address}")
print(f"topic is: {topic_name}")

app = Flask(__name__)

producer_config = {
    "bootstrap.servers": kafka_address,
}
producer = Producer(producer_config)


@app.route("/produce/john", methods=["POST"])
def produce_message():
    try:
        producer.produce(topic_name, value=fixed_message)
        producer.flush()
        return jsonify({"status": "Message sent", "message": fixed_message})
    except Exception as e:
        return jsonify({"status": "Error", "error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
