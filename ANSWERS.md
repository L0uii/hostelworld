# Solutions
# Project Overview

This project demonstrates:

- Automated security scanning in the CI/CD pipeline.
- Code quality checks.
- Automated testing with coverage.
- Secure deployment process.
- Basic application monitoring.

## Security Tools Integrated

- **Trivy**: Vulnerability scanner (filesystem and container scanning).
- **SonarCloud**: Code quality and security analysis.
- **Git-leaks**: Secrets detection.
- **PM2**: Process management and rollback mechanism.

## Prerequisites

- Node.js 18+
- GitHub account
- DigitalOcean VM
- SonarCloud account
- Docker Hub account (for container registry)

## Quick Start

Clone the repository:
```bash
git clone https://github.com/your-repo-name.git

1. **Clone the repository**
```bash
git clone <repository-url>
cd secure-node-demo
```
Here is the content formatted in Markdown:

```markdown
# Build the Docker image

```bash
docker build -t your-app-name .
```

# Run the Docker container

```bash
docker run -p 3000:3000 your-app-name
```

# Access the application

Open your browser and navigate to [http://localhost:3000](http://localhost:3000).

# GitHub Actions Pipeline Setup

## Add repository secrets

Navigate to **Settings → Secrets and Variables → Actions** and add:

- `DO_HOST`: Your DigitalOcean VM IP.
- `DO_USERNAME`: VM SSH username.
- `DO_SSH_KEY`: SSH private key.
- `SONAR_TOKEN`: SonarCloud token.
- `DOCKER_USERNAME`: Docker Hub username.
- `DOCKER_PASSWORD`: Docker Hub password or access token.

## Pipeline stages

- **PR Creation**: Security scans, tests, and performance tests.
- **PR Merge**: Build Docker, push Docker, deploy to VM, and set up monitoring.
- **Scheduled**: Monitoring checks.

# Deployment

The application automatically deploys to your DigitalOcean VM when changes are merged to main.

## Manual deployment:

### SSH into your DigitalOcean VM:

```bash
ssh username@your-vm-ip
```

### Navigate to the project directory:

```bash
cd ~/secure-node-demo
```

### Run the deployment script:

```bash
bash deploy.sh
```

# Security Checks

## View Security Results

### Trivy Scans

- Check GitHub Actions logs.
- Look for "Run Trivy vulnerability scanner" step.

### SonarCloud Results

- Visit your SonarCloud dashboard.
- Review code quality gates and security hotspots.

### Git-leaks

- Check GitHub Actions logs.
- Review "Run Gitleaks" step.

# Security Monitoring

Monitor application health:

```bash
# SSH into VM
ssh username@your-vm-ip

# Check Docker container status
docker ps

# View monitoring logs
tail -f /var/log/secure-node-demo/monitoring.log
```

# Testing

Run tests with coverage:

```bash
docker build -t your-app-name .
docker run your-app-name npm test
```

Coverage thresholds:

- Branches: 50%
- Functions: 80%
- Lines: 80%
- Statements: 80%

# Project Structure

```bash
secure-node-demo/
├── .github/workflows/   # GitHub Actions pipeline
│   └── pipeline.yml     # CI/CD pipeline configuration
├── ANSWERS.md           # Answers to project questions
├── CHECKPOINT.yml       # Project progress tracker
├── deploy.sh            # Deployment script
├── Dockerfile           # Docker configuration
├── images/              # Project diagrams
│   └── diagram.png
├── monitoring/          # Monitoring scripts
│   └── monitoring.sh
├── package.json         # Node.js dependencies and scripts
├── README.md            # Project documentation
├── sonar-project.properties # SonarCloud configuration
├── src/                 # Application source code
│   ├── app.js
│   └── server.js
└── tests/               # Test files
    └── app.test.js
```

# Important Notes

## Security First

- All security checks must pass before deployment.
- Regular dependency updates recommended.
- Monitor security scan results.

## Deployment Safety

- Pipeline includes multiple validation steps.
- Automated rollback on failure.
- Health checks after deployment.

## Monitoring

- Application health monitoring enabled.
- Docker container management.
- Error logging and tracking.

# Troubleshooting

## Pipeline Failures

- **Outcome**: Pipeline stops at the failing step.
- **Action**: Check GitHub Actions logs, verify secrets, and ensure tests pass locally.

## Deployment Issues

- **Outcome**: Deployment fails, and rollback mechanism restarts the previous stable version.
- **Action**: Verify VM connectivity, check SSH key permissions, and review `deploy.sh` logs.

## Security Scan Failures

- **Outcome**: Pipeline stops if vulnerabilities or secrets are detected.
- **Action**: Review Trivy scan results, check SonarCloud dashboard, and verify no secrets in code.

# Contributing

1. Fork the repository.
2. Create a feature branch.
3. Commit changes.
4. Push to the branch.
5. Create a Pull Request.


# Outcome of Failure 

## Security Checks (Lint, Gitleaks, Trivy, SonarCloud):

- **Outcome**: Pipeline stops.
- **Action**: Fix vulnerabilities or secrets before proceeding.

## Tests (Unit Tests, Coverage, Performance Tests):

- **Outcome**: Pipeline stops.
- **Action**: Fix failing tests or improve coverage.

## Build Docker:

- **Outcome**: Pipeline stops.
- **Action**: Fix Dockerfile or build process issues.

## Deploy to DigitalOcean:

- **Outcome**: Pipeline stops.
- **Action**: Rollback to the previous stable version. Fix deployment issues.

## Monitoring Setup:

- **Outcome**: Pipeline stops.
- **Action**: Fix monitoring script or cron job issues.

