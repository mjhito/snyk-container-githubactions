# Snyk Container Demo - Intentionally Vulnerable Application

This repository contains an **intentionally vulnerable** containerized application designed to demonstrate the comprehensive security capabilities of **Snyk Container**. 

> ⚠️ **WARNING**: This application contains known security vulnerabilities and should **NEVER** be deployed to production environments.

## 🎯 Demo Purpose

This project showcases Snyk Container's ability to:
- **Scan vulnerable base images** and recommend secure alternatives
- **Generate comprehensive SBOMs** in multiple industry-standard formats
- **Identify container vulnerabilities** across all layers
- **Enforce security policies** with configurable gates
- **Provide continuous monitoring** for ongoing security
- **Generate detailed reports** for security teams

## 🏗️ Repository Setup Instructions

### 1. Create GitHub Repository

Based on your current folder name, create a new repository:
```bash
# If your folder is named "Dev", create repo as "snyk-container-demo" or similar
# Or use the actual folder name: "Dev"
```

### 2. Required GitHub Secrets Configuration

You **MUST** add the following secret to your GitHub repository:

#### `SNYK_TOKEN` (Required)
1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Name: `SNYK_TOKEN`
5. Value: Your Snyk API token

**How to get your Snyk Token:**
1. Log in to [Snyk.io](https://snyk.io)
2. Go to **Account Settings** → **General** → **API Token**
3. Copy your API token
4. Paste it as the `SNYK_TOKEN` secret value

### 3. Optional Configuration

#### Regional API Endpoints
Edit `.github/workflows/snyk-container.yml` if you're using a regional Snyk instance:

```yaml
env:
  # Change this line based on your Snyk region:
  SNYK_API: https://api.snyk.io        # Global (default)
  # SNYK_API: https://api.us.snyk.io   # US
  # SNYK_API: https://api.eu.snyk.io   # EU  
  # SNYK_API: https://api.au.snyk.io   # AU
```

#### Security Gate Configuration
By default, the pipeline will **FAIL** if high/critical vulnerabilities are found:

```yaml
env:
  SNYK_CONTAINER_FAIL_ON_ISSUES: true   # Blocks deployment on security issues
  # SNYK_CONTAINER_FAIL_ON_ISSUES: false # Allows deployment despite issues
```

## 📦 What This Demo Contains

### Vulnerable Components
- **Base Image**: Ubuntu 18.04 (EOL, many CVEs)
- **Packages**: Intentionally outdated system packages
- **Dependencies**: Vulnerable Node.js and Python packages
- **Application Code**: Contains common security anti-patterns

### GitHub Actions Workflow
- **Pre-build Dockerfile scanning**
- **Container vulnerability analysis** 
- **Multi-format SBOM generation**
- **HTML report generation** (snyk-to-html)
- **Continuous monitoring setup**
- **Security gate enforcement**
- **Comprehensive artifact collection**

## 🚀 Running the Demo

### Automatic Execution
The workflow runs automatically on:
- Push to `main` or `develop` branches
- Pull requests to `main` branch
- Manual trigger via GitHub Actions

### Manual Trigger
1. Go to **Actions** tab in your repository
2. Select **Snyk Container Security & SBOM Generation**  
3. Click **Run workflow**
4. Choose your branch and click **Run workflow**

## 📊 Generated Artifacts

After each run, the following artifacts are available for download:

### Security Reports
- **snyk-html-reports** - Interactive HTML vulnerability dashboards
- **snyk-container-results** - Raw JSON scan data
- **dockerfile-scan-results** - Pre-build security analysis
- **security-analysis-report** - Base image recommendations & policy status

### Software Bill of Materials (SBOM)
- **container-sbom-collection** - Complete SBOM package containing:
  - CycloneDX 1.6 format (JSON & XML)
  - CycloneDX 1.5 format (JSON)  
  - SPDX 2.3 format (JSON)
  - OS-only SBOM (excluding app dependencies)
  - Component analysis summary

### How to Download Artifacts
1. Go to **Actions** tab → Select your workflow run
2. Scroll to **Artifacts** section
3. Click to download any artifact collection
4. Extract and review the security reports

## 🔍 Expected Demo Results

When this workflow runs, you should see:

### ❌ Security Gate Failures
- **High/Critical vulnerabilities** in Ubuntu 18.04 base image
- **Vulnerable dependencies** in package.json and requirements.txt
- **Dockerfile security issues** from best practices analysis

### ✅ Successful Demonstrations  
- **5 different SBOM formats** generated successfully
- **Comprehensive vulnerability mapping** across all container layers
- **Base image recommendations** for secure alternatives  
- **HTML reports** with interactive vulnerability details
- **Monitoring project** created for ongoing security tracking

## 🛠️ Customization Options

### Changing Security Thresholds
Edit the workflow to adjust what triggers security gate failures:

```yaml
# In snyk-container.yml, modify this line:
snyk container test snyk-container-demo:latest --severity-threshold=high
# Options: low, medium, high, critical
```

### Adding More Vulnerability Types
Modify `Dockerfile`, `package.json`, or `requirements.txt` to include additional vulnerable packages for demonstration purposes.

### Different Base Images
Change the `FROM` line in `Dockerfile` to test different vulnerable base images:
```dockerfile
# Try different vulnerable bases:
FROM ubuntu:16.04    # Even older
FROM node:10         # Outdated Node.js
FROM python:3.6      # Outdated Python
```

## 📚 Documentation References

- [Snyk Container Documentation](https://docs.snyk.io/products/snyk-container)
- [Snyk CLI Container Commands](https://docs.snyk.io/snyk-cli/commands/container-test)
- [SBOM Generation Guide](https://docs.snyk.io/snyk-cli/commands/sbom)
- [GitHub Actions Integration](https://github.com/snyk/actions)

## ⚠️ Security Notice

This repository is for **demonstration purposes only**. It contains intentionally vulnerable components and should:

- **NEVER** be deployed to production
- **NEVER** be used as a template for real applications  
- **ONLY** be used in secure, isolated environments
- Be treated as educational material for security teams

## 🤝 Support

For issues with this demo:
1. Check that `SNYK_TOKEN` is properly configured
2. Verify your Snyk account has Container scanning enabled
3. Review the GitHub Actions logs for detailed error messages
4. Consult Snyk documentation for additional guidance

---

**Ready to run your Snyk Container demo!** 🎉

Just push this code to your GitHub repository with the `SNYK_TOKEN` secret configured, and watch the comprehensive security analysis in action.