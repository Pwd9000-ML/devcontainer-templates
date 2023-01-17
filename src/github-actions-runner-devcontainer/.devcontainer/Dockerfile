# You can pick any Debian/Ubuntu-based image. 😊
FROM mcr.microsoft.com/vscode/devcontainers/base:${templateOption:imageVariant}

# [Optional] Install zsh
#ARG INSTALL_ZSH=${templateOption:installZSH}
# [Optional] Upgrade OS packages to their latest versions
#ARG UPGRADE_PACKAGES=${templateOption:upgradePackages}

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY scripts/*.sh /tmp/scripts/
#RUN bash /tmp/scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true"

# cd into the user directory, download and unzip the github actions runner
RUN cd /home/vscode && mkdir actions-runner && cd actions-runner

# input GitHub runner version argument
ARG RUNNER_VERSION=${templateOption:runnerVersion}

# download, extract and install dependencies for GitHub Actions runner
RUN cd /home/vscode/actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf /home/vscode/actions-runner/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && /home/vscode/actions-runner/bin/installdependencies.sh

# copy over the start.sh script
COPY scripts/start.sh /home/vscode/actions-runner/start.sh

# Apply ownership of home folder
RUN chown -R vscode ~vscode

# make the script executable
RUN chmod +x /home/vscode/actions-runner/start.sh

# Clean up
RUN rm -rf /var/lib/apt/lists/* /tmp/scripts