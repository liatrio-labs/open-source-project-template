# Task List: GitHub Template Repository Extraction

This task list breaks down the implementation of the specification defined in `00-spec-github-template-extraction.md`. The goal is to extract a reusable GitHub template repository from `spec-driven-workflow` that preserves developer experience, tooling, and CI/CD automation while removing product-specific functionality.

## Relevant Files

**Created in `open-source-template/`:**

- `.github/workflows/ci.yml` - Placeholder CI workflow with test and lint jobs (language-agnostic)
- `.github/workflows/release.yml` - Semantic release automation workflow with language-agnostic placeholders
- `.github/workflows/claude.yml` - Claude Code AI integration workflow
- `.github/workflows/opencode-gpt-5-codex.yml` - OpenCode GPT-5 Codex workflow
- `.github/chainguard/main-semantic-release.sts.yaml` - Chainguard Octo STS configuration with customization docs
- `.releaserc.json` - Semantic-release configuration with conventional commit rules
- `.github/ISSUE_TEMPLATE/bug_report.yml` - Generalized bug report template
- `.github/ISSUE_TEMPLATE/feature_request.yml` - Generalized feature request template
- `.github/ISSUE_TEMPLATE/config.yml` - Issue template configuration
- `.github/pull_request_template.md` - Generalized PR template
- `.pre-commit-config.yaml` - Language-agnostic pre-commit hooks configuration
- `.markdownlint.yaml` - Markdown linting configuration
- `.gitignore` - Common ignore patterns for version control
- `README.md` - Template documentation with quick start and customization guide
- `CONTRIBUTING.md` - Contribution guidelines and workflow documentation
- `LICENSE` - Apache 2.0 license file
- `docs/development.md` - Development setup and best practices documentation
- `docs/repository-settings.md` - Documentation of captured repository settings and automation
- `scripts/apply-repo-settings.sh` - Optional automation script for applying repository settings via gh CLI

**Source files to reference from `~/Liatrio/repos/spec-driven-workflow/`:**

- `.github/workflows/ci.yml` - Source CI workflow to adapt
- `.github/workflows/release.yml` - Source semantic release workflow
- `.github/workflows/claude.yml` - Source Claude workflow
- `.github/workflows/opencode-gpt-5-codex.yml` - Source OpenCode workflow
- `.github/ISSUE_TEMPLATE/*` - Source issue templates to generalize
- `.github/pull_request_template.md` - Source PR template
- `.pre-commit-config.yaml` - Source pre-commit configuration
- `README.md` - Source README for structure reference
- `CONTRIBUTING.md` - Source contribution guidelines
- `LICENSE` - Apache 2.0 license to copy

### Notes

- All files will be created in the `/home/damien/Liatrio/repos/open-source-template/` directory
- Source repository is located at `~/Liatrio/repos/spec-driven-workflow/`
- Template should be language-agnostic; Python-specific tooling will be removed
- Pre-commit hooks will focus on language-agnostic checks (YAML, markdown, commitlint)
- CI/CD workflows will use placeholder commands with clear documentation for customization
- Repository settings automation (task 6.0) uses `gh api` to capture branch protection rules and settings

## Tasks

- [x] 1.0 Create minimal repository structure with core configuration files
  - Demo Criteria: "Repository has all required directories (.github/, docs/) and base configuration files (.gitignore, LICENSE with Apache 2.0 and Liatrio attribution, .markdownlint.yaml); pre-commit hooks can be installed successfully"
  - Proof Artifact(s): "CLI: `tree -L 3` shows directory structure; `ls -la` shows .gitignore, LICENSE, .markdownlint.yaml; `cat LICENSE` shows Apache 2.0 with Liatrio copyright; `pre-commit install` succeeds"
  - [x] 1.1 Create core directory structure: `.github/workflows/`, `.github/ISSUE_TEMPLATE/`, `.github/chainguard/`, `docs/`, `scripts/`
  - [x] 1.2 Copy `LICENSE` file from `~/Liatrio/repos/spec-driven-workflow/LICENSE` and verify Apache 2.0 license with Liatrio copyright attribution
  - [x] 1.3 Create `.gitignore` file with common ignore patterns (temporary files, IDE configs, OS files, logs) - make it language-agnostic (no Python/Node/etc. specific entries)
  - [x] 1.4 Copy `.markdownlint.yaml` from source repository to maintain consistent markdown linting rules
  - [x] 1.5 Verify directory structure with `tree -L 3` and confirm all base configuration files exist with `ls -la`

