#!/bin/bash

set -xue

# VPC setup

gcloud compute networks create kubernetes-the-hard-way --subnet-mode custom

gcloud compute networks subnets create kubernetes \
  --network kubernetes-the-hard-way \
  --range 10.240.0.0/24

# Firewall rules

gcloud compute firewall-rules create kubernetes-the-hard-way-allow-internal \
  --allow tcp,udp,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 10.240.0.0/24,10.200.0.0/16

gcloud compute firewall-rules create kubernetes-the-hard-way-allow-external \
  --allow tcp:22,tcp:6443,icmp \
  --network kubernetes-the-hard-way \
  --source-ranges 0.0.0.0/0

gcloud compute firewall-rules list --filter "network: kubernetes-the-hard-way"


# K8s public IP address

gcloud compute addresses create kubernetes-the-hard-way \
       --region $(gcloud config get-value compute/region)

gcloud compute addresses list --filter="name=('kubernetes-the-hard-way')"
