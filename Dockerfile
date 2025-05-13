# Start with Alpine Linux
FROM alpine:3.19

# Set environment variables
ENV GO_VERSION=1.21.6

# Install common dependencies and tools
RUN apk add --no-cache \
    curl \
    git \
    bash \
    build-base \
    wget \
    ca-certificates \
    zip \
    unzip \
    nano \
    tar

# Download and install specific Node.js version
RUN apk add --no-cache nodejs npm

# Install Go manually
RUN wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
    rm go${GO_VERSION}.linux-amd64.tar.gz

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"

# Optional: Verify installations
RUN go version && node -v && npm -v

# Default command
CMD ["bash"]