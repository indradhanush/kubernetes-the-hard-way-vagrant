#!/bin/bash

set -xeu

# Setup load balancer for k8s API server

gcloud compute target-pools create kubernetes-target-pool

gcloud compute target-pools add-instances kubernetes-target-pool \
  --instances controller-0,controller-1,controller-2

KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe kubernetes-the-hard-way \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')

gcloud compute forwarding-rules create kubernetes-forwarding-rule \
  --address ${KUBERNETES_PUBLIC_ADDRESS} \
  --ports 6443 \
  --region $(gcloud config get-value compute/region) \
  --target-pool kubernetes-target-pool

cd gcp/certificates
curl --cacert ca.pem https://${KUBERNETES_PUBLIC_ADDRESS}:6443/version
