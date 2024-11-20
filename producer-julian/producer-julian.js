require('dotenv').config();
const express = require('express');
const { Kafka } = require('kafkajs');

const app = express();
const port = 4000;

// Variables de entorno
const kafkaAddress = process.env.KAFKA_ADDRESS;
const topicName = process.env.TOPIC_NAME;

console.log(`Kafka address is: ${kafkaAddress}`);
console.log(`Topic is: ${topicName}`);

// Configuración del cliente Kafka
const kafka = new Kafka({
  clientId: 'http-producer',
  brokers: [kafkaAddress],
});

// Creación del productor
const producer = kafka.producer();

// Middleware para manejar JSON
app.use(express.json());

// Ruta para enviar mensajes
app.post('/producer-julian', async (req, res) => {
  const { message } = req.body;

  if (!message) {
    return res.status(400).json({ error: 'Message is required' });
  }

  try {
    await producer.connect();
    console.log('Producer connected.');

    await producer.send({
      topic: topicName,
      messages: [{ value: message }],
    });

    console.log('Message sent:', message);
    res.status(200).json({ status: 'Message sent', message });
  } catch (error) {
    console.error('Error sending message:', error);
    res.status(500).json({ status: 'Error', error: error.message });
  } finally {
    await producer.disconnect();
  }
});

// Iniciar el servidor
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
