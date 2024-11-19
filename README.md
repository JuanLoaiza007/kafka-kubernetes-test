# Kafka on Kubernetes

This repository contains the code to deploy a Kafka cluster on Kubernetes using Strimzi.

## Requirements

- kubectl (tested with v1.29.2)
- k3d (tested with v5.7.4)

## Installation

First, whe need to create a cluster with k3d, create a namespace for kafka and apply the strimzi operator.

```bash
k3d cluster create my-cluster --agents 1
kubectl create namespace kafka
kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka
```

It's important to wait for the operator to be ready, you can check the status of the operator with:

```bash
# Check the status of the operator
kubectl get pod -n kafka
# Check logs
kubectl logs deployment/strimzi-cluster-operator -n kafka -f
```

Once the operator is ready, we can create the Kafka cluster with the local deployment.

```bash
kubectl apply -f ./kafka/kafka-deployment.yaml
```

And wait for the cluster to be ready.

```bash
kubectl -n kafka get all
```

## Usage

When the cluster is running you can send messages and the topic will be created automatically.

### Run a producer

Run a producer in a shell:

```bash
kubectl -n kafka run kafka-producer -ti --image=quay.io/strimzi/kafka:0.44.0-kafka-3.8.0 --rm=true --restart=Never -- bin/kafka-console-producer.sh --bootstrap-server my-cluster-kafka-bootstrap:9092 --topic my-topic
```

To delete the kafka producer use:

```bash
kubectl -n kafka delete pod kafka-producer
```

### Run a consumer

Run a producer in a shell:

```bash
kubectl -n kafka run kafka-consumer -ti --image=quay.io/strimzi/kafka:0.44.0-kafka-3.8.0 --rm=true --restart=Never -- bin/kafka-console-consumer.sh --bootstrap-server my-cluster-kafka-bootstrap:9092 --topic my-topic --from-beginning
```

To delete the kafka consumer use:

```bash
kubectl -n kafka delete pod kafka-consumer
```
