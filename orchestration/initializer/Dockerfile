FROM debian:bullseye as base

# Copy targets.json.
COPY configuration/targets.json targets.json

# Copy entrypoint to usr/local/bin.
COPY orchestration/initializer/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]