FROM jenkins/ssh-agent:jdk11
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
    libfreetype6 \
    fontconfig \
    fonts-dejavu \
    git \
    gnupg \
    ca-certificates \
    curl \
    tigervnc-standalone-server \
    tigervnc-common \
    fluxbox
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list && \
    apt-get update && \
    apt-get install --yes --no-install-recommends gh
RUN mkdir /home/jenkins/.vnc && \
    (echo jenkins; echo jenkins; echo "n") | vncpasswd /home/jenkins/.vnc/passwd && \
    chown -R jenkins /home/jenkins
