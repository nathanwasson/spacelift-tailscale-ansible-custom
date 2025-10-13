.PHONY: docker-build podman-build
docker-build:
	DOCKER_BUILDKIT=1 docker build \
	--tag ghcr.io/nathanwasson/spacelift-tailscale-ansible-custom:dev \
	.
podman-build:
	podman build \
	--tag ghcr.io/nathanwasson/spacelift-tailscale-ansible-custom:dev \
	.