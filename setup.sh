#!/bin/bash

# Create a cluster with k3d
k3d cluster create my-cluster -p "8000:30000@agent:1" -p "8001:30100@agent:2" -p "8003:30300@agent:4" -p "8004:30400@agent:5" -p"8005:30500@agent6" -p "8006:30600@agent:7" --agents 8

kubectl label nodes k3d-my-cluster-server-0
kubectl label nodes k3d-my-cluster-agent-0 strimzi.io/kind=Kafka
kubectl label nodes k3d-my-cluster-agent-1 producer=juan
kubectl label nodes k3d-my-cluster-agent-2 producer=herrera
kubectl label nodes k3d-my-cluster-agent-4 producer=sebastian
kubectl label nodes k3d-my-cluster-agent-5 producer=julian
kubectl label nodes k3d-my-cluster-agent-6 producer=john
kubectl label nodes k3d-my-cluster-agent-7 producer=duque

# Create a namespace for kafka
kubectl create namespace kafka

# Apply strimzi operator
kubectl create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka

# ========= WAIT =========
kubectl wait --for=condition=Available deployment/strimzi-cluster-operator -n kafka --timeout=120s
# Check the status of the operator
# kubectl get pod -n kafka
# Check logs
# kubectl logs deployment/strimzi-cluster-operator -n kafka -f

# Create Kakfa cluster
kubectl apply -f ./kafka/kafka-deployment.yaml
# Tumbar
# kubectl delete -f ./kafka/kafka-deployment.yaml

# ========= WAIT =========
sleep 30
kubectl wait --for=condition=Ready pods -l strimzi.io/kind=Kafka -n kafka --timeout=300s
# Check the status of the operator
# kubectl -n kafka get all 

kubectl apply -f ./kafka/kafka-secret.yaml

# Deploy producers
kubectl apply -f ./producer-juan/producer-juan-deployment.yaml
# kubectl delete deployment -n "kafka" producer-juan-deployment

kubectl apply -f ./producer-herrera/producer-herrera-deployment.yaml
# kubectl delete deployment -n "kafka"  producer-herrera-deployment

kubectl apply -f ./producer-sebastian/producer-sebastian-deployment.yaml
#kubectl delete deployment -n "kafka"  producer-sebastian-deployment

kubectl apply -f ./producer-julian/producer-julian-deployment.yaml
#kubectl delete deployment -n "kafka"  producer-julian-deployment

kubectl apply -f ./producer-john/producer-john-deployment.yaml
#kubectl delete deployment -n "kafka"  producer-john-deployment

kubectl apply -f ./producer-duque/producer-duque-deployment.yaml
# kubectl delete deployment -n "kafka"  producer-duque-deployment


