#!/bin/bash

set -xeu

kubectl create -f https://storage.googleapis.com/kubernetes-the-hard-way/kube-dns.yaml

# Give time for the container to run
sleep 15

kubectl get pods -l k8s-app=kube-dns -n kube-system

# Verify

kubectl run busybox --image=busybox --command -- sleep 3600

sleep 10

kubectl get pods -l run=busybox

POD_NAME=$(kubectl get pods -l run=busybox -o jsonpath="{.items[0].metadata.name}")

kubectl exec -ti $POD_NAME -- nslookup kubernetes
