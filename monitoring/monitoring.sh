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

# Check PM2 process
pm2_check() {
    if pm2 describe secure-node-demo > /dev/null; then
        echo "[$(date)] PM2 process is running" >> $LOG_FILE
        return 0
    else
        echo "[$(date)] PM2 process is not running" >> $LOG_FILE
        return 1
    fi
}

# Main monitoring logic
main() {
    health_check || pm2 restart secure-node-demo
    pm2_check
}

main