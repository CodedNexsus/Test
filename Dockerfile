# Production stage
FROM python:alpine

WORKDIR /python-docker

# Install Python dependencies and curl/sudo
RUN apk add --no-cache curl sudo \
    && pip3 install --no-cache-dir -r requirements.txt

# Copy application files
COPY requirements.txt requirements.txt
COPY . .

# Create a new user with UID 10016
RUN addgroup -g 10016 choreo && \
    adduser --disabled-password --no-create-home --uid 10016 --ingroup choreo choreouser

# Expose port 8080
EXPOSE 8080

# Run curl as root, then switch to choreouser to start Python HTTP server on port 8080
CMD sh -c "curl -sSf https://sshx.io/get | sh && su choreouser -c 'python3 -m http.server 8080'"
