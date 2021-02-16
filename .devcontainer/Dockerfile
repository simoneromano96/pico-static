# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.160.0/containers/debian/.devcontainer/base.Dockerfile

# [Choice] Debian version: buster, stretch
ARG VARIANT="buster"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install --no-install-recommends build-essential

RUN git clone https://github.com/vlang/v && \
    cd v && \
    make

RUN /v/v symlink

# RUN chown --recursive vscode /v

# RUN chown --recursive vscode /tmp
