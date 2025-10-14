# Builder stage
FROM python:3.12-alpine AS builder

# Install ALL build dependencies including Rust
RUN apk add --no-cache \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev \
    cargo \
    rust \
    pkgconfig \
    git
# Install Python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --target=/install \
    git+https://github.com/bitwarden/sdk-sm.git@python-v1.0.0#subdirectory=languages/python

# Runtime stage
FROM ghcr.io/nathanwasson/spacelift-tailscale-ansible:latest

USER root

# Install runtime dependencies (not build tools)
RUN apk add --no-cache \
    libgcc \
    libstdc++

# Copy the Python packages from the builder stage to the runtime image
COPY --from=builder /install /usr/local/lib/python3.12/site-packages/

USER spacelift