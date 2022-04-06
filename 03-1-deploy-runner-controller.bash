#!/bin/bash

source .env

APP_VERSION=v0.22.2
HELM_VERSION=0.17.2

CRD_URL=https://raw.githubusercontent.com/actions-runner-controller/actions-runner-controller/${APP_VERSION}/charts/actions-runner-controller/crds/
kubectl create ns ${NS1}

# Explicitly deploy CRDs because of file size issue
kubectl create -n ${NS1} -f ${CRD_URL}/actions.summerwind.dev_horizontalrunnerautoscalers.yaml
kubectl create -n ${NS1} -f ${CRD_URL}/actions.summerwind.dev_runnerdeployments.yaml
kubectl create -n ${NS1} -f ${CRD_URL}/actions.summerwind.dev_runnerreplicasets.yaml
kubectl create -n ${NS1} -f ${CRD_URL}/actions.summerwind.dev_runners.yaml
kubectl create -n ${NS1} -f ${CRD_URL}/actions.summerwind.dev_runnersets.yaml


helm repo add runner-controller https://actions-runner-controller.github.io/actions-runner-controller

helm template runner-controller runner-controller/actions-runner-controller \
    -f runner-controller/controller.yaml \
    --version ${HELM_VERSION} \
    --namespace ${NS1} > tmp-runner-controller.yaml
#    --include-crds \

kubectl apply -n ${NS1} -f tmp-runner-controller.yaml
