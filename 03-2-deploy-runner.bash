#!/bin/bash

source .env

kubectl apply -n ${NS1} -f runner-controller/runner-enterprise.yaml
kubectl apply -n ${NS1} -f runner-controller/runner-organize.yaml
