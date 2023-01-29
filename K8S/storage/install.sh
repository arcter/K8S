#!/bin/env bash

helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-provider nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --set nfs.server=192.168.253.1  --set nfs.path=/NFS --create-namespace --namespace nfs