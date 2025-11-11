# 02-tasks-repository-infrastructure-improvements.md

## Relevant Files

- `SECURITY.md` - Security policy file at repository root using standard GitHub Security Policy template format
- `.github/CODEOWNERS` - Code ownership file specifying maintainer team for all code changes
- `.github/renovate.json` - Renovate Bot configuration file with conservative settings (no auto-merge)
- `.github/workflows/cursor.yml` - Cursor agent GitHub Actions workflow following Claude/OpenCode patterns
- `.github/workflows/template-audit.yml` - Template audit CI workflow with monthly schedule and workflow_dispatch
- `README.md` - Main repository README to be updated with Renovate, Cursor, and template audit documentation
- `docs/specs/README.md` - SDD workflow documentation explaining how specs are created and managed
- `docs/specs/02-spec-repository-infrastructure-improvements/RENOVATE-RESEARCH.md` - Research document (already exists, referenced in documentation)

### Notes

- Follow existing workflow patterns from `.github/workflows/claude.yml` and `.github/workflows/opencode-gpt-5-codex.yml` for consistency
- Use standard GitHub Security Policy template format for SECURITY.md
- CODEOWNERS file must use GitHub CODEOWNERS syntax: `* @liatrio-labs/liatrio-labs-maintainers`
- Renovate configuration should extend `config:recommended` with conservative overrides based on research document
- Cursor workflow should install CLI via official curl script and use `CURSOR_API_KEY` secret
- Template audit workflow should invoke Cursor agent (or similar AI workflow) with the audit prompt from `prompts/repository-template-audit.md`; the prompt contains all audit logic, so the workflow just needs to trigger it with the target repository argument
- All documentation updates should follow existing README.md formatting and structure patterns
- Run `markdownlint --fix` on all markdown files after creation/modification

## Tasks

- [x] 1.0 Create Security Documentation and Code Ownership Files
  - Demo Criteria: SECURITY.md file exists at repository root with standard GitHub Security Policy template content; `.github/CODEOWNERS` file exists with `@liatrio-labs/liatrio-labs-maintainers` team entry; both files are properly formatted and accessible
  - Proof Artifact(s): File: `SECURITY.md` in repository root; File: `.github/CODEOWNERS` with correct team reference; CLI: `cat SECURITY.md` shows vulnerability reporting template; CLI: `cat .github/CODEOWNERS` shows maintainer team entry
  - [x] 1.1 Create `SECURITY.md` at repository root using standard GitHub Security Policy template format with vulnerability reporting instructions
  - [x] 1.2 Create `.github/CODEOWNERS` file with `* @liatrio-labs/liatrio-labs-maintainers` entry following GitHub CODEOWNERS syntax
  - [x] 1.3 Run markdownlint on SECURITY.md to ensure proper formatting
  - [x] 1.4 Verify both files are accessible and properly formatted using CLI commands

- [x] 2.0 Create Renovate Bot Configuration
  - Demo Criteria: Renovate Bot configuration file exists at `.github/renovate.json` with conservative settings (no auto-merge, PRs for all updates); configuration extends `config:recommended`; documentation added explaining Renovate setup and configuration approach
  - Proof Artifact(s): File: `.github/renovate.json` with conservative configuration; File: Documentation section explaining Renovate setup; File: `docs/specs/02-spec-repository-infrastructure-improvements/RENOVATE-RESEARCH.md` with research findings (already exists); CLI: `cat .github/renovate.json` shows conservative settings
  - [x] 2.1 Create `.github/renovate.json` with conservative configuration extending `config:recommended`, including: `automerge: false`, rate limits (`prHourlyLimit: 2`, `prConcurrentLimit: 10`), scheduling, dependency dashboard, and maintainer team reviewers/assignees based on research document
  - [x] 2.2 Add Renovate Bot documentation section to `README.md` explaining installation, configuration approach, and reference to research document
  - [x] 2.3 Update "Required GitHub Secrets" section in README.md if Renovate requires any secrets (note: Renovate uses GitHub App, no secrets needed)
  - [x] 2.4 Verify JSON syntax and configuration using CLI: `cat .github/renovate.json`

