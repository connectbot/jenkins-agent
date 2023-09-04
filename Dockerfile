FROM jenkins/agent:3148.v532a_7e715ee3-2-jdk17

ARG user=jenkins

USER root

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
    git \
    gnupg \
    ca-certificates \
    curl \
    zlib1g \
    unzip \
    wget \
    jq \
    python3-venv \
    python3-pip

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y --no-install-recommends gh

USER ${user}
