#Solutions
# Secure Node.js Demo Application

A demonstration of implementing security-focused CI/CD pipeline for a Node.js application using GitHub Actions, deploying to DigitalOcean VM with integrated security scanning tools.

## Project Overview

This project demonstrates:
- Automated security scanning in CI/CD pipeline
- Code quality checks
- Automated testing with coverage
- Secure deployment process
- Basic application monitoring

### Security Tools Integrated
- **Trivy**: Vulnerability scanner
- **SonarCloud**: Code quality and security analysis
- **Git-leaks**: Secrets detection

## Prerequisites

- Node.js 18+
- GitHub account
- DigitalOcean VM
- SonarCloud account

## Quick Start

1. **Clone the repository**
```bash
git clone <repository-url>
cd secure-node-demo
```
2. **Install dependencies**
```bash
npm install
```
3. **Set up environment**
```bash
cp .env.example .env
```
4. **Run locally**
```bash
npm run dev
```

## GitHub Actions Pipeline Setup

1. **Add repository secrets** Navigate to Settings → Secrets and Variables → Actions and add:
- DO_HOST: Your DigitalOcean VM IP
- DO_USERNAME: VM SSH username
- DO_SSH_KEY: SSH private key
- SONAR_TOKEN: SonarCloud token

2. **Pipeline stages**
- PR Creation: Security scans, tests
- PR Merge: Deployment to VM
- Scheduled: Monitoring checks

## Deployment
The application automatically deploys to your DigitalOcean VM when changes are merged to main.

**Manual deployment:**
```bash
ssh username@your-vm-ip
cd secure-node-demo
bash deploy.sh
```

### Security Checks

**View Security Results**

1. **Trivy Scans**

- Check GitHub Actions logs
- Look for "Run Trivy vulnerability scanner" step

2. **SonarCloud Results**

- Visit your SonarCloud dashboard
- Review code quality gates and security hotspots

3. **Git-leaks**

- Check GitHub Actions logs
- Review "Run Gitleaks" step

### Security Monitoring
**Monitor application health:**
```bash
# SSH into VM
ssh username@your-vm-ip

# Check application status
pm2 status
pm2 logs secure-node-demo

# View monitoring logs
tail -f /var/log/secure-node-demo/monitoring.log
```

### Testing

**Run tests with coverage:**
```bash
npm test
```
Coverage thresholds:

- Branches: 50%
- Functions: 80%
- Lines: 80%
- Statements: 80%

### Project Structure
```bash
secure-node-demo/
├── .github/workflows/   # GitHub Actions pipeline
├── src/                # Application source
├── tests/              # Test files
├── monitoring/         # Monitoring scripts
├── deploy.sh           # Deployment script
└── CHECKPOINT.yml      # Project progress tracker
```

### Important Notes

1. **Security First**

- All security checks must pass before deployment
- Regular dependency updates recommended
- Monitor security scan results

2. **Deployment Safety**

- Pipeline includes multiple validation steps
- Automated rollback on failure
- Health checks after deployment

3. **Monitoring**

- Application health monitoring enabled
- PM2 process management
- Error logging and tracking

### Troubleshooting
Common issues and solutions:

1. **Pipeline Failures**

- Check GitHub Actions logs
- Verify all secrets are set
- Ensure tests pass locally
2. **Deployment Issues**

- Verify VM connectivity
- Check SSH key permissions
- Review deploy.sh logs
3. **Security Scan Failures**

- Review Trivy scan results
- Check SonarCloud dashboard
- Verify no secrets in code

### Contributing
1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

### License
**MIT**

### Contact
For questions or feedback, please open an issue in the repository.
