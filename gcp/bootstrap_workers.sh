#!/bin/bash

set -xeu

for instance in worker-0 worker-1 worker-2; do
    gcloud compute scp gcp/remote/setup_worker.sh ${instance}:~/
    gcloud compute ssh ${instance} -- './setup_worker.sh'
done

# Verify

gcloud compute ssh controller-0 -- 'kubectl get nodes'
