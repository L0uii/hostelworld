#!/bin/bash

echo "Pulling latest changes..."
git pull

echo "Installing dependencies..."
npm ci --only=production

echo "Setting up monitoring..."
chmod +x monitoring/monitoring.sh

# Setup crontab for monitoring
(crontab -l 2>/dev/null; echo "*/5 * * * * $(pwd)/monitoring/monitoring.sh") | crontab -

echo "Running application with PM2..."
pm2 restart secure-node-demo || pm2 start src/server.js --name secure-node-demo

echo "Deployment completed!"