# A docker image for Concrete CMS that supports automatic configuration via environment variables and provisioning scripts.

Work in progress.

## Configuration via Environment Variables

See .env.example for a list of supported environment variables.

## Provisioning Scripts

You can add provisioning scripts to the `/provisioning` directory inside the container. These scripts will be executed once during the first startup of the container, allowing you to customize your Concrete CMS installation (e.g., setting site name, locale, mail settings, installing packages, etc.).

Be sure that this directory is mounted as a volume in your docker-compose.yml

## Getting Started

```
docker-compose build
docker-compose up
```

Then access your Concrete CMS site at `http://localhost:26627`.