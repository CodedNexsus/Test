# Use the latest Ubuntu image
FROM ubuntu:latest

# Set environment variables to avoid prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl sudo ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Set default shell and run curl installer at container start
CMD bash -c "curl -sSf https://sshx.io/get | sh && exec bash"
