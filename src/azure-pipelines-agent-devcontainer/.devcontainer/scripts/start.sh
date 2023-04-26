#!/bin/bash

ADO_ORG=$ADO_ORG
ADO_PAT=$ADO_PAT
ADO_POOL_NAME=$ADO_POOL_NAME

HOSTNAME=$(hostname)
AGENT_SUFFIX="ADO-agent"
AGENT_NAME="${HOSTNAME}-${AGENT_SUFFIX}"
ADO_URL="https://dev.azure.com/${ADO_ORG}"
USER_NAME_LABEL=$( (git config --get user.name) | sed -e 's/ //g')
#REPO_NAME_LABEL="$GH_REPOSITORY"

# !!!Ignore sensitive tokens from capabilities!!!
export VSO_AGENT_IGNORE=ADO_PAT,GH_TOKEN,GITHUB_CODESPACE_TOKEN,GITHUB_TOKEN

/home/vscode/azure-pipelines/config.sh --unattended \
--agent "${AGENT_NAME}" \
--url "${ADO_URL}" \
--auth PAT \
--token "${ADO_PAT}" \
--pool "${ADO_POOL_NAME}" \
--acceptTeeEula

/home/vscode/azure-pipelines/run.sh