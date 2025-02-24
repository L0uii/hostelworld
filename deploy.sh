#!/bin/bash

# Pull the latest Docker image
docker pull your-dockerhub-username/your-app-name

# Stop and remove the existing container (if any)
docker stop secure-node-demo || true
docker rm secure-node-demo || true

# Run the new container
docker run -d --name secure-node-demo -p 3000:3000 your-dockerhub-username/your-app-name

# Set up monitoring (if needed)
chmod +x monitoring/monitoring.sh
(crontab -l 2>/dev/null; echo "*/5 * * * * $(pwd)/monitoring/monitoring.sh") | crontab -

echo "Deployment completed!"