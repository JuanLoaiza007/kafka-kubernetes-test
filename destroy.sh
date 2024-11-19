#!/bin/bash

kubectl delete deployments --all
kubectl delete services --all

k3d cluster delete my-cluster