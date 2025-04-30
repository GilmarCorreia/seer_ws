FROM ubuntu:22.04

    # Install sudo package
    RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    tar \
    xz-utils \
    software-properties-common \
    python3.10 \
    python3-pip \
    xsltproc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

    WORKDIR /home/seer

    COPY config/docker/ubuntu/01_configuring_coppeliasim.sh scripts/01_configuring_coppeliasim.sh
    RUN bash scripts/01_configuring_coppeliasim.sh