FROM ghcr.io/nathanwasson/spacelift-tailscale-ansible:latest

USER root

# Download and install bws CLI
RUN apk add --no-cache wget unzip && \
    wget https://github.com/bitwarden/sdk-sm/releases/download/bws-v1.0.0/bws-x86_64-unknown-linux-gnu-1.0.0.zip && \
    unzip bws-x86_64-unknown-linux-gnu-1.0.0.zip && \
    mv bws /usr/local/bin/ && \
    chmod +x /usr/local/bin/bws && \
    rm bws-x86_64-unknown-linux-gnu-1.0.0.zip && \
    apk del wget unzip

# Install glibc compatibility for the gnu version
RUN apk add --no-cache gcompat

USER spacelift