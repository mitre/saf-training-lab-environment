FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu

# Install dependencies and update CA certificates
COPY extra-ca.pem /usr/local/share/ca-certificates/extra-ca.crt
COPY env-vars /tmp/.env
RUN apt-get update && apt-get install -y \
    tree \
    curl \
    ca-certificates \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install PostgreSQL
RUN apt-get update && \
    apt-get install -y postgresql postgresql-contrib && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install InSpec or Workstation
ARG CINC_PACKAGE
ARG CINC_VERSION
RUN /bin/bash -c "source /tmp/.env && curl -L https://omnitruck.cinc.sh/install.sh -k | bash -s -- -P \${CINC_PACKAGE} -v \${CINC_VERSION}"

# Install MITRE SAF CLI
RUN /bin/bash -c "npm install -g @mitre/saf"
