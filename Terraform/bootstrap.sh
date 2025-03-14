#!/bin/bash

BASEDIR=$(dirname "$0")

if ! [ -f "$BASEDIR/secret/login.sh" ]; then
    echo "Please create the login.sh file!"
    exit 0
fi
source $BASEDIR/secret/login.sh

if [ -d "$BASEDIR/.terraform" ]; then
    echo ".terraform folder exists."
else
    terraform init 
fi
echo "Environment has been set up."
# to stay in our comfy virtualenv
exec "${SHELL:bash}"
