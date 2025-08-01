# Intentionally vulnerable Dockerfile for Snyk Container demo
# Using outdated Ubuntu version with known vulnerabilities
FROM ubuntu:18.04

# Install vulnerable packages with specific outdated versions
RUN apt-get update && apt-get install -y \
    # Outdated OpenSSL with known CVEs
    openssl=1.1.1-1ubuntu2.1~18.04.23 \
    # Vulnerable curl version
    curl=7.58.0-2ubuntu3.24 \
    # Old Python with security issues
    python3=3.6.9-1~18.04ubuntu1.12 \
    python3-pip=9.0.1-2.3~ubuntu1.18.04.8 \
    # Vulnerable Git version
    git=1:2.17.1-1ubuntu0.18 \
    # Old Node.js from Ubuntu repos (vulnerable)
    nodejs=8.10.0~dfsg-2ubuntu0.4 \
    npm=3.5.2-0ubuntu4 \
    # Vulnerable web server
    nginx=1.14.0-0ubuntu1.11 \
    # Database with known issues
    sqlite3=3.22.0-1ubuntu0.7 \
    # Image processing libraries with vulnerabilities
    libpng16-16=1.6.34-1ubuntu0.18.04.2 \
    libjpeg8=8c-2ubuntu8 \
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