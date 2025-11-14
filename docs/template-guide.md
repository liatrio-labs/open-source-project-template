# Template Customization Guide

This guide provides detailed instructions for customizing the Liatrio Open Source Template for your project.

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
- [ ] See [CONTRIBUTING.md](../CONTRIBUTING.md) for examples (ESLint, Ruff, golangci-lint, etc.)
- [ ] Configure hook versions to match your project's requirements

### Documentation

- [ ] Update `README.md` with project-specific information
- [ ] Customize `CONTRIBUTING.md` with project-specific contribution guidelines
- [ ] Update `CODE_OF_CONDUCT.md` with project-specific reporting contacts and enforcement owners
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

See [docs/development.md](development.md) for recommended repository settings.

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
  - Check organization installations: `gh api orgs/{org}/installations` and filter for Renovate app by app_slug: renovate
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

For detailed configuration research and rationale, see [docs/specs/02-spec-repository-infrastructure-improvements/RENOVATE-RESEARCH.md](specs/02-spec-repository-infrastructure-improvements/RENOVATE-RESEARCH.md).

**Note:** Renovate uses a GitHub App for authentication and does not require any secrets to be configured.

### Template Audit Automation

**Repository Auditing** helps keep downstream repositories in sync with template updates:

- Comprehensive compliance checking against template standards
- Identifies missing files, configuration drift, and compliance gaps

**Manual Audit (AI Prompt):**

For audits, use the AI prompt directly:

1. Use the prompt at [`prompts/repository-template-audit.md`](../prompts/repository-template-audit.md)
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

For detailed audit methodology, see [`prompts/repository-template-audit.md`](../prompts/repository-template-audit.md).

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
3. Update the license badge in your `README.md`
4. Update copyright attributions in source files if applicable

Common license resources:

- [Choose a License](https://choosealicense.com/)
- [GitHub License Templates](https://github.com/github/choosealicense.com/tree/gh-pages/_licenses)
- [SPDX License List](https://spdx.org/licenses/)
