#!/bin/bash

set -xue

gcloud compute firewall-rules create prometheus-external \
       --allow tcp:30900,tcp:30902,tcp:30903 \
       --network kubernetes-the-hard-way \
       --source-ranges 0.0.0.0/0
