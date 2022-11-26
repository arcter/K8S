#!/usr/bin/env bash

[[ ! -d .venv ]] && python3 -m venv .venv
source .venv/bin/activate

pip3 install ansible ansible-lint

ansible-galaxy install --force -r requirements.galaxy.yaml

# to stay in our comfy virtualenv
exec "${SHELL:bash}"
