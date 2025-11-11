# 00-spec-github-template-extraction.md

## Introduction/Overview

This specification describes the creation of a GitHub template repository (`open-source-template`) derived from the `spec-driven-workflow` project. The template will preserve the opinionated developer experience, tooling, and CI/CD automation while removing product-specific functionality. This enables Liatrio teams to bootstrap new projects with battle-tested quality gates, automation, and documentation standards from day one.

The source repository (`spec-driven-workflow`) provides an AI-assisted spec-to-delivery workflow with robust developer tooling including placeholders for linting/formatting, comprehensive pre-commit hooks, semantic versioning automation, and GitHub Actions CI/CD pipelines. The template extraction will distill these capabilities into a reusable starting point.

The source repository is located at `~/Liatrio/repos/spec-driven-workflow`. Reference files in it as necessary.

## Goals

1. **Extract reusable developer experience infrastructure** from `spec-driven-workflow` into a standalone GitHub template repository
2. **Maintain all quality gates and automation** (CI/CD, pre-commit hooks, semantic-release) while removing domain-specific code
3. **Provide clear, actionable documentation** for Liatrio teams to customize and deploy the template
4. **Enable immediate productivity** with language-agnostic workflow templates and quality automation ready to customize
5. **Preserve AI workflow integrations** (Claude, OpenCode GPT-5 Codex) with clear setup instructions

## User Stories

### US-1: Template Consumer (Liatrio Developer)

**As a** Liatrio developer starting a new project
**I want to** create a repository from the `open-source-template`
**So that** I inherit proven tooling, CI/CD, and documentation without manual setup

**Acceptance Criteria:**

- Can click "Use this template" on GitHub to create new repository
- Pre-commit hooks install and pass without errors on initial repository state
- README provides clear next steps for customization
- Documentation explains how to customize CI/CD workflows for specific language/framework

### US-2: Project Maintainer

**As a** project maintainer
**I want** semantic versioning and changelog generation to work automatically
**So that** releases are consistent and documented without manual intervention

**Acceptance Criteria:**

- Semantic-release workflow triggers after CI passes
- Version bumps follow Conventional Commits
- Changelog updates automatically

### US-3: Quality Assurance Engineer

**As a** QA engineer or code reviewer
**I want** consistent quality gates and automation
**So that** code quality remains high across all projects

**Acceptance Criteria:**

- Pre-commit hooks prevent committing non-compliant code (YAML, markdown, commit messages)
- Documentation provides guidance on adding language-specific quality checks
- CI/CD workflow templates include placeholders for test and lint jobs

### US-4: AI-Assisted Developer

**As a** developer using AI coding assistants
**I want** pre-configured Claude and OpenCode workflows
**So that** I can leverage AI assistance with proper CI integration

**Acceptance Criteria:**

- Claude workflow documented and functional
- OpenCode GPT-5 Codex workflow documented and functional
- Clear instructions for setting up required secrets

## Demoable Units of Work

### Slice 1: Minimal Template Repository Structure

**Purpose:** Create basic repository skeleton that passes all checks
**Users:** Template maintainers, initial reviewers
**Demo Criteria:**

- Repository exists at `~/Liatrio/repos/open-source-template`
- Contains all required directories and configuration files
- Pre-commit hooks pass on initial state

**Proof Artifacts:**

- CLI: `cd ~/Liatrio/repos/open-source-template && pre-commit run --all-files`
- Expected output: All hooks pass
- File structure visible via `tree -L 3`

### Slice 2: Pre-commit Hooks & Code Quality

**Purpose:** Ensure all code quality automation works out of the box
**Users:** Developers setting up local environment
**Demo Criteria:**

- Pre-commit hooks install successfully
- Language-agnostic hooks enforce YAML validation, markdown linting, trailing whitespace removal
- Conventional commits validated via commitlint
- All hooks pass on initial repository state

**Proof Artifacts:**

