ARG APP_DEVELOPMENT_NAME
ARG SERVICE_DISCOVERY_FREQUENCY_MS

FROM node:bullseye AS base

# Set environment variables.
ENV SERVICE_DISCOVERY_FREQUENCY_MS=${SERVICE_DISCOVERY_FREQUENCY_MS}

# Copy kube config.
# Tmp: Should provide a cert to use the K8 API.
COPY configuration/kc /root/.kube/config

# Make working directory.
WORKDIR /usr/local/bin/${APP_DEVELOPMENT_NAME}

# Install npm dependencies.
COPY app/service-discovery/package*.json ./
RUN npm ci

# Copy backend.
COPY app/service-discovery app/service-discovery

# Copy entrypoint.
COPY orchestration/service-discovery/entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]

# Expectations from derived images:
    # Copy frontend to app/frontend.
    # Set ENVIRONMENT env var.
    # Set SERVER_PORT env var.