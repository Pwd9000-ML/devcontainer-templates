# GitHub Actions Runner Dev Container (Community)

## Summary

*Use and utelise your codespace compute power to also run a self hosted github actions runner. This devcontainer can be used as a codespace that will create and attach a `self-hosted github runner` inside of the codespace and attach/register the runner with a specified repository by using `secrets for codespaces` as parameter values:*

![image.png](https://raw.githubusercontent.com/Pwd9000-ML/blog-devto/main/posts/2022/GitHub-Codespaces-runner/assets/sec02.png)  

Runner registers to repository based on abve secrets and is labelled with the `repository name` and `git user.name (without spaces)`.  

![image.png](https://raw.githubusercontent.com/Pwd9000-ML/blog-devto/main/posts/2022/GitHub-Codespaces-runner/assets/label01.png)

| Metadata | Value |  
|----------|-------|
| *Contributors* | [Marcel Lupo](https://github.com/Pwd9000-ML) |
| *Categories* | Community, GitHub, Other |
| *Definition type* | Dockerfile |
| *Supported architecture(s)* | x86-64, arm64/aarch64 for `bullseye` based images |
| *Works in Codespaces* | Yes |
| *Container host OS support* | Linux |
| *Container OS* | Debian |
| *Languages, platforms* | Azure, HCL, PowerShell |

![image.png](https://raw.githubusercontent.com/Pwd9000-ML/blog-devto/main/posts/2022/GitHub-Codespaces-runner/assets/diag01.png)

## Using this definition

A devcontainer that spins up and runs a **self hosted GitHub Actions runner** inside the compute of a Codespace.

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| imageVariant | Debian version (use bullseye on local arm64/Apple Silicon): | string | bullseye |
| runnerVersion | Choose version of GitHub Runner to Install | string | 2.300.2 |

This template definition will install: [common-debian tools](https://github.com/devcontainers/features/tree/main/src/common-utils), [shellcheck](https://github.com/lukewiwa/features), [GitHub-CLI](https://github.com/devcontainers/features/tree/main/src/github-cli).

```json
"features": {
  "ghcr.io/devcontainers/features/common-utils:2": {},
  "ghcr.io/lukewiwa/features/shellcheck:0": {},
  "ghcr.io/devcontainers/features/github-cli:1": {},
}
```

## What scripts are included

1. **[start.sh](https://github.com/Pwd9000-ML/devcontainer-templates/blob/main/src/github-actions-runner-devcontainer/.devcontainer/scripts/start.sh)**:

```bash
#start.sh
#!/bin/bash

GH_OWNER=$GH_OWNER
GH_REPOSITORY=$GH_REPOSITORY
GH_TOKEN=$GH_TOKEN

HOSTNAME=$(hostname)
RUNNER_SUFFIX="runner"
RUNNER_NAME="${HOSTNAME}-${RUNNER_SUFFIX}"
USER_NAME_LABEL=$( (git config --get user.name) | sed -e 's/ //g')
REPO_NAME_LABEL="$GH_REPOSITORY"

REG_TOKEN=$(curl -sX POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GH_TOKEN}" https://api.github.com/repos/${GH_OWNER}/${GH_REPOSITORY}/actions/runners/registration-token | jq .token --raw-output)

/home/vscode/actions-runner/config.sh --unattended --url https://github.com/${GH_OWNER}/${GH_REPOSITORY} --token ${REG_TOKEN} --name ${RUNNER_NAME}  --labels ${USER_NAME_LABEL},${REPO_NAME_LABEL}
/home/vscode/actions-runner/run.sh
```

This startup script will bootstrap the **GitHub runner** when the Codespace starts. Parameters are taken from **GitHub Secrets**:

```bash
GH_OWNER=$GH_OWNER
GH_REPOSITORY=$GH_REPOSITORY
GH_TOKEN=$GH_TOKEN
```

These parameters (environment variables) are used to configure and **register** the self hosted github runner against the correct repository.

Provide the GitHub account/org name via the `'GH_OWNER'` environment variable, repository name via `'GH_REPOSITORY'` and a PAT token with `'GH_TOKEN'`.

You can store these parameters as encrypted [secrets for codespaces](https://docs.github.com/en/codespaces/managing-your-codespaces/managing-encrypted-secrets-for-your-codespaces).

1. Navigate to the repository `'Settings'` page and select `'Secrets -> Codespaces'`, click on `'New repository secret'`. ![image.png](https://raw.githubusercontent.com/Pwd9000-ML/blog-devto/main/posts/2022/GitHub-Codespaces-runner/assets/sec01.png)

2. Create each **Codespace secret** with the values for your environment. ![image.png](https://raw.githubusercontent.com/Pwd9000-ML/blog-devto/main/posts/2022/GitHub-Codespaces-runner/assets/sec02.png)  

The minimum permission scopes required on the PAT/GH_TOKEN to register a self hosted runner are: `"repo"`, `"read:org"`:

![image.png](https://raw.githubusercontent.com/Pwd9000-ML/blog-devto/main/posts/2022/GitHub-Codespaces-runner/assets/PAT.png)  

**NOTE:** When the **self hosted runner** is started up and registered, it will also be labeled with the **'user name'** and **'repository name'**, from the following lines. (These labels can be amended if necessary):

```bash
USER_NAME_LABEL=$( (git config --get user.name) | sed -e 's/ //g')
REPO_NAME_LABEL="$GH_REPOSITORY"
```

![image.png](https://raw.githubusercontent.com/Pwd9000-ML/blog-devto/main/posts/2022/GitHub-Codespaces-runner/assets/label01.png)

### Adding the definition to a project or codespace

1. If this is your first time using a development container, please see getting started information on [setting up](https://aka.ms/vscode-remote/containers/getting-started) Remote-Containers or [creating a codespace](https://aka.ms/ghcs-open-codespace) using GitHub Codespaces.

2. Start VS Code and open your project folder or connect to a codespace.

3. Press <kbd>F1</kbd> select and **Add Development Container Configuration Files...** command for **Remote-Containers** or **Codespaces**. 

   > **Note:** If needed, you can drag-and-drop the `.devcontainer` folder from this sub-folder in a locally cloned copy of this repository into the VS Code file explorer instead of using the command.

4. Select this definition. You may also need to select **Show All Definitions...** for it to appear.

5. Finally, press <kbd>F1</kbd> and run **Remote-Containers: Reopen Folder in Container** or **Codespaces: Rebuild Container** to start using the definition.

## License

Copyright (c) Microsoft Corporation. All rights reserved.

Licensed under the MIT License. See [LICENSE](https://github.com/Microsoft/vscode-dev-containers/blob/main/LICENSE).
