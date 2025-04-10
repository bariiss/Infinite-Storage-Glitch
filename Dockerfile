FROM --platform=$BUILDPLATFORM ubuntu:24.04

# Build args from Buildx
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

# Non-interactive APT
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libopencv-dev \
    ffmpeg \
    build-essential \
    libssl-dev \
    clang \
    libclang-dev \
    pkg-config \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Rust for TARGETARCH
# Use rustup-init with target-specific installation
RUN curl -fsSL https://sh.rustup.rs -o rustup-init.sh && \
    chmod +x rustup-init.sh && \
    ./rustup-init.sh -y --default-toolchain stable && \
    rm rustup-init.sh

ENV PATH="/root/.cargo/bin:${PATH}"

# Set working directory
WORKDIR /home/Infinite-Storage-Glitch

# Set cargo home for better caching
ENV CARGO_HOME=/home/Infinite-Storage-Glitch/cargo_home

# Default command
CMD ["/bin/bash"]