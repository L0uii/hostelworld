#!/bin/bash

# Application health check
APP_URL="http://localhost:3000/health"
LOG_FILE="/var/log/secure-node-demo/monitoring.log"

# Ensure log directory exists
mkdir -p /var/log/secure-node-demo

# Check application health
health_check() {
    response=$(curl -s $APP_URL)
    if [[ $response == *"healthy"* ]]; then
        echo "[$(date)] Health check passed" >> $LOG_FILE
        return 0
    else
        echo "[$(date)] Health check failed" >> $LOG_FILE
        return 1
    fi
}

# Check Docker container
docker_check() {
    if docker ps --filter "name=secure-node-demo" --format "{{.Status}}" | grep -q "Up"; then
        echo "[$(date)] Docker container is running" >> $LOG_FILE
        return 0
    else
        echo "[$(date)] Docker container is not running" >> $LOG_FILE
        return 1
    fi
}

# Main monitoring logic
main() {
    health_check || docker restart secure-node-demo
    docker_check
}

main