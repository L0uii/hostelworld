# Stage 1: Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# Add build command if needed
# RUN npm run build

# Stage 2: Production stage
FROM node:18-alpine
# Add non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
WORKDIR /app

# Copy only necessary files from build stage
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/src ./src
# If you have a build step, copy the build output 
# COPY --from=builder /app/dist ./dist

# Install only production dependencies
RUN npm ci --only=production && \
    # Clean npm cache
    npm cache clean --force && \
    # Set proper permissions
    chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

CMD ["node", "src/server.js"]