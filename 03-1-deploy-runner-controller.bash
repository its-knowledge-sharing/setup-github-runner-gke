#!/bin/bash

source .env

kubectl create ns ${NS1}

helm repo add runner-controller https://actions-runner-controller.github.io/actions-runner-controller

helm template runner-controller runner-controller/actions-runner-controller \
    -f runner-controller/controller.yaml \
    --version 0.17.2 \
    --namespace ${NS1} > tmp-runner-controller.yaml
#    --include-crds \

kubectl apply -n ${NS1} -f tmp-runner-controller.yaml
