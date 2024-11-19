#!/bin/bash

# Create a cluster with k3d
k3d cluster create my-cluster --agents 1

# Create a namespace for kafka
kubectl create namespace kafka

# Apply strimzi operator
kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka

# ========= WAIT =========
# Check the status of the operator
# kubectl get pod -n kafka
# Check logs
# kubectl logs deployment/strimzi-cluster-operator -n kafka -f

# Create Kakfa cluster
kubectl apply -f ./kafka/kafka-deployment.yaml
# Tumbar
# kubectl delete -f ./kafka/kafka-deployment.yaml

# ========= WAIT =========
# Check the status of the operator
# kubectl -n kafka get all 

# Deploy producers
kubectl apply -f ./producer-juan/producer-juan-deployment.yaml
# kubectl delete -f ./producer-juan/producer-juan-deployment.yaml

kubectl port-forward deployment/producer-juan-deployment 8000:8000 -n kafka
