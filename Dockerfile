# Intentionally vulnerable Dockerfile for Snyk Container demo
# Using outdated Ubuntu version with known vulnerabilities
FROM ubuntu:18.04

# Install vulnerable packages - Ubuntu 18.04 default versions (all outdated and vulnerable)
RUN apt-get update && apt-get install -y \
    # These will install the default Ubuntu 18.04 versions which are all vulnerable
    openssl \
    curl \
    python3 \
    python3-pip \
    git \
    nodejs \
    npm \
    nginx \
    sqlite3 \
    libpng16-16 \
    libjpeg8 \
    # Additional vulnerable packages
    wget \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files for additional vulnerable dependencies
COPY package*.json ./

# Install Node.js dependencies (will include vulnerable packages)
RUN npm install --production

# Copy application code
COPY . .

# Create a non-root user (good practice, but won't fix the base vulnerabilities)
RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

# Expose port
EXPOSE 3000

# Health check using vulnerable curl
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Start the application
CMD ["node", "server.js"]