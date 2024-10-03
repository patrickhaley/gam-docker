# Use buildx to create a multi-platform image
FROM --platform=$BUILDPLATFORM python:3.9-slim AS builder

# Set up environment variables
ENV USER=gam
ENV HOME /home/$USER 
ENV GAMCFGDIR="$HOME/GAMConfig"

# Install necessary tools
RUN apt-get update && \
    apt-get install -y curl gnupg2 xz-utils && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user and set up the home directory
RUN useradd -m -s /bin/bash $USER && \
    mkdir -p $HOME/bin $HOME/GAMConfig $HOME/GAMWork && \
    mkdir -p $HOME/GAMConfig/au $HOME/GAMConfig/nz $HOME/GAMConfig/us && \
    mkdir -p $HOME/GAMWork/au $HOME/GAMWork/nz $HOME/GAMWork/us && \
    chown -R $USER:$USER $HOME

# Copy requirements file and entrypoint script
COPY requirements.txt .
COPY docker-entrypoint.sh /docker-entrypoint.sh

# Ensure the entrypoint script has the correct permissions and line endings
RUN chmod +x /docker-entrypoint.sh && \
    sed -i 's/\r$//' /docker-entrypoint.sh

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Switch to non-root user
USER $USER
WORKDIR $HOME

# Download and run the GAM install script
RUN curl -s -S -L https://git.io/install-gam | bash -s -- -l

# Set a clean PATH specific to the container
ENV PATH="/home/$USER/bin:/home/$USER/bin/gam7:/usr/local/bin:/usr/bin:/bin"

# Set the entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

# Create a target stage for each platform
FROM builder AS amd64
FROM builder AS arm64

# Use a manifest to combine the images
FROM ${TARGETARCH}