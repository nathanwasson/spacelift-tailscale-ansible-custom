FROM ghcr.io/nathanwasson/spacelift-tailscale-ansible:latest

USER root

RUN apk add --no-cache libgcc rsync \
 && apk add --no-cache --virtual .bws-build-deps curl unzip \
 && curl -fsSL \
      https://github.com/bitwarden/sdk-sm/releases/download/bws-v2.0.0/bws-x86_64-unknown-linux-musl-2.0.0.zip \
      -o /tmp/bws.zip \
 && unzip /tmp/bws.zip -d /usr/local/bin \
 && chmod +x /usr/local/bin/bws \
 && rm /tmp/bws.zip \
 && apk del .bws-build-deps

USER spacelift
