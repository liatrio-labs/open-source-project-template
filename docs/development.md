# Development Guide

This document provides detailed guidance for local development setup, testing, and quality assurance.

## Table of Contents

- [Local Development Setup](#local-development-setup)
- [Environment Variables](#environment-variables)
- [Testing and QA](#testing-and-qa)
- [Recommended Repository Settings](#recommended-repository-settings)
- [Branch Protection Rules](#branch-protection-rules)
- [Project-Specific Customizations](#project-specific-customizations)

## Local Development Setup

### Prerequisites

<!-- Add language/framework-specific prerequisites here -->

**Required for all projects:**

- Git
- [pre-commit](https://pre-commit.com/) for quality gates

**Language-specific prerequisites (add as needed):**

```bash
# Node.js projects
# - Node.js (LTS version recommended)
# - npm or yarn

# Python projects
# - Python 3.x
# - pip or poetry

# Go projects
# - Go 1.x or later

# Rust projects
# - Rust and Cargo (via rustup)

# Java projects
# - JDK 11+ and Maven or Gradle
```

### Initial Setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/liatrio/[your-repo-name].git
   cd [your-repo-name]
   ```

2. **Install dependencies**

   ```bash
   # Add your project's dependency installation commands here
   # Examples:
   # npm ci                          # Node.js
   # pip install -r requirements.txt # Python
   # go mod download                 # Go
   # cargo fetch                     # Rust
   # mvn install                     # Java (Maven)
   ```

3. **Install pre-commit hooks**

   ```bash
   # macOS
   brew install pre-commit

   # Ubuntu/Debian
   sudo apt install pre-commit

   # pip (all platforms)
   pip install pre-commit

   # Install hooks
   pre-commit install
   ```

4. **Set up environment variables**

   See [Environment Variables](#environment-variables) section below.

5. **Verify setup**

   ```bash
   # Run tests
   # [Add your project's test command]

   # Run pre-commit hooks
   pre-commit run --all-files
   ```

## Environment Variables

### Local Development

Create a `.env` file (ignored by git) for local development:

```bash
# .env (DO NOT commit this file)

# Add your project-specific environment variables here
# Examples:

# Database connection
# DATABASE_URL=postgresql://localhost:5432/mydb

# API keys (use dummy values for local dev)
# API_KEY=dev-key-12345

# Feature flags
# ENABLE_FEATURE_X=true
```

### Best Practices

- **Never commit secrets** to version control
- Use `.env` files for local development (add to `.gitignore`)
- Use environment-specific configurations (dev, staging, prod)
- Document all required environment variables in this file
- Provide example values in `.env.example` (committed to repo)

### Required Environment Variables

<!-- Document your project's required environment variables here -->

| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| `DATABASE_URL` | Database connection string | Yes (prod) | `sqlite:///local.db` (dev) |
| `API_KEY` | External API key | Yes (prod) | `dev-key` (dev) |
| `LOG_LEVEL` | Logging verbosity | No | `INFO` |

## Testing and QA

### Running Tests

```bash
# Add your project's test commands here
# Examples:

# Unit tests
# npm test                    # Node.js
# pytest tests/unit           # Python
# go test ./...               # Go
# cargo test                  # Rust

# Integration tests
# npm run test:integration    # Node.js
# pytest tests/integration    # Python

# End-to-end tests
# npm run test:e2e            # Node.js
# pytest tests/e2e            # Python

# With coverage
# npm test -- --coverage      # Node.js
# pytest --cov=src tests/     # Python
# go test -cover ./...        # Go
# cargo tarpaulin             # Rust
```

### Quality Checks

```bash
# Run linters
# npm run lint                # Node.js
# ruff check .                # Python
# golangci-lint run           # Go
# cargo clippy                # Rust

# Run formatters
# npm run format              # Node.js
# ruff format .               # Python
# gofmt -w .                  # Go
# cargo fmt                   # Rust

# Run all pre-commit hooks
pre-commit run --all-files
```

### Testing Guidelines

- Write tests for all new features and bug fixes
- Maintain test coverage above 80%
- Use descriptive test names that explain intent
- Follow the Arrange-Act-Assert (AAA) pattern
- Mock external dependencies in unit tests
- Use integration tests for testing component interactions
- Include end-to-end tests for critical user flows

### Test Organization

```text
tests/
├── unit/           # Fast, isolated unit tests
├── integration/    # Tests with database, API calls, etc.
├── e2e/           # Full application workflow tests
└── fixtures/      # Test data and mocks
```

## Recommended Repository Settings

The following repository settings are recommended for projects using this template:

### General Settings

```bash
# Apply these settings via GitHub UI (Settings → General) or gh CLI:

# Enable features
gh api -X PATCH repos/{owner}/{repo} \
  -F has_issues=true \
  -F has_wiki=true \
  -F has_discussions=false

# Merge settings
gh api -X PATCH repos/{owner}/{repo} \
  -F allow_squash_merge=true \
  -F allow_merge_commit=false \
  -F allow_rebase_merge=false \
  -F delete_branch_on_merge=true

# Automatically delete head branches after PRs are merged
# (Set delete_branch_on_merge=true above)
```

### Manual Configuration Steps

1. **Enable "Template repository"** (if this is a template)
   - Settings → General → Template repository checkbox

2. **Configure merge button**
   - Settings → General → Pull Requests
   - ✓ Allow squash merging (recommended for clean history)
   - ☐ Allow merge commits (disabled - enforces clean, linear history via squash merges only)
   - ☐ Allow rebase merging (disabled - enforces clean, linear history via squash merges only)
   - ✓ Automatically delete head branches

3. **Set up CODEOWNERS** (optional)
   - Create `.github/CODEOWNERS` file
   - Define code ownership patterns

## Branch Protection Rules

### Recommended Protection for `main` Branch

Apply these settings via GitHub UI (Settings → Branches → Add rule) or gh CLI:

```bash
# Enable branch protection
gh api -X PUT repos/{owner}/{repo}/branches/main/protection \
  -F required_status_checks[strict]=true \
  -F required_status_checks[contexts][]=test \
  -F required_status_checks[contexts][]=lint \
  -F enforce_admins=false \
  -F required_pull_request_reviews[dismiss_stale_reviews]=true \
  -F required_pull_request_reviews[require_code_owner_reviews]=false \
  -F required_pull_request_reviews[required_approving_review_count]=1 \
  -F restrictions=null
```

### Protection Rules Breakdown

- **Require pull request before merging**: All changes must go through PR
- **Require approvals**: 1 approving review required
- **Dismiss stale reviews**: New commits dismiss previous approvals
- **Require status checks**: CI must pass (test + lint jobs)
- **Require branches to be up to date**: Enforce linear history
- **Do not allow bypassing**: Enforce rules for everyone (optional)

### Manual Configuration Steps

1. Go to Settings → Branches → Add rule
2. Branch name pattern: `main`
3. Enable:
   - ✓ Require a pull request before merging
     - ✓ Require approvals: 1
     - ✓ Dismiss stale pull request approvals when new commits are pushed
   - ✓ Require status checks to pass before merging
     - ✓ Require branches to be up to date before merging
     - Search and add: `test`, `lint` (your CI job names)
   - ✓ Require conversation resolution before merging
4. Save changes

## Project-Specific Customizations

<!-- Add project-specific development guidance here -->

### Custom Scripts

```bash
# Add project-specific scripts and commands here
# Examples:

# Database migrations
# npm run migrate              # Node.js
# alembic upgrade head         # Python (Alembic)
# goose up                     # Go (Goose)

# Seed database
# npm run seed                 # Node.js
# python scripts/seed_db.py    # Python

# Generate documentation
# npm run docs                 # Node.js
# cargo doc --open             # Rust
```

### IDE Configuration

#### VS Code

Recommended extensions:

- ESLint / Pylint / golangci-lint
- Prettier / Black / rustfmt
- GitLens
- Better Comments

#### JetBrains IDEs

Recommended plugins:

- Pre-commit integration
- EditorConfig support
- Conventional Commit plugin

### Debugging

```bash
# Add debugging instructions here
# Examples:

# Node.js
# node --inspect-brk server.js

# Python
# python -m pdb script.py

# Go
# dlv debug

# Rust
# rust-gdb target/debug/binary
```

### Performance Profiling

```bash
# Add profiling instructions here
# Examples:

# Node.js
# node --prof app.js

# Python
# python -m cProfile script.py

# Go
# go test -cpuprofile cpu.prof -memprofile mem.prof

# Rust
# cargo flamegraph
```

## Troubleshooting

### Common Issues

#### Pre-commit hooks fail

```bash
# Update pre-commit hooks
pre-commit autoupdate

# Run hooks manually
pre-commit run --all-files

# Skip hooks temporarily (not recommended)
SKIP=hook-name git commit -m "message"
```

#### CI fails but tests pass locally

- Ensure all dependencies are locked (package-lock.json, poetry.lock, etc.)
- Check environment variables in CI configuration
- Review CI logs for differences from local environment

#### Merge conflicts

```bash
# Update your branch with latest main
git fetch origin
git rebase origin/main

# Resolve conflicts and continue
git rebase --continue
```

## Additional Resources

- [CONTRIBUTING.md](../CONTRIBUTING.md) - Contribution guidelines
- [README.md](../README.md) - Project overview and quick start
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [pre-commit Documentation](https://pre-commit.com/)
- [Conventional Commits](https://www.conventionalcommits.org/)
