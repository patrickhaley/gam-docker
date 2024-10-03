#!/bin/bash

# Install Docker Compose (if not already installed)
if ! command -v docker-compose &> /dev/null; then
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Set up GAM7 Docker
gcloud auth configure-docker us-central1-docker.pkg.dev

# Pull the latest image from Google Artifact Registry
docker-compose pull

# Start the container
docker-compose up -d

echo "GAM7 Docker container is now running."