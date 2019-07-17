#!/bin/sh
az aks get-credentials -n ${CLUSTER_NAME} -g ${RESOURCE_GROUP} -a -f /tmp/aksk8scfg
export KUBECONFIG=/tmp/aksk8scfg

# Create the namespace for cert-manager
kubectl create namespace cert-manager

# Label the cert-manager namespace to disable resource validation
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

# Install the CustomResourceDefinition resources separately
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.8/deploy/manifests/00-crds.yaml

rm -f /tmp/aksk8scfg

