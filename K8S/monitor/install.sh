#!/bin/env bash

helm install monitor prometheus-community/kube-prometheus-stack --values monitor-values.yaml --create-namespace --namespace monitor
