FROM jenkins/ssh-agent:jdk11
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
    libfreetype6 \
    fontconfig \
    fonts-dejavu
