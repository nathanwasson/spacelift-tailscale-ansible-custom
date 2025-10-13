# Builder stage
FROM python:3.12-slim AS builder

# Install Python packages
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir --prefix=/install -r /tmp/requirements.txt

# Runtime stage
FROM ghcr.io/nathanwasson/spacelift-tailscale-ansible:latest

USER root

# Copy the Python packages from the builder stage to the runtime image
COPY --from=builder /install /usr/local

USER spacelift