- [x] 2.0 Configure language-agnostic pre-commit hooks and code quality automation
  - Demo Criteria: "Pre-commit hooks install and run successfully on initial repository state; all hooks pass with no errors; configuration includes YAML validation, markdown linting, commitlint, trailing whitespace removal, end-of-file fixer, and commented autoupdate schedule"
  - Proof Artifact(s): "CLI: `pre-commit run --all-files` exits 0 with all hooks showing 'Passed' status; `grep 'autoupdate.*schedule.*quarterly' .pre-commit-config.yaml` finds commented schedule; all language-agnostic hooks present"
  - [x] 2.1 Copy `.pre-commit-config.yaml` from `~/Liatrio/repos/spec-driven-workflow/.pre-commit-config.yaml` to use as starting point
  - [x] 2.2 Remove Python-specific hooks (ruff, local pytest hook) from the configuration
  - [x] 2.3 Keep and verify language-agnostic hooks: pre-commit-hooks (trailing-whitespace, end-of-file-fixer, check-yaml), markdownlint-cli2, commitlint
  - [x] 2.4 Add commented autoupdate schedule: `# ci: autoupdate: schedule: quarterly` at the top of the file
  - [x] 2.5 Configure `no-commit-to-branch` hook but make it optional (document how to enable in local `.pre-commit-config.local.yaml`)
  - [x] 2.6 Install pre-commit hooks with `pre-commit install` and run `pre-commit run --all-files` to verify all hooks pass on initial state
  - [x] 2.7 Add section to CONTRIBUTING.md documenting how to add language-specific hooks (with examples: eslint, black, golangci-lint)

- [x] 3.0 Create functional CI/CD workflow templates with placeholder jobs
  - Demo Criteria: "CI workflow YAML is valid and contains working placeholder jobs with clear customization documentation"
  - Proof Artifact(s): "CLI: `yamllint .github/workflows/ci.yml` passes; workflow contains placeholder echo commands; GitHub Actions validation passes (or local validation)"
  - [x] 3.1 Copy `.github/workflows/ci.yml` from source repository as starting point
  - [x] 3.2 Remove Python-specific jobs and steps (pytest with coverage, ruff linting, Python version matrix, uv setup)
  - [x] 3.3 Create placeholder `test` job with steps: checkout, echo "Insert your tests here", echo "Examples: pytest, npm test, go test, cargo test"
  - [x] 3.4 Create placeholder `lint` job with steps: checkout, echo "Insert your lint checks here", echo "Examples: eslint, ruff, golangci-lint, clippy"
  - [x] 3.5 Keep paths-ignore rules for release-generated files (CHANGELOG.md, version files, lock files)
  - [x] 3.6 Add inline YAML comments explaining customization points and linking to GitHub Actions Marketplace
  - [x] 3.7 Validate YAML syntax with `yamllint .github/workflows/ci.yml` or GitHub Actions workflow validator

- [x] 4.0 Configure semantic release automation and AI workflow integrations
  - Demo Criteria: "Release workflow is configured for semantic-release starting at v0.1.0 with user reset documentation; Claude and OpenCode workflows are present with setup documentation; Octo STS configuration file exists with subject customization docs"
  - Proof Artifact(s): "Files exist: `.github/workflows/release.yml`, `.github/workflows/claude.yml`, `.github/workflows/opencode-gpt-5-codex.yml`, `.github/chainguard/main-semantic-release.sts.yaml`; YAML validation passes for all workflows; release.yml or docs mention v0.1.0 and versioning reset instructions"
  - [x] 4.1 Copy `.github/workflows/release.yml` from source and remove Python-specific build/release steps (uv build, PyPI publish)
  - [x] 4.2 Keep semantic-release core functionality and add inline comments for language-specific build/release step placeholders
  - [x] 4.3 Add comment or documentation in release.yml about template starting at v0.1.0 and how users should reset versioning for their projects
  - [x] 4.4 Copy `.github/workflows/claude.yml` from source repository (no modifications needed if already generic)
  - [x] 4.5 Copy `.github/workflows/opencode-gpt-5-codex.yml` from source repository
  - [x] 4.6 Copy or create `.github/chainguard/main-semantic-release.sts.yaml` Octo STS configuration file from source
  - [x] 4.7 Add documentation comment in Octo STS file explaining how to customize the subject for new repositories
  - [x] 4.8 Validate all workflow YAML files with `yamllint .github/workflows/*.yml`

