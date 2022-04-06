#!/bin/bash

source .env

CRD_URL=https://raw.githubusercontent.com/actions-runner-controller/actions-runner-controller/v0.22.2/charts/actions-runner-controller/crds/
kubectl create ns ${NS1}


kubectl apply -n ${NS1} -f ${CRD_URL}/actions.summerwind.dev_horizontalrunnerautoscalers.yaml
kubectl apply -n ${NS1} -f ${CRD_URL}/actions.summerwind.dev_runnerdeployments.yaml
kubectl apply -n ${NS1} -f ${CRD_URL}/actions.summerwind.dev_runnerreplicasets.yaml
kubectl apply -n ${NS1} -f ${CRD_URL}/actions.summerwind.dev_runners.yaml
kubectl apply -n ${NS1} -f ${CRD_URL}/actions.summerwind.dev_runnersets.yaml


helm repo add runner-controller https://actions-runner-controller.github.io/actions-runner-controller

helm template runner-controller runner-controller/actions-runner-controller \
    -f runner-controller/controller.yaml \
    --version 0.17.2 \
    --namespace ${NS1} > tmp-runner-controller.yaml
#    --include-crds \

kubectl apply -n ${NS1} -f tmp-runner-controller.yaml
