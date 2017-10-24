#!/bin/bash

set -xeu


for instance in controller-0 controller-1 controller-2; do

    gcloud compute scp gcp/remote/install_etcd.sh gcp/remote/k8s_controllers.sh ${instance}:~/

    # Setup etcd
    gcloud compute ssh ${instance} -- './install_etcd.sh'

    # Setup controllers
    gcloud compute ssh ${instance} -- './k8s_controllers.sh'
done

gcloud compute ssh controller-0 -- 'ETCDCTL_API=3 etcdctl member list'

# Setup RBAC
gcloud compute scp gcp/remote/rbac.sh controller-0:~/
gcloud compute ssh controller-0 -- './rbac.sh'




