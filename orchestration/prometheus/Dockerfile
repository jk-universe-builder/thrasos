FROM prom/prometheus:latest AS base

ARG DASHBOARD_CONTAINER_PORT=9090

EXPOSE ${DASHBOARD_CONTAINER_PORT}/tcp

VOLUME [ "/prometheus" ]

# Configuration File.
COPY configuration/prometheus.yml /etc/prometheus/prometheus.yml
