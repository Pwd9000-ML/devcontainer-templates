#!/bin/bash
cd $(dirname "$0")
source test-utils.sh

# Template specific tests
check "github runner version" /home/vscode/actions-runner/run.sh --version

# Report result
reportResults
