# Use a minimal base image
FROM node:14-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies in non-interactive mode
RUN apk add --no-cache python3 make g++ && npm install

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port the application runs on
EXPOSE 3000

# Define the command to run the application
CMD ["npm", "start"]

# Add health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000 || exit 1