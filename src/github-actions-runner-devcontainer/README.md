
# GitHub Actions Runner (github-actions-runner)

A devcontainer that spins up and runs a self hosted GitHub Actions runner inside a Codespace attached to the current repository.

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| imageVariant | Debian version (use bullseye on local arm64/Apple Silicon): | string | bullseye |
| runnerVersion | Choose version of GitHub Runner to Install | string | 2.300.2 |
| Terraform | Install terraform? | boolean | true |
| gitLfs | Install git-lfs? | boolean | true |
| azureCLI | Install Azure CLI? | boolean | true |
| PowerShell | Install PowerShell? | boolean | true |



---

_Note: This file was auto-generated from the [devcontainer-template.json](https://github.com/Pwd9000-ML/devcontainer-templates/blob/main/src/github-actions-runner-devcontainer/devcontainer-template.json).  Add additional notes to a `NOTES.md`._