- [x] 3.0 Create Cursor Agent Workflow Integration
  - Demo Criteria: Workflow file `.github/workflows/cursor.yml` exists following pattern of `claude.yml` and `opencode-gpt-5-codex.yml`; workflow triggers on `issue_comment`, `pull_request_review_comment`, `issues`, and `pull_request_review` events; workflow checks for `@cursor` mention in comment body and validates author association (OWNER, MEMBER, COLLABORATOR); workflow installs Cursor CLI and runs `cursor-agent` command; documentation added explaining Cursor agent usage, secrets setup, and command triggers
  - Proof Artifact(s): File: `.github/workflows/cursor.yml` with proper configuration matching Claude/OpenCode patterns; File: Documentation section explaining Cursor agent setup and usage; URL: GitHub Actions tab shows cursor workflow available; Documentation: Guide for setting up `CURSOR_API_KEY` secret; Test: Comment `@cursor help` on a PR or issue triggers the workflow
  - [x] 3.1 Create `.github/workflows/cursor.yml` following the pattern of `claude.yml` and `opencode-gpt-5-codex.yml` with: same event triggers (`issue_comment`, `pull_request_review_comment`, `issues`, `pull_request_review`), `@cursor` trigger pattern check, author association validation (OWNER, MEMBER, COLLABORATOR), concurrency control, and timeout settings
  - [x] 3.2 Add workflow step to install Cursor CLI using official curl script: `curl https://cursor.sh/install.sh | bash` and add to PATH
  - [x] 3.3 Add workflow step to run `cursor-agent` command with `CURSOR_API_KEY` secret from environment variables
  - [x] 3.4 Configure appropriate permissions (contents: read, pull-requests: write, issues: write) for Cursor workflow
  - [x] 3.5 Add Cursor agent documentation section to `README.md` explaining usage (`@cursor` trigger), setup requirements, and secret configuration
  - [x] 3.6 Add `CURSOR_API_KEY` to "Required GitHub Secrets" section in README.md with setup instructions
  - [x] 3.7 Verify workflow YAML syntax and test workflow appears in GitHub Actions tab

- [x] 4.0 Create Template Audit CI Workflow
  - Demo Criteria: CI workflow exists with monthly schedule and `workflow_dispatch` trigger for on-demand execution; workflow invokes Cursor agent (or similar AI workflow) with the audit prompt from `prompts/repository-template-audit.md`; workflow passes target repository as input; documentation explains how to use both automated (CI workflow) and manual (AI prompt) audit methods
  - Proof Artifact(s): File: `.github/workflows/template-audit.yml` with monthly schedule and workflow_dispatch; File: `prompts/repository-template-audit.md` - AI prompt for audits (already exists); Documentation: Usage guide for both audit methods; URL: GitHub Actions tab shows template-audit workflow available
  - [x] 4.1 Create `.github/workflows/template-audit.yml` with monthly schedule (`schedule: cron: '0 0 1 * *'`) and `workflow_dispatch` trigger with input parameter for target repository
  - [x] 4.2 Add workflow step to checkout repository and read the audit prompt from `prompts/repository-template-audit.md`
  - [x] 4.3 Add workflow step to invoke Cursor agent (or similar AI workflow) with the audit prompt, passing target repository as argument; the prompt contains all audit logic and will perform comprehensive checks
  - [x] 4.4 Configure workflow to use same Cursor CLI installation and `CURSOR_API_KEY` secret as the cursor.yml workflow (or reference existing cursor workflow if possible)
  - [x] 4.5 Add template audit documentation section to `README.md` explaining both automated (CI workflow triggers monthly or on-demand) and manual (use AI prompt directly) audit methods, including how to trigger each
  - [x] 4.6 Reference existing manual prompt at `prompts/repository-template-audit.md` in documentation with instructions for manual usage
  - [x] 4.7 Verify workflow YAML syntax and test workflow appears in GitHub Actions tab

- [x] 5.0 Create SDD Workflow Documentation
  - Demo Criteria: README.md exists in `docs/specs/` directory; README explains the SDD workflow methodology; link provided to `https://github.com/liatrio-labs/spec-driven-workflow` repository; documentation is clear and accessible
  - Proof Artifact(s): File: `docs/specs/README.md` with SDD workflow explanation; URL: Link to spec-driven-workflow repository; CLI: `cat docs/specs/README.md` shows workflow documentation
  - [x] 5.1 Create `docs/specs/README.md` explaining how specifications are created and managed using the Liatrio Spec-Driven Development workflow
  - [x] 5.2 Include link to `https://github.com/liatrio-labs/spec-driven-workflow` repository for detailed workflow documentation
  - [x] 5.3 Explain the workflow phases: spec creation, task generation, implementation, and validation
  - [x] 5.4 Reference existing spec examples in the directory structure
  - [x] 5.5 Run markdownlint on the new README.md file
  - [x] 5.6 Verify documentation is accessible and clear using CLI: `cat docs/specs/README.md`
