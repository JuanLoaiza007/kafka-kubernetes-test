#!/bin/bash

# Create a cluster with k3d
k3d cluster create my-cluster --agents 1 \
  -p "8000:30090@agent:0"

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
# Revisar estado
# kubectl -n kafka get all

# ========= WAIT =========
# Check the status of the operator
# kubectl -n kafka get all 

# Deploy producers
kubectl apply -f ./producer-juan/producer-juan-deployment.yaml