- CLI: `pre-commit install && pre-commit run --all-files`
- Expected output: All hooks pass with "Passed" status
- Test commit message validation: `echo "invalid message" | pre-commit run commitlint --hook-stage commit-msg` (should fail)

### Slice 3: CI/CD Pipeline Functionality

**Purpose:** Verify GitHub Actions workflows are properly configured and execute successfully
**Users:** DevOps engineers, template consumers
**Demo Criteria:**

- `ci.yml` contains placeholder workflow with working jobs
- Placeholder jobs run successfully (e.g., `echo "Insert your tests here"`)
- All workflow files have valid YAML syntax
- Documentation clearly explains customization steps
- No Codecov integration (removed per requirements)

**Proof Artifacts:**

- GitHub Actions tab showing green checkmarks for placeholder jobs
- Workflow logs showing successful execution: `echo "Insert your tests here"` and `echo "Insert your lint checks here"`
- YAML validation passes for all workflow files
- Documentation includes clear CI/CD customization instructions

### Slice 4: Semantic Release Automation

**Purpose:** Automate versioning and changelog generation
**Users:** Release managers, maintainers
**Demo Criteria:**

- `release.yml` triggers after CI completion
- Semantic-release analyzes commits and bumps version
- Changelog updates with new version

**Proof Artifacts:**

- GitHub Release page showing auto-generated release notes
- `CHANGELOG.md` with version history
- Git tag matching semantic version (e.g., `v0.1.0`)

### Slice 5: Documentation & Onboarding

**Purpose:** Provide clear guidance for template customization
**Users:** New project teams adopting the template
**Demo Criteria:**

- README explains template usage and quick start
- Key customization points highlighted (project name, dependencies, secrets)
- CONTRIBUTING guide covers development workflow
- GitHub issue/PR templates generalized

**Proof Artifacts:**

- README.md rendered in GitHub with clear sections
- Documentation checklist covering: project name update, secret configuration, license review
- Test documentation by having non-author follow setup steps

## Functional Requirements

### FR-1: Repository Structure

1. Create repository at `~/Liatrio/repos/open-source-template`
2. Include `docs/` directory with development documentation
3. Maintain `.github/workflows/` directory with all CI/CD workflow templates
4. Include `.github/ISSUE_TEMPLATE/` and `.github/pull_request_template.md`
5. Include `.gitignore` with common patterns (user adds language-specific patterns)
6. Repository structure supports any language/framework (no language-specific directories)

### FR-2: Development Environment Setup

1. Document environment setup process in README (users customize for their chosen stack)
2. Include guidance on dependency management best practices
3. Provide examples of common setup patterns (package managers, virtual environments, etc.)
4. Document pre-commit as a required development tool
5. Include placeholder sections for language-specific tooling configuration

### FR-3: Code Quality & Pre-commit Hooks

1. Configure `.pre-commit-config.yaml` with language-agnostic hooks:
   - YAML syntax validation
   - Markdown linting
   - Conventional Commits validation (commitlint)
   - Trailing whitespace removal
   - End-of-file fixer
   - Configurable branch commit prevention (not enforced by default per user requirement 9b)
   - Include commented autoupdate schedule: `# ci: autoupdate: schedule: quarterly`
2. Ensure all pre-commit hooks pass on initial repository state
3. Document pre-commit installation and customization in README
4. Provide guidance on adding language-specific hooks (linting, formatting, testing)

### FR-4: CI/CD Workflows

1. **`.github/workflows/ci.yml`**: Working placeholder CI workflow
   - Include test and lint jobs that run successfully with placeholder commands (e.g., `echo "Insert your tests here"`)
   - Use basic GitHub Actions (checkout, etc.) to prove structure works
   - Paths-ignore rules for release-generated files
   - Include commented examples and documentation on customization
   - Provide links to GitHub Actions marketplace for language-specific actions
