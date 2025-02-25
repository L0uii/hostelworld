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
- JFrog Artifactory (for container registry)

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

## Pipeline Failures

- **Outcome**: Pipeline stops at the failing step.
- **Action**: Check GitHub Actions logs, verify secrets, and ensure tests pass locally.

## Deployment Issues

- **Outcome**: Deployment fails, and rollback mechanism restarts the previous stable version.
- **Action**: Verify VM connectivity, check SSH key permissions, and review `deploy.sh` logs.

## Security Scan Failures

- **Outcome**: Pipeline stops if vulnerabilities or secrets are detected.
- **Action**: Review Trivy scan results, check SonarCloud dashboard, and verify no secrets in code.

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

## Securing Legacy VM

**Securing Legacy VMs in GCP:**
The following Steps I woul take are

1. Secure the Network:
   - Firewall rules using GCP's VPC firewall
   - Isolate VM in a separate VPC with limited connectivity
   - Proxy the connection access to the VM

2. Access Controls to environment:
   - Implement principle of least privilege
   - Disable password authentication
   - Regularly audit and rotate access credentials when possible

3. Monitoring & Protection:
   - Enable Cloud Audit Logs
   - Deploy Cloud IDS/IPS
   - Install and configure antivirus/malware protection
   - Set up Cloud Monitoring alerts

4. System Hardening:
   - Close unnecessary ports
   - Remove unused services and software
   - Keep necessary security patches updated
   - Enable OS-level logging

**Incident Response for Unauthorized Access:**

1. Immediate Containment:
   - Isolate the affected VM with firewall rules
   - Create a snapshot of the affected VM.
   - Temporarily disable external network access
   - Document all actions taken

2. Investigation:
   - Review Cloud Audit Logs for unauthorized activities
   - Analyze system logs for indicators of compromise
   - Check for unauthorized API calls or credential usage

3. Mitigation:
   - Revoke and rotate all access credentials
   - Block suspicious IP addresses
   - Remove any malicious code or unauthorized changes
   - Patch identified vulnerabilities

4. Recovery:
   - Create a clean VM instance if necessary
   - Restore from last known good backup
   - Implement additional security controls
   - Monitor closely for any recurring issues

5. Post-Incident:
   - Document the incident and response
   - Update security procedures based on lessons learned
   - Conduct a post-mortem analysis
   - Consider implementing additional security tools

## Securing Container Platforms
From the above NodeJs app deployment , I was able to use the following to implement 

**Container Image Security Best Practices:**

- I Used minimal base images (Alpine) to reduce attack surface
- I Implement multi-stage builds to minimize final image size
- I used trivy to Scan images for vulnerabilities before deployment
- Secrets should never be stored  or sensitive data in container images. I implemented sonarscanner and trivy to check this, while gitleaks check on the CI
- Run containers as non-root users
- Keep base images and dependencies updated
- Enforce immutable tags

# Secrets Management
**Development Environment**

- Incase of a development environment. A developer can create a config file and call that config file in there code. This file should be added to .gitignore file .

**Incase of Productions**
- If you must use it in a config file. You can use a solution like Openssl in a 2 way encryption algorithm and take the plain file and encrypt it and can only be read by someone with a proper key . The disadvantage with this method is that if you have other keys in this file then granting someone access to this file provides access to all the keys. Splitting to multpile files bring in the complexity of managing all keys. It also does not help with audit
- Another more robust option is to use Cloud provider secret manager like Google Secret Manager for GCP and integrate it with IAM. It also provides auditablity on access logs **(Best for Cloud Environment)**
- Using Ephemeral Credentials with solutions like Haschicorp vault is considerd the best with features like On demand credentials creation where a credential just last for the duration assigned to it

# Configuring IAM Roles in GCP
## Scenario 1: Development Team Permissions
- Create a Google Group for the team
- Assign roles to the group rather than individuals
- Use principle of least privilege
- Use roles/editor
- Use roles/compute.admin (Compute Engine Admin)
- Use roles/storage.admin (Cloud Storage Admin)
- Use roles/cloudql.admin (Cloud Sql Admin)

## Scenario 2: Application Access Control
- Create a service account
- Add roles/storage.objectViewer
- Add roles/logging.logWriter
- Use custom roles if predefined roles provide too many permissions
- Store credentials securely using Secret Manager

## Scenario 3: Auditing IAM Policies
**Initial Assessment:**
- I will performm an initial assessment by exporting the current policies.
- List all IAM bindings. (bindings.role,bindings.members)

**Regular Monitoring Plan:**
- Enable Cloud Audit Logs
- Implement Automated Checks
1. Set up alerts for:
    - Changes to IAM policies
    - Grant of high-privilege roles
    - Unused service accounts
    - Over-privileged service accounts

2. Regular Review Process
    - Weekly review of new IAM changes
    - Monthly audit of all service accounts
    - Quarterly review of all IAM policies
    - Annual comprehensive access review

3. Recovery steps:
```yaml
# Remove unnecessary roles
gcloud projects remove-iam-policy-binding PROJECT_ID \
    --member="louis:Oboh@example.com" \
    --role="roles/editor"

# Replace with more specific roles
gcloud projects add-iam-policy-binding PROJECT_ID \
    --member="louis:oboh@example.com" \
    --role="roles/compute.viewer"
```
4. Documentation steps:
- Maintain log of all role assigments.
- All priviledges should be jsutified.
- Reports must show users with elevated priviledges

# Automating IAM Policy Management
Depending on the complexity of the use case, you can go with the option of a simple script using **glcoud cli** like
```yaml
gcloud projects add-iam-policy-binding Hostel_ID \
  --member="user:admin@example.com" \
  --role="roles/owner"
  ```
  **or**
  ```yaml
  gcloud projects remove-iam-policy-binding Hostel_ID \
  --member="serviceAccount:unnecessary-service@example.iam.gserviceaccount.com" \
  --role="roles/editor"
  ```

## Using terraform to allow a project access  
**The below  code grants the roles/editor role to a user and a service account at the project level.**
```yaml
provider "google" {
  project = "my-Hostel-project"
  region  = "us-central1"
}
```
```yaml
resource "google_project_iam_binding" "developer_binding" {
  project = "my-Hostel-project"
  role    = "roles/editor"
  members = [
    "user:louis.oboh@example.com",
    "serviceAccount:app-sa@my-Hostel-project.iam.gserviceaccount.com"
  ]
}
```
