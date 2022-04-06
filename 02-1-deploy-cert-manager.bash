#!/bin/bash

source .env

NS2=cert-manager
kubectl create ns ${NS2}

helm repo add cert-manager https://charts.jetstack.io/

helm template cert-manager cert-manager/cert-manager \
    -f cert-manager/cert-manager.yaml \
    --version 1.7.1 \
    --namespace ${NS2} > tmp-cert-manager.yaml

kubectl apply -n ${NS2} -f tmp-cert-manager.yaml
