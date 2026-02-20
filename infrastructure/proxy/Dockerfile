# =============================================================
# Lab Room Proxy — Squid Forward Proxy
# Allows public internet, blocks private/local IP ranges
# Author: Mia 🌸 | Date: 2026-02-15
# =============================================================

FROM ubuntu:24.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends squid && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create required directories
RUN mkdir -p /var/log/squid /var/spool/squid /var/run/squid && \
    chown -R proxy:proxy /var/log/squid /var/spool/squid /var/run/squid

# Copy our config
COPY squid.conf /etc/squid/squid.conf

# Initialize cache (even though we're not caching, Squid expects this)
RUN squid -z --foreground 2>/dev/null || true

EXPOSE 3128

# Run Squid in foreground
CMD ["squid", "--foreground", "-f", "/etc/squid/squid.conf"]
