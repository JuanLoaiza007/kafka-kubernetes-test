Use the local kafka-broker to test your producer.

### Get inside the broker

```bash
docker exec -it kafka-broker-1 bash
```

### Create a topic

```bash
kafka-topics --bootstrap-server kafka-broker-1:9092 --create --topic my-topic
```

#### Check that topic was created

```bash
kafka-topics --bootstrap-server localhost:9092 --list
```

### Produce a message

```bash
kafka-console-producer --bootstrap-server kafka-broker-1:9092 --topic my-topic
```

```bash
kafka-console-consumer --bootstrap-server kafka-broker-1:9092 --topic my-topic --from-beginning
```
