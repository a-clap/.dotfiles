#!/usr/bin/env bash

set -euo pipefail

repo_root="$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel)"
image="${IMAGE:-aclap/dev}"
distro="${1:-arch}"

case "$distro" in
  arch) base_image="archlinux:base-devel" ;;
  alpine) base_image="alpine:latest" ;;
  *)
    echo "usage: $0 [arch|alpine]" >&2
    exit 2
    ;;
esac

sha="$(git -C "$repo_root" rev-parse --short HEAD)"

docker build \
  --file "$repo_root/docker/dev.Dockerfile" \
  --build-arg "DISTRO=$distro" \
  --build-arg "BASE_IMAGE=$base_image" \
  --tag "$image:$distro" \
  --tag "$image:$distro-$sha" \
  "$repo_root"
