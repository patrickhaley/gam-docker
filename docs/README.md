# GAM7 Docker

This project provides a Dockerized version of GAM7, the Google Workspace Management Tool, optimized for use with Google Cloud and Artifact Registry.

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Project Structure](#project-structure)
3. [Getting Started](#getting-started)
4. [Deploying to Google Artifact Registry](#deploying-to-google-artifact-registry)
5. [Using GAM7 Docker with Google Cloud Shell](#using-gam7-docker-with-google-cloud-shell)
6. [Job Scheduling in Google Cloud](#job-scheduling-in-google-cloud)
7. [Multi-Platform Support](#multi-platform-support)
8. [Troubleshooting](#troubleshooting)
9. [Advanced Usage](#advanced-usage)
10. [Contributing](#contributing)
11. [License](#license)
12. [Support](#support)

## Prerequisites

- Google Cloud account with billing enabled
- Google Cloud SDK (`gcloud`) installed and configured
- Docker installed on your local system (for building and testing)
- Docker Compose V2 installed on your system
- Basic understanding of GAM and Google Workspace administration

## Project Structure

The project consists of the following key files and directories:

- `Dockerfile`: Defines the Docker image for GAM7
- `docker-compose.yml`: Configures the Docker container
- `requirements.txt`: Lists Python dependencies
- `scripts/`: Directory containing scripts for setup and entrypoint
  - `docker-entrypoint.sh`: Script that runs when the container starts
  - `setup-gam7-docker.sh`: Script to set up the environment in Google Cloud Shell
- `GAMConfig/`: Directory for GAM configuration files
- `GAMWork/`: Directory for GAM work files

## Getting Started

### Setting up GAMConfig

1. Create a directory structure for your GAM configuration:

   ```bash
   mkdir -p GAMConfig/{au,nz,us}
   mkdir -p GAMWork/{au,nz,us}
   ```

2. Place your GAM configuration files (`client_secrets.json`, `oauth2.txt`, `oauth2service.json`) in the appropriate subdirectories of `GAMConfig`.

3. Ensure your `gam.cfg` file is present in the `GAMConfig` directory.

## Deploying to Google Artifact Registry

1. Enable the Artifact Registry API in your Google Cloud project:

   ```bash
   gcloud services enable artifactregistry.googleapis.com
   ```

2. Create a repository in Artifact Registry:

   ```bash
   gcloud artifacts repositories create gam7-repo --repository-format=docker --location=us-central1 --description="GAM7 Docker images"
   ```

3. Configure Docker to use Google Cloud as a credential helper:

   ```bash
   gcloud auth configure-docker us-central1-docker.pkg.dev
   ```

4. Build your Docker image:

   ```bash
   docker build -t us-central1-docker.pkg.dev/gam-project-5y3-yuq-dpk/gam7-repo/gam-docker:latest .
   ```

5. Push the image to Artifact Registry:

   ```bash
   docker push us-central1-docker.pkg.dev/gam-project-5y3-yuq-dpk/gam7-repo/gam-docker:latest
   ```

6. Update your `docker-compose.yml` to use the image from Artifact Registry:

   ```yaml
   services:
     gam-docker:
       image: us-central1-docker.pkg.dev/gam-project-5y3-yuq-dpk/gam7-repo/gam-docker:latest
       platform: linux/amd64
       volumes:
         - ./GAMConfig:/home/gam/GAMConfig
         - ./GAMWork:/home/gam/GAMWork
       environment:
         - PATH=/home/gam/bin:/home/gam/bin/gam7:$PATH
         - GAMCFGDIR=/home/gam/GAMConfig
       entrypoint: ["/docker-entrypoint.sh"]
       command: tail -f /dev/null
       tty: true
       stdin_open: true
       restart: unless-stopped
   ```

## Using GAM7 Docker with Google Cloud Shell

Google Cloud Shell provides a convenient environment for managing your Google Cloud resources. Here's how to use GAM7 Docker in Cloud Shell:

1. Open Google Cloud Shell and clone your repository:

   ```bash
   git clone https://phaley@bitbucket.org/GJGTech/gam-docker.git
   cd gam-docker
   ```

2. Run the setup script:

   ```bash
   ./scripts/setup-gam7-docker.sh
   ```

   This script installs Docker Compose, configures Docker for Artifact Registry, pulls the latest image, and starts the container.

3. To run GAM commands:

   ```bash
   docker-compose exec gam-docker gam version
   ```

## Job Scheduling in Google Cloud

For scheduling GAM7 tasks, use Google Cloud Scheduler with Cloud Run:

1. Deploy your GAM7 container to Cloud Run:

   ```bash
   gcloud run deploy gam7-service --image us-central1-docker.pkg.dev/gam-project-5y3-yuq-dpk/gam7-repo/gam-docker:latest --platform managed
   ```

2. Create a Cloud Scheduler job:

   ```bash
   gcloud scheduler jobs create http gam7-job \
     --schedule="0 2 * * *" \
     --uri="https://gam7-service-xxxx-uc.a.run.app/run-gam-command" \
     --http-method=POST \
     --message-body='{"command": "update group"}'
   ```

## Multi-Platform Support

Our Docker image supports both AMD64 and ARM64 architectures. To build a multi-platform image:

1. Set up Docker BuildX:

   ```bash
   docker buildx create --name mybuilder --use
   ```

2. Build and push the multi-platform image:

   ```bash
   docker buildx build --platform linux/amd64,linux/arm64 \
     -t us-central1-docker.pkg.dev/gam-project-5y3-yuq-dpk/gam7-repo/gam-docker:latest \
     --push .
   ```

## Troubleshooting

If you encounter issues running GAM commands:

1. Check the GAM executable location:

   ```bash
   docker-compose exec gam-docker which gam
   ```

2. Verify permissions:

   ```bash
   docker-compose exec gam-docker ls -l /home/gam/bin/gam7/gam
   ```

3. Fix permissions if necessary:

   ```bash
   docker-compose exec gam-docker chmod +x /home/gam/bin/gam7/gam
   ```

4. If you're having issues with the container not starting or exiting immediately, check the Docker logs:

   ```bash
   docker-compose logs gam-docker
   ```

5. If you need to modify the entrypoint script:
   
   ```bash
   nano scripts/docker-entrypoint.sh
   ```
   
   Remember to rebuild your Docker image after making changes to this script.

## Advanced Usage

### Custom Build Arguments

To customize the build process, use build args in your `docker-compose.yml`:

```yaml
services:
  gam-docker:
    build:
      context: .
      args:
        CUSTOM_ARG: value
```

Update the Dockerfile to use these args:

```dockerfile
ARG CUSTOM_ARG
RUN echo $CUSTOM_ARG
```

### Updating Dependencies

If you need to update or add Python dependencies, modify the `requirements.txt` file. Then rebuild your Docker image to apply the changes.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

[MIT License](LICENSE)

## Support

For issues related to this Docker setup, please open an issue in this repository.
For GAM-specific questions, refer to the [official GAM documentation](https://github.com/GAM-team/GAM/wiki).