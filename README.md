# Liatrio Open Source Template

A battle-tested GitHub template repository with opinionated developer experience, quality gates, and CI/CD automation ready for customization.

[![CI Status](https://github.com/liatrio-labs/open-source-project-template/actions/workflows/ci.yml/badge.svg)](https://github.com/liatrio-labs/open-source-project-template/actions/workflows/ci.yml)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://github.com/liatrio-labs/open-source-project-template/blob/main/LICENSE)

## Why Use This Template?

This template provides Liatrio teams with a proven foundation for new projects, including:

- **Pre-configured CI/CD**: GitHub Actions workflows for testing, linting, and semantic versioning
- **Quality gates**: Pre-commit hooks for YAML validation, markdown linting, and conventional commits
- **Automated releases**: Semantic versioning with changelog generation
- **Documentation standards**: Contribution guidelines, issue templates, and PR templates

## Quick Start

### 1. Create Repository from Template

Click the **"Use this template"** button at the top of this repository, or use the GitHub CLI:

```bash
gh repo create my-new-project --template liatrio-labs/open-source-project-template --public
cd my-new-project
```

### 2. Install Dependencies

Install pre-commit for local quality gates:

```bash
# macOS
brew install pre-commit

# Ubuntu/Debian
sudo apt install pre-commit

# pip (all platforms)
pip install pre-commit
```

### 3. Set Up Pre-commit Hooks

```bash
pre-commit install
```

> Secret scanning is enforced with [Gitleaks](https://github.com/gitleaks/gitleaks). If the hook blocks a commit, remove the secret, rotate the credential, and rerun `pre-commit`.

### 4. Customize for Your Project

Follow the [customization checklist](#customization-checklist) below to adapt the template for your specific project.

## Customization Checklist

After creating your repository from this template, complete the following steps:

### Repository Configuration

- [ ] Update repository name and description in GitHub settings
- [ ] Update `README.md` with your project name, description, and badges
- [ ] Update `.github/chainguard/main-semantic-release.sts.yaml` with your repository path
- [ ] Review and customize `.gitignore` for your language/framework
- [ ] (Optional) Change license - see [Changing the License](#changing-the-license)

### CI/CD Workflows

- [ ] Update `.github/workflows/ci.yml` workflow name if needed
- [ ] Add language-specific setup steps (Node.js, Python, Go, Rust, Java, etc.)
- [ ] Replace placeholder test and lint commands with your actual commands
- [ ] Update paths-ignore in workflows if needed
- [ ] Review `.github/workflows/release.yml` and customize build/release steps

### Pre-commit Hooks

- [ ] Review `.pre-commit-config.yaml` and add language-specific hooks
- [ ] See [CONTRIBUTING.md](CONTRIBUTING.md) for examples (ESLint, Ruff, golangci-lint, etc.)
- [ ] Configure hook versions to match your project's requirements

### Documentation

- [ ] Update this README with project-specific information
- [ ] Customize `CONTRIBUTING.md` with project-specific contribution guidelines
- [ ] Review and update issue templates in `.github/ISSUE_TEMPLATE/`
- [ ] Customize pull request template in `.github/pull_request_template.md`
- [ ] Update `docs/development.md` with project-specific setup instructions

### Secrets and Authentication

The following secrets are configured at the Liatrio organization level:

- [ ] Verify Octo STS is configured (for semantic-release workflow)
- [ ] Verify Renovate Bot GitHub App is installed (if `.github/renovate.json` exists)

See [Required GitHub Secrets](#required-github-secrets) for details.

### Repository Settings

- [ ] Enable branch protection for `main` branch
- [ ] Configure required status checks (CI workflows)
- [ ] Set up CODEOWNERS file if needed
- [ ] Review repository settings (Issues, Wikis, Discussions, etc.)

See [docs/development.md](docs/development.md) for recommended repository settings.

## Features

### Quality Automation

**Pre-commit hooks** enforce quality standards before code is committed:

- YAML syntax validation
- Markdown linting
- Conventional Commits validation
- Trailing whitespace removal
- End-of-file fixes

Add language-specific hooks for your project (linting, formatting, testing) by editing `.pre-commit-config.yaml`.

### CI/CD Pipelines

**GitHub Actions workflows** automate testing, linting, and releases:

- `ci.yml`: Runs tests and linters on every push and pull request
- `release.yml`: Automated semantic versioning and changelog generation

### Semantic Versioning

**Automated releases** using semantic-release:

- Analyzes commits using Conventional Commits
- Bumps version automatically (major.minor.patch)
- Generates CHANGELOG.md
- Creates GitHub releases

**Note:** This template starts at `v0.1.0` for demonstration. When starting your project:

1. Delete existing tags: `git tag -d $(git tag -l)`
2. Remove `CHANGELOG.md` if it exists
3. Your first release will start at the appropriate version based on your commit types

### Automated Dependency Management

**Renovate Bot** keeps dependencies up to date with conservative, controlled updates:

- Automatically creates pull requests for dependency updates
- Conservative configuration: no auto-merge, manual review required
- Rate-limited to prevent PR spam (`prHourlyLimit: 2`, `prConcurrentLimit: 10`)
- Scheduled updates run before 3am on Mondays (Pacific time)
- Dependency dashboard provides overview of all updates

**Installation:**

1. Install the [Renovate Bot GitHub App](https://github.com/apps/renovate)
2. Choose "All repositories" or "Select repositories" for your organization
3. Renovate will automatically detect the configuration file at `.github/renovate.json`
4. An onboarding PR will be created to confirm configuration

**Verification:**

To verify Renovate Bot is installed and active:

- **Using GitHub CLI:**
  - Check for Renovate-created PRs: `gh pr list --author "renovate[bot]" --limit 1`
  - Check organization installations: `gh api orgs/{org}/installations` and filter for Renovate app (app_id: 2912 or app_slug: renovate)
- **Using GitHub Web UI:**
  - Go to Repository Settings → Integrations → GitHub Apps
  - Verify "Renovate" appears in the installed apps list
  - Or check for PRs created by `renovate[bot]` user

**Note:** If `.github/renovate.json` exists but Renovate Bot is not installed, Renovate will not create dependency update PRs. Ensure the GitHub App is installed for Renovate to function.

**Configuration:**

The template includes a conservative Renovate configuration at `.github/renovate.json` that:

- Extends `config:recommended` with conservative overrides
- Requires manual review for all updates (no auto-merge)
- Routes all PRs to `@liatrio-labs/liatrio-labs-maintainers` for review
- Groups updates by type (major vs. minor/patch)
- Limits PR creation rate to prevent overwhelming maintainers

For detailed configuration research and rationale, see [docs/specs/02-spec-repository-infrastructure-improvements/RENOVATE-RESEARCH.md](docs/specs/02-spec-repository-infrastructure-improvements/RENOVATE-RESEARCH.md).

**Note:** Renovate uses a GitHub App for authentication and does not require any secrets to be configured.

### Template Audit Automation

**Repository Auditing** helps keep downstream repositories in sync with template updates:

- Comprehensive compliance checking against template standards
- Identifies missing files, configuration drift, and compliance gaps

**Manual Audit (AI Prompt):**

For audits, use the AI prompt directly:

1. Use the prompt at [`prompts/repository-template-audit.md`](prompts/repository-template-audit.md)
2. Provide `target_repository` argument (required)
3. Optionally provide `template_repository` argument (defaults to template)
4. The prompt performs comprehensive file presence and content comparison audits

**Audit Scope:**

The audit checks:

- Infrastructure files (`.pre-commit-config.yaml`, `.gitignore`, `LICENSE`)
- GitHub configuration (`.github/CODEOWNERS`, `.github/SECURITY.md`, issue/PR templates)
- Workflow files (CI, release)
- Release configuration (Chainguard STS, semantic-release)
- Documentation (README, CONTRIBUTING, development docs)

For detailed audit methodology, see [`prompts/repository-template-audit.md`](prompts/repository-template-audit.md).

### Automated Dependency Management

**Renovate Bot** keeps dependencies up to date with conservative, controlled updates:

- Automatically creates pull requests for dependency updates
- Conservative configuration: no auto-merge, manual review required
- Rate-limited to prevent PR spam (`prHourlyLimit: 2`, `prConcurrentLimit: 10`)
- Scheduled updates run before 3am on Mondays (Pacific time)
- Dependency dashboard provides overview of all updates

**Installation:**

1. Install the [Renovate Bot GitHub App](https://github.com/apps/renovate)
2. Choose "All repositories" or "Select repositories" for your organization
3. Renovate will automatically detect the configuration file at `.github/renovate.json`
4. An onboarding PR will be created to confirm configuration

**Verification:**

To verify Renovate Bot is installed and active:

- **Using GitHub CLI:**
  - Check for Renovate-created PRs: `gh pr list --author "renovate[bot]" --limit 1`
  - Check organization installations: `gh api orgs/{org}/installations` and filter for Renovate app (app_id: 2912 or app_slug: renovate)
- **Using GitHub Web UI:**
  - Go to Repository Settings → Integrations → GitHub Apps
  - Verify "Renovate" appears in the installed apps list
  - Or check for PRs created by `renovate[bot]` user

**Note:** If `.github/renovate.json` exists but Renovate Bot is not installed, Renovate will not create dependency update PRs. Ensure the GitHub App is installed for Renovate to function.

**Configuration:**

The template includes a conservative Renovate configuration at `.github/renovate.json` that:

- Extends `config:recommended` with conservative overrides
- Requires manual review for all updates (no auto-merge)
- Routes all PRs to `@liatrio-labs/liatrio-labs-maintainers` for review
- Groups updates by type (major vs. minor/patch)
- Limits PR creation rate to prevent overwhelming maintainers

For detailed configuration research and rationale, see [`docs/specs/02-spec-repository-infrastructure-improvements/RENOVATE-RESEARCH.md`](docs/specs/02-spec-repository-infrastructure-improvements/RENOVATE-RESEARCH.md).

**Note:** Renovate uses a GitHub App for authentication and does not require any secrets to be configured.

### Template Audit Automation

**Repository Auditing** helps keep downstream repositories in sync with template updates:

- Comprehensive compliance checking against template standards
- Identifies missing files, configuration drift, and compliance gaps

**Manual Audit (AI Prompt):**

For audits, use the AI prompt directly:

1. Use the prompt at [`prompts/repository-template-audit.md`](prompts/repository-template-audit.md)
2. Provide `target_repository` argument (required)
3. Optionally provide `template_repository` argument (defaults to template)
4. The prompt performs comprehensive file presence and content comparison audits

**Audit Scope:**

The audit checks:

- Infrastructure files (`.pre-commit-config.yaml`, `.gitignore`, `LICENSE`)
- GitHub configuration (`.github/CODEOWNERS`, `.github/SECURITY.md`, issue/PR templates)
- Workflow files (CI, release)
- Release configuration (Chainguard STS, semantic-release)
- Documentation (README, CONTRIBUTING, development docs)

For detailed audit methodology, see [`prompts/repository-template-audit.md`](prompts/repository-template-audit.md).

## Required GitHub Secrets

The following secrets must be configured at the **organization level** (already set up for Liatrio repositories):

### Octo STS (Chainguard)

Required for semantic-release workflow authentication (`.github/workflows/release.yml`).

- Configured at the organization level via Chainguard Octo STS
- Provides short-lived tokens for GitHub Actions workflows
- Configuration file: `.github/chainguard/main-semantic-release.sts.yaml`
- **Important:** Update the `subject_pattern` in this file to match your repository

## Changing the License

This template uses the **Apache License, Version 2.0** by default. To change the license:

1. Delete the existing `LICENSE` file
2. Add your preferred license file (MIT, BSD, GPL, etc.)
3. Update the license badge in this README
4. Update copyright attributions in source files if applicable

Common license resources:

- [Choose a License](https://choosealicense.com/)
- [GitHub License Templates](https://github.com/github/choosealicense.com/tree/gh-pages/_licenses)
- [SPDX License List](https://spdx.org/licenses/)

## Documentation

- [Contributing Guidelines](CONTRIBUTING.md) - Development workflow, conventional commits, and pre-commit hooks
- [Code of Conduct](CODE_OF_CONDUCT.md) - Community expectations and reporting guidance
- [Development Setup](docs/development.md) - Local setup, environment variables, and repository settings

## Support

For questions or issues with this template:

- Open an issue in this repository
- Contact the Liatrio DevOps team

## License

Copyright 2025 Liatrio

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
