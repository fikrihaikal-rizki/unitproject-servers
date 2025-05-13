# Start with Alpine Linux
FROM alpine:3.14

# Set environment variables
ENV GO_VERSION=1.21.6
ENV NODE_VERSION=22.12.0
ENV NVM_DIR /usr/local/nvm

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

# Install Go manually
RUN wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
    rm go${GO_VERSION}.linux-amd64.tar.gz

# Set Go environment variables
ENV PATH="/usr/local/go/bin:${PATH}"

# install NVM then install node js
ENV NVM_INSTALL_PATH $NVM_DIR/versions/node/v$NODE_VERSION
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
   && nvm install $NODE_VERSION \
   && nvm alias default $NODE_VERSION \
   && nvm use default
ENV NODE_PATH $NVM_INSTALL_PATH/lib/node_modules
ENV PATH $NVM_INSTALL_PATH/bin:$PATH
RUN npm -v
RUN node -v

# Optional: Verify installations
RUN go version && node -v && npm -v

# for gaining access folder
RUN chown -R www-data:www-data /var/www/html/

# Default command
CMD ["bash"]