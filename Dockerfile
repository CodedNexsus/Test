# Use the latest Ubuntu image
FROM ubuntu:latest

# Set environment variables to avoid prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl sudo ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m -s /bin/bash appuser && \
    echo "appuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to non-root user
USER appuser
WORKDIR /home/appuser

# Run curl installer at container start
CMD bash -c "curl -sSf https://sshx.io/get | sh && exec bash"
