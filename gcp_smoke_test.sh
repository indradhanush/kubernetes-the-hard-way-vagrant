#!/bin/bash

set -xeu


kubectl create secret generic kubernetes-the-hard-way \
        --from-literal="mykey=mydata"

gcloud compute ssh controller-0 \
       --command "ETCDCTL_API=3 etcdctl get /registry/secrets/default/kubernetes-the-hard-way | hexdump -C"


kubectl run nginx --image=nginx

sleep 10

kubectl get pods -l run=nginx


POD_NAME=$(kubectl get pods -l run=nginx -o jsonpath="{.items[0].metadata.name}")

kubectl port-forward $POD_NAME 8080:80