- [x] 5.0 Create comprehensive documentation and GitHub templates
  - Demo Criteria: "README explains template usage with quick start, documents GitHub secrets (CLAUDE_CODE_OAUTH_TOKEN, OPENAI_API_KEY_FOR_OPENCODE, Octo STS), and includes license change instructions; CONTRIBUTING covers development workflow and conventional commits; issue/PR templates are generalized; docs/development.md provides detailed setup guidance; all documentation links are valid; 'Template repository' setting enabled in GitHub"
  - Proof Artifact(s): "Files exist and render correctly: `README.md`, `CONTRIBUTING.md`, `docs/development.md`, `.github/ISSUE_TEMPLATE/*.yml`, `.github/pull_request_template.md`; all markdown passes linting; link checker validates all URLs; README contains secrets documentation and license change instructions; GitHub repository shows 'Template repository' badge/setting enabled"
  - [x] 5.1 Create `README.md` with sections: template purpose/value proposition, quick start (clone, setup, pre-commit install), "Use this template" button instructions, customization checklist (project name, language/framework, CI/CD, secrets, license)
  - [x] 5.2 Add GitHub secrets documentation section to README covering: `CLAUDE_CODE_OAUTH_TOKEN`, `OPENAI_API_KEY_FOR_OPENCODE`, and Octo STS (note: configured at org level)
  - [x] 5.3 Add "Changing the License" section to README explaining how to replace Apache 2.0 with another license if needed
  - [x] 5.4 Create `CONTRIBUTING.md` with: Conventional Commits guide and examples, branch naming conventions, development workflow (setup, pre-commit, testing), placeholder sections for language-specific contribution guidelines
  - [x] 5.5 Create `docs/development.md` with: local development setup guidance, environment variables best practices, testing/QA approach, recommended branch protection rules (from spec-driven-workflow), placeholder sections for project-specific customizations
  - [x] 5.6 Copy issue templates from `~/Liatrio/repos/spec-driven-workflow/.github/ISSUE_TEMPLATE/` and generalize (remove Python/project-specific fields, make language-agnostic)
  - [x] 5.7 Copy PR template from source and generalize (remove Python-specific checklist items like "uv run pytest", make language-agnostic)
  - [x] 5.8 Create `.github/ISSUE_TEMPLATE/config.yml` to disable blank issues and link to documentation
  - [x] 5.9 Run `pre-commit run --all-files` to validate all markdown files pass linting
  - [x] 5.10 Use a link checker (e.g., markdown-link-check) to validate all documentation URLs are valid
  - [x] 5.11 Enable "Template repository" setting in GitHub repository settings (Settings → General → Template repository checkbox)

- [x] 6.0 Capture and document repository settings automation
  - Demo Criteria: "Repository settings from spec-driven-workflow are captured and documented; automation script/commands provided for applying settings; manual configuration steps documented as fallback"
  - Proof Artifact(s): "CLI: `gh api repos/liatrio/spec-driven-workflow` returns settings; `docs/repository-settings.md` contains captured settings and gh commands; optional `scripts/apply-repo-settings.sh` is idempotent"
  - [x] 6.1 Use `gh api repos/liatrio/spec-driven-workflow` to fetch and save current repository settings (has_issues, has_wiki, has_discussions, etc.)
  - [x] 6.2 Use `gh api repos/liatrio/spec-driven-workflow/branches/main/protection` to fetch and save branch protection rules for main branch
  - [x] 6.3 Create `docs/repository-settings.md` documenting captured settings as recommended configuration for template users
  - [x] 6.4 Add `gh api` PATCH command examples to `docs/repository-settings.md` for applying settings (e.g., `gh api -X PATCH repos/{owner}/{repo} -F has_issues=true`)
  - [x] 6.5 Add `gh api` PUT command examples for applying branch protection rules with captured configuration
  - [x] 6.6 (Optional) Create `scripts/apply-repo-settings.sh` bash script that applies settings via gh CLI; ensure script is idempotent and safe to run multiple times
  - [x] 6.7 Add manual configuration section to `docs/repository-settings.md` with step-by-step GitHub UI instructions and screenshots/links as fallback
  - [x] 6.8 Test that gh commands work by running them in dry-run mode or against a test repository
