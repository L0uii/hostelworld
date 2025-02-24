# Use a minimal Node.js 18 Alpine image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies (production only)
RUN npm ci --only=production

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port the application runs on
EXPOSE 3000

# Define the command to run the application
CMD ["node", "src/server.js"]

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1