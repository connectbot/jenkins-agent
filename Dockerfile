FROM jenkins/agent:3345.v03dee9b_f88fc-7-jdk17

ARG user=jenkins

USER root

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
    apksigner \
    ca-certificates \
    curl \
    git \
    gnupg \
    jq \
    python3-pip \
    python3-venv \
    unzip \
    wget \
    zipalign \
    zlib1g \
    zstd

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y --no-install-recommends gh

RUN curl -L https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip -o commandlinetools-linux-latest.zip \
    && mkdir -p /opt/android-sdk/cmdline-tools \
    && unzip commandlinetools-linux-latest.zip -d /opt/android-sdk/cmdline-tools \
    && mv /opt/android-sdk/cmdline-tools/cmdline-tools /opt/android-sdk/cmdline-tools/latest

RUN yes | /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager 'build-tools;36.1.0'

USER ${user}
