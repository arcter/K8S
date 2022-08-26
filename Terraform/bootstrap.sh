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
    terraform init \
        -backend-config="address=https://git.sch.bme.hu/api/v4/projects/${GITLAB_PROJECT_ID}/terraform/state/${GITLAB_STATE_NAME}" \
        -backend-config="lock_address=https://git.sch.bme.hu/api/v4/projects/${GITLAB_PROJECT_ID}/terraform/state/${GITLAB_STATE_NAME}/lock" \
        -backend-config="unlock_address=https://git.sch.bme.hu/api/v4/projects/${GITLAB_PROJECT_ID}/terraform/state/${GITLAB_STATE_NAME}/lock" \
        -backend-config="username=${GITLAB_USER}" \
        -backend-config="password=${GITLAB_REPO_TOKEN}" \
        -backend-config="lock_method=POST" \
        -backend-config="unlock_method=DELETE" \
        -backend-config="retry_wait_min=5" \
        -reconfigure
fi
echo "Environment has been set up."
# to stay in our comfy virtualenv
exec "${SHELL:bash}"