2. **`.github/workflows/release.yml`**: Semantic-release workflow triggered by CI completion
   - Use semantic-release tooling to analyze commits
   - Generate changelog, bump version, create GitHub release
   - Document that Octo STS is configured at org level (no repo-level setup needed)
   - Include placeholders for language-specific build/release steps
   - Start template at version `v0.1.0` with documentation on how users should reset versioning
3. **`.github/chainguard/main-semantic-release.sts.yaml`**: Chainguard Octo STS configuration
   - Include template configuration file
   - Document that Octo STS is set up at org level
   - Document subject customization for new repositories
4. **`.github/workflows/claude.yml`**: AI coding assistant workflow with setup documentation
5. **`.github/workflows/opencode-gpt-5-codex.yml`**: OpenAI Codex workflow with setup documentation

### FR-5: Documentation

1. **README.md**:
   - Template purpose and value proposition
   - Quick start instructions (clone, setup environment, install pre-commit)
   - Customization checklist (project name, language/framework setup, CI/CD, secrets, license)
   - Link to GitHub's "Use this template" documentation
   - Guidance on choosing and configuring language-specific tooling
2. **CONTRIBUTING.md**:
   - Conventional Commits guide with examples
   - Branch naming conventions
   - Development workflow (setup, testing, pre-commit usage)
   - Placeholder sections for language-specific contribution guidelines
3. **docs/development.md**:
   - Local development setup guidance
   - Environment variables best practices
   - Testing and quality assurance approach
   - Recommended branch protection rules (based on `spec-driven-workflow` settings)
   - Placeholder sections for project-specific customizations

### FR-6: GitHub Template Configuration

1. Enable "Template repository" setting in GitHub
2. Provide generalized issue templates (bug report, feature request)
3. Provide generalized pull request template
4. Document required GitHub secrets in README (note: all are configured at org level):
   - `CLAUDE_CODE_OAUTH_TOKEN` (for Claude workflow)
   - `OPENAI_API_KEY_FOR_OPENCODE` (for OpenCode workflow)
   - Octo STS (for semantic-release, configured at org level)

### FR-7: Repository Settings Automation

1. **Capture settings from `spec-driven-workflow` via `gh` CLI**:
   - Use `gh api` to fetch branch protection rules from source repository
   - Use `gh api` to fetch repository settings (issues, wikis, discussions, etc.)
   - Document current settings in `docs/development.md` as recommended configuration
2. **Provide automation script for applying settings**:
   - Create script/documentation for applying settings via `gh api` PATCH requests
   - Include commands to configure: `has_issues`, `has_wiki`, `has_discussions`, etc.
   - Include commands to apply branch protection rules
   - Script should be idempotent and safe to run multiple times
3. **Document manual configuration steps as fallback**:
   - Provide step-by-step instructions for applying settings via GitHub UI
   - Include screenshots or links to relevant GitHub documentation

### FR-8: Template Validation

1. Ensure `.pre-commit-config.yaml` runs successfully on initial repository state
2. Validate all workflow files have correct YAML syntax
3. Ensure all documentation links and references are valid
4. Verify GitHub template settings are properly configured
5. Verify CI workflow runs successfully with placeholder jobs

### FR-9: Licensing & Attribution

1. Maintain Apache 2.0 license
2. Include LICENSE file with copyright attribution to Liatrio
3. Document how to change license if needed in README

## Non-Goals (Out of Scope)

1. **Spec-driven workflow tooling**: Remove MCP server, prompt templates, and SDD-specific features
2. **Product-specific functionality**: No domain logic from `spec-driven-workflow`
3. **Codecov integration**: Removed per user requirement 8
4. **Interactive setup script**: Not included (basic README guidance only per requirement 6b)
5. **Multiple example project types**: Only minimal placeholder, no CLI/library/API examples (per requirement 7d)
6. **Language-specific tooling**: Template should be language-agnostic; users add their preferred tech stack
7. **External user documentation**: Tailored for Liatrio internal teams (per requirement 11a)

