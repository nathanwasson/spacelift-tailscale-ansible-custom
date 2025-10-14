FROM ghcr.io/nathanwasson/spacelift-tailscale-ansible:latest

USER root

# Install build dependencies and compile bws from source
RUN apk add --no-cache curl cargo rust openssl-dev pkgconfig && \
    export OPENSSL_NO_VENDOR=Y && \
    cargo install bws --locked --root /usr/local && \
    apk del cargo rust openssl-dev pkgconfig curl && \
    apk add --no-cache libgcc

USER spacelift