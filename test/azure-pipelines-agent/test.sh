#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "ado agent version" /home/vscode/azure-pipelines/run.sh --version

# Report result
reportResults
