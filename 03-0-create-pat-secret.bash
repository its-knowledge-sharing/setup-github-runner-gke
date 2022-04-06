#!/bin/bash

source .env

kubectl create ns ${NS1}

SECRET=controller-manager

cat << EOF | kubectl apply -n ${NS1} -f - 
apiVersion: v1
data:
  github_token: "$(echo -n ${GITHUB_TOKEN} | base64 -w0)"
kind: Secret
metadata:
  name: ${SECRET}
type: Opaque
EOF
