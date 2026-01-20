#
# STEP 1: Prepare environment
#
FROM golang:1.24@sha256:c2131140c7c29ff277b1c412d524b7f56289513f49672c57a3d992247dd146f8 AS preparer

RUN apt-get update && apt upgrade -y && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  make curl git zip unzip wget dnsutils g++ gcc-aarch64-linux-gnu                 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /go/src/github.com/ssvlabs/ssv/
COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .
