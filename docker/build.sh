#!/bin/bash

set -euo pipefail

image=aclap/dev
sha=$(git rev-parse --short HEAD)

docker build -f dev.Dockerfile . -t $image:latest -t $image:"$sha"
