# GAM7 Docker

This project provides a Dockerized version of GAM7, the Google Workspace Management Tool, with support for multiple platforms.

## Prerequisites

- Docker installed on your system
- Docker Compose V2 installed on your system
- Basic understanding of GAM and Google Workspace administration

## Getting Started

### Setting up GAMConfig

Note: This setup is specific to my organization and allows me to manage multiple Google accounts. Learn more about [managing multiple customers and domains here.](https://github.com/taers232c/GAMADV-XTD3/wiki/gam.cfg#multiple-customers-and-domains)

1. Create a directory structure for your GAM configuration:

   ```bash
   mkdir -p GAMConfig/{au,nz,us}
   mkdir -p GAMWork/{au,nz,us}
   ```

2. Place your GAM configuration files (`client_secrets.json`, `oauth2.txt`, `oauth2service.json`) in the appropriate subdirectories of `GAMConfig`.

3. Ensure your `gam.cfg` file is present in the `GAMConfig` directory.

### Building the Docker Image

1. Clone this repository:

   ```bash
   git clone https://github.com/patrickhaley/gam-docker.git
   cd gam-docker
   ```

2. Build the Docker image:

   ```bash
   docker compose build
   ```

### Using the Pre-built Docker Hub Image

If you prefer not to build the image yourself, you can use the pre-built image from Docker Hub:

1. Pull the latest image:

   ```
   docker pull patrickhaley/gam-docker:latest
   ```

2. Update the `docker-compose.yml` file to use the Docker Hub image:

   ```yaml
   services:
     gam-docker:
       image: patrickhaley/gam-docker:latest
       # ... rest of your docker-compose configuration ...
   ```

### Multi-Platform Support

Our Docker image now supports multiple platforms, including AMD64 (Intel/AMD) and ARM64 (Apple Silicon) architectures. This means you can run the same image on various systems, including:

- Intel-based Macs
- Apple Silicon Macs (M1, M2, etc.)
- Linux servers (both AMD64 and ARM64)
- Google Cloud environments

To use the multi-platform image:

1. Ensure you're using Docker BuildX (included with Docker Desktop and recent Docker Engine versions).

2. When building the image locally, use:

   ```bash
   docker buildx build --platform linux/amd64,linux/arm64 -t yourdockerhub/gam-docker:latest --push .
   ```

   This will create a multi-platform image that works across different architectures.

3. If you're using the pre-built image from Docker Hub, it's already multi-platform. You don't need to specify the platform when running it.

### Running the Container

1. Start the container:

   ```bash
   docker compose up -d
   ```

2. Verify the container is running:

   ```bash
   docker ps
   ```

Note: These instructions work for both locally built images and the pre-built Docker Hub image, across all supported platforms.

### Using GAM7

1. To run GAM commands, use:

   ```bash
   docker compose exec gam-docker gam version
   ```

2. To enter the container's shell:

   ```bash
   docker compose exec gam-docker bash
   ```

## Managing GAMConfig

- Your local `GAMConfig` directory is mounted as a volume in the container.
- Any changes made to files in this directory will persist across container restarts.
- To update your GAM configuration, simply modify the files in your local `GAMConfig` directory.

## Container Lifecycle

### Stopping the Container

```bash
docker compose down
```

### Removing the Container

```bash
docker compose down -v
```

This will also remove the associated volumes.

### Updating the Container

1. Pull the latest image from Docker Hub:

   ```bash
   docker pull patrickhaley/gam-docker:latest
   ```

2. Stop and remove the existing container:

   ```bash
   docker compose down
   ```

3. Start a new container with the updated image:

   ```bash
   docker compose up -d
   ```

## Convenient Command Execution

To run GAM commands without entering the container each time, you can set up a proxy script:

1. Create a file named `gam` (without any extension) in a directory that's in your system's PATH (e.g., `/usr/local/bin/` on Unix-like systems):

   ```bash
   sudo nano /usr/local/bin/gam
   ```

2. Add the code from the [gam](gam) file in the root of this directory to the file.

3. Update the `DOCKER_COMPOSE_PATH` in the script to point to the directory containing your `docker-compose.yml` file.

4. Make the script executable:

   ```bash
   sudo chmod +x /usr/local/bin/gam
   ```

Now you can run GAM commands directly from your host system:

```bash
gam version
gam select us save
gam info domain
```

These commands will be executed inside the Docker container automatically.

## Troubleshooting

- To view container logs:

  ```bash
  docker logs gam-docker
  ```

- If you encounter issues, ensure your GAMConfig files are correctly set up and the paths in your `gam.cfg` file are correct.

## Advanced Usage

### Custom Build Arguments

If you need to customize the build process, you can use build arguments. Edit the `docker-compose.yml` file to include build args:

```yaml
build:
  context: .
  args:
    - CUSTOM_ARG=value
```

Then update the Dockerfile to use these args:

```dockerfile
ARG CUSTOM_ARG
RUN echo $CUSTOM_ARG
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Pushing Updates to Docker Hub

If you've made changes to the image and want to push an update to Docker Hub:

1. Rebuild the image:

   ```
   docker buildx build --platform linux/amd64,linux/arm64 -t patrickhaley/gam-docker:latest .
   ```

2. Push to Docker Hub:

   ```
   docker push patrickhaley/gam-docker:latest
   ```

## License

[MIT License](LICENSE)

## Support

For issues related to this Docker setup, please open an issue in this repository.
For GAM-specific questions, refer to the [official GAM documentation](https://github.com/GAM-team/GAM/wiki).