## Design Considerations

### Repository Layout

```text
open-source-template/
├── .github/
│   ├── workflows/
│   │   ├── ci.yml (placeholder workflow structure)
│   │   ├── release.yml
│   │   ├── claude.yml
│   │   └── opencode-gpt-5-codex.yml
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.yml
│   │   └── feature_request.yml
│   ├── pull_request_template.md
│   └── chainguard/
│       └── main-semantic-release.sts.yaml
├── docs/
│   └── development.md
├── .pre-commit-config.yaml
├── .gitignore
├── LICENSE
├── README.md
└── CONTRIBUTING.md
```

**Note**: Users will add their own source code directories, test directories, and language-specific configuration files (e.g., `package.json`, `go.mod`, `pyproject.toml`, etc.) based on their chosen technology stack.

### Configuration Approach

- Template provides workflow **structure** and **placeholders** rather than language-specific implementations
- Users customize CI/CD pipelines based on their chosen technology stack
- Pre-commit hooks configured with language-agnostic checks (YAML validation, markdown linting, commitlint)
- Language-specific hooks (linting, formatting, testing) added by users during customization

### Documentation Tone

- Concise, actionable instructions
- Assumes basic Git and software development knowledge (Liatrio internal teams)
- Links to external documentation (GitHub, semantic-release) for detailed concepts

## Technical Considerations

### Core Dependencies

- **Version control**: Git
- **CI/CD**: GitHub Actions
- **Pre-commit framework**: For enforcing quality gates locally
- **Semantic release**: For automated versioning and changelog generation

### Semantic Release Configuration

- Must be configured for GitHub releases
- Uses Octo STS for authentication (configured at Liatrio org level)
- Template starts at version `v0.1.0` with guidance for users to reset versioning
- Language-specific build/release steps added by users during customization

### Pre-commit Hook Flexibility

- `no-commit-to-branch` hook should be configurable (enabled via local config, not enforced by default)
- Document how to enable/disable in CONTRIBUTING.md

### AI Workflow Integration

- Claude and OpenCode workflows require repository secrets
- Should include clear documentation on obtaining and configuring secrets
- Workflows should gracefully handle missing secrets (fail with helpful error messages)

### Repository Settings Automation with `gh` CLI

- Use `gh api` GraphQL and REST endpoints to query and apply repository settings
- Branch protection rules can be fetched/applied via: `gh api repos/{owner}/{repo}/branches/{branch}/protection`
- Repository settings (issues, wikis, etc.) can be updated via: `gh api -X PATCH repos/{owner}/{repo} -F has_issues=true -F has_wiki=true`
- Settings automation should be documented and optionally scripted for ease of use
- Placeholders `{owner}` and `{repo}` in API paths get auto-replaced with current repository values

## Success Metrics

### Immediate Success (Template Creation)

1. ✅ All pre-commit hooks pass on initial code: `pre-commit run --all-files` exits 0
2. ✅ Template repository structure is complete with all workflows and documentation
3. ✅ GitHub "Use this template" button visible and functional
4. ✅ Documentation clearly guides users on customization steps

### Adoption Success

1. 🎯 At least 2 Liatrio teams create projects from template
2. 🎯 Template users can complete setup in <30 minutes (from template creation to first commit)
3. 🎯 Zero critical bugs in template infrastructure (CI, pre-commit, dependencies)

### Quality Success (Ongoing)

1. 🎯 All template-derived projects maintain green CI status
2. 🎯 Semantic-release successfully creates versions for template-derived projects
3. 🎯 Documentation questions account for <10% of template-related support issues

---

**Document Status**: Ready for Implementation
**Last Updated**: 2025-10-29
**Author**: Generated via `/generate-spec` workflow
**Target Audience**: Liatrio Internal Development Teams
