#!/bin/bash

set -xeu

gcp/network.sh
gcp/instances.sh
gcp/certificates.sh
gcp/k8s_config.sh
gcp/encryption.sh
gcp/bootstrap_controllers.sh
gcp/lb.sh
gcp/bootstrap_workers.sh
gcp/kubectl.sh
gcp/pod_networking.sh
gcp/dns.sh
