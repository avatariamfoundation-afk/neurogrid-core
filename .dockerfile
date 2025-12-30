# NeuroGrid Core Smart Contract Infrastructure Container
# Purpose: Deterministic build, test, and deployment environment
# for Core contracts and registries only.
# No clinical logic, no data processing.

FROM node:20-slim

# -----------------------------
# Security & Environment Defaults
# -----------------------------
ENV NODE_ENV=production
ENV TZ=UTC

# Create non-root user
RUN groupadd -r neurogrid && useradd -r -g neurogrid neurogrid

# -----------------------------
# System Dependencies
# -----------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    curl \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# Working Directory
# -----------------------------
WORKDIR /opt/neurogrid-core

# -----------------------------
# Dependency Installation
# -----------------------------
COPY package.json package-lock.json* ./

RUN npm ci --omit=dev

# -----------------------------
# Application Files
# -----------------------------
COPY . .

# -----------------------------
# Permissions
# -----------------------------
RUN chown -R neurogrid:neurogrid /opt/neurogrid-core
USER neurogrid

# -----------------------------
# Runtime Contract
# -----------------------------
# This container is permitted to:
# - Compile Solidity contracts
# - Run tests
# - Deploy to configured networks
# - Emit registry and audit events
#
# This container must NEVER:
# - Execute clinical logic
# - Store patient data
# - Perform off-chain governance decisions

CMD ["npx", "hardhat", "compile"]

