# 02-spec-repository-infrastructure-improvements.md

## Implementation Status

**Completed Work:**

- ✅ **Renovate Bot Research**: Research document completed at `docs/specs/02-spec-repository-infrastructure-improvements/RENOVATE-RESEARCH.md` with configuration recommendations and file location determination (`.github/renovate.json`)
- ✅ **Template Audit Manual Prompt**: AI prompt completed at `prompts/repository-template-audit.md` with comprehensive audit workflow following prompt engineering patterns
- ✅ **Cursor Agent Research**: Trigger pattern and implementation approach determined (`@cursor` pattern, same event structure as Claude/OpenCode, Cursor CLI installation via curl script)

**Remaining Work:**

- ⏳ Renovate Bot configuration file creation (`.github/renovate.json`)
- ⏳ SECURITY.md file creation
- ⏳ CODEOWNERS file creation
- ⏳ Cursor agent workflow integration
- ⏳ Template audit CI workflow
- ⏳ SDD workflow documentation

## Introduction/Overview

This specification enhances the open-source template repository with essential infrastructure improvements, security documentation, automated dependency management, code ownership controls, AI workflow integration, and template audit capabilities. These enhancements will improve the template's usefulness, security posture, and maintainability for Liatrio teams creating new repositories from this template. The improvements follow established patterns from existing Liatrio repositories and industry best practices.

## Goals

1. **Security Documentation** - Add a SECURITY.md file using the standard GitHub Security Policy template to facilitate vulnerability reporting
2. **Automated Dependency Management** - Configure Renovate Bot with conservative settings (no auto-merge) to keep dependencies updated while maintaining control
3. **Code Ownership** - Set up CODEOWNERS file to ensure all code changes are reviewed by the appropriate team
4. **AI Workflow Integration** - Add Cursor agent workflow following the pattern of existing Claude and OpenCode workflows
5. **Template Audit Automation** - Create both a CI action and manual script/prompt for auditing downstream repositories against the template
6. **SDD Workflow Documentation** - Document how specs are created and managed using the Liatrio Spec-Driven Development workflow

## User Stories

**As a** security-conscious maintainer
**I want to** have a SECURITY.md file available in the template
**So that** downstream repositories can easily implement vulnerability reporting procedures

**As a** repository maintainer
**I want** Renovate Bot configured conservatively (no auto-merge)
**So that** I maintain control over dependency updates while receiving automated update notifications

**As a** Liatrio developer using this template
**I want** CODEOWNERS configured with the liatrio-labs-maintainers team
**So that** all code changes automatically require review from the maintainer team

**As a** developer working with AI tools
**I want** Cursor agent integrated into GitHub workflows
**So that** I can leverage Cursor's AI capabilities directly from pull requests and issues

**As a** template repository administrator
**I want** automated tools to audit downstream repositories
**So that** repositories created from this template can be kept in sync with template updates

**As a** developer exploring this repository
**I want** documentation explaining how specs are created
**So that** I understand the workflow methodology used for this project

## Demoable Units of Work

### [Unit 1]: Security Documentation and Code Ownership

**Purpose:** Establish security reporting procedures and code ownership rules for the template repository
**Demo Criteria:**

- SECURITY.md file exists at repository root with standard GitHub Security Policy template content
- `.github/CODEOWNERS` file exists with `@liatrio-labs/liatrio-labs-maintainers` team entry
- Both files are properly formatted and accessible

**Proof Artifacts:**

- File: `SECURITY.md` in repository root
- File: `.github/CODEOWNERS` with correct team reference
- CLI: `cat SECURITY.md` shows vulnerability reporting template
- CLI: `cat .github/CODEOWNERS` shows maintainer team entry

### [Unit 2]: Renovate Bot Configuration

**Purpose:** Enable automated dependency management with conservative settings that maintain human oversight
**Demo Criteria:**

- Renovate Bot configuration file exists at `.github/renovate.json` (per research findings)
- Configuration uses conservative settings: no auto-merge, PRs for all updates
- Documentation added explaining Renovate setup and configuration approach
- Research findings documented comparing with other Liatrio repos

**Proof Artifacts:**

- File: `.github/renovate.json` with conservative configuration
- File: Documentation section explaining Renovate setup
- File: `docs/specs/02-spec-repository-infrastructure-improvements/RENOVATE-RESEARCH.md` with research findings
- CLI: `cat .github/renovate.json` shows conservative settings

### [Unit 3]: Cursor Agent Workflow Integration

**Purpose:** Integrate Cursor agent into GitHub Actions workflows following established AI workflow patterns
**Demo Criteria:**

- Workflow file `.github/workflows/cursor.yml` exists following pattern of `claude.yml` and `opencode-gpt-5-codex.yml`
- Workflow triggers on `issue_comment`, `pull_request_review_comment`, `issues`, and `pull_request_review` events
- Workflow checks for `@cursor` mention in comment body (matches official Cursor GitHub integration pattern)
- Workflow validates author association (OWNER, MEMBER, COLLABORATOR) for security
- Workflow installs Cursor CLI and runs `cursor-agent` command
- Documentation added explaining Cursor agent usage, secrets setup, and command triggers
- Guide provided for setting up `CURSOR_API_KEY` secret

**Proof Artifacts:**

- File: `.github/workflows/cursor.yml` with proper configuration matching Claude/OpenCode patterns
- File: Documentation section explaining Cursor agent setup and usage
- URL: GitHub Actions tab shows cursor workflow available
- Documentation: Guide for setting up `CURSOR_API_KEY` secret
- Test: Comment `@cursor help` on a PR or issue triggers the workflow

### [Unit 4]: Template Audit Automation

**Purpose:** Provide both automated and manual tools for auditing downstream repositories against the template
**Demo Criteria:**

- CI workflow exists with monthly schedule and `workflow_dispatch` trigger for on-demand execution
- CI workflow invokes Cursor agent (or similar AI workflow) with the audit prompt from `prompts/repository-template-audit.md`
- Audit prompt contains all audit logic and performs comprehensive checks: file presence and content differences
- Manual AI prompt exists for on-demand repository audits
- AI prompt created for auditing repositories (including those not created from template)
- Documentation explains how to use both automated (CI workflow) and manual (direct prompt usage) audit methods
- Reference provided to AI prompt engineering guide

**Proof Artifacts:**

- File: `.github/workflows/template-audit.yml` with monthly schedule and workflow_dispatch that invokes AI agent
- File: `prompts/repository-template-audit.md` - AI prompt containing audit logic following prompt engineering patterns
- Documentation: Usage guide for both audit methods

### [Unit 5]: SDD Workflow Documentation

**Purpose:** Document how specifications in this repository are created and managed using the Liatrio Spec-Driven Development workflow
**Demo Criteria:**

- README.md exists in `docs/specs/` directory
- README explains the SDD workflow methodology
- Link provided to `https://github.com/liatrio-labs/spec-driven-workflow` repository
- Documentation is clear and accessible

**Proof Artifacts:**

- File: `docs/specs/README.md` with SDD workflow explanation
- URL: Link to spec-driven-workflow repository
- CLI: `cat docs/specs/README.md` shows workflow documentation

## Functional Requirements

1. **The system shall** include a SECURITY.md file at the repository root using the standard GitHub Security Policy template format

2. **The system shall** create a CODEOWNERS file at `.github/CODEOWNERS` with `@liatrio-labs/liatrio-labs-maintainers` as the only entry

3. **The system shall** include Renovate Bot configuration file at `.github/renovate.json` with conservative settings:
   - No automatic merging enabled
   - Pull requests created for all dependency updates
   - Extends `config:recommended` (no organization preset exists)
   - Configuration documented with research findings comparing to other Liatrio repositories
   - Research findings documented in `docs/specs/02-spec-repository-infrastructure-improvements/RENOVATE-RESEARCH.md`

4. **The system shall** include a Cursor agent workflow file (`.github/workflows/cursor.yml`) that:
   - Follows the pattern of existing `claude.yml` and `opencode-gpt-5-codex.yml` workflows
   - Triggers on `issue_comment`, `pull_request_review_comment`, `issues`, and `pull_request_review` events
   - Uses `@cursor` trigger pattern (matches official Cursor GitHub integration)
   - Checks comment body for `@cursor` mention and validates author association (OWNER, MEMBER, COLLABORATOR)
   - Installs Cursor CLI via official installation script
   - Runs `cursor-agent` command with `CURSOR_API_KEY` secret for authentication
   - Includes documentation for setup and usage

5. **The system shall** provide template audit automation in two forms:
   - Automated CI action that runs monthly on a schedule and supports on-demand execution via `workflow_dispatch`
   - CI workflow invokes Cursor agent (or similar AI workflow) with the audit prompt, which performs comprehensive checks including both file presence and content differences
   - Manual AI prompt for on-demand repository audits located at `prompts/repository-template-audit.md`

6. **The system shall** include an AI prompt for auditing repositories that:
   - Can audit repositories created from this template
   - Can audit repositories not created from this template
   - Follows patterns from the AI prompt engineering quick reference guide
   - Located at `prompts/repository-template-audit.md` with structured workflow phases and Chain-of-Verification

7. **The system shall** include documentation in `docs/specs/README.md` explaining:
   - How specifications are created and managed
   - Reference to the Liatrio SDD workflow repository
   - Link to `https://github.com/liatrio-labs/spec-driven-workflow`

8. **The system shall** document all new infrastructure components with:
   - Setup instructions
   - Required secrets and configuration
   - Usage examples where applicable

## Non-Goals (Out of Scope)

1. **Auto-merge for Renovate Bot** - This feature will NOT include automatic merging of dependency updates, maintaining conservative control

2. **Organization-level Renovate configuration** - This specification does NOT require modifying organization-level Renovate presets; repository-level configuration only

3. **Complete template sync automation** - This feature will NOT implement full automated syncing of all template changes; audit tools identify differences, manual review required

4. **Custom Cursor agent implementation** - This feature will NOT create a custom Cursor integration; uses official Cursor GitHub Actions workflow

5. **Detailed SDD workflow tutorial** - The SDD documentation will NOT include full tutorials; references the official workflow repository instead

6. **Security scanning tools** - This specification does NOT add additional security scanning tools beyond SECURITY.md documentation

7. **Multi-team CODEOWNERS** - The CODEOWNERS file will NOT include multiple teams; single maintainer team only

## Design Considerations

No specific design requirements identified. All components are configuration files, workflow files, documentation, and scripts that follow established repository patterns and GitHub conventions.

## Technical Considerations

1. **Renovate Bot Configuration Location**:
   - Configuration file location determined: `.github/renovate.json` (per research findings, aligns with repository structure conventions)
   - Research completed: See `docs/specs/02-spec-repository-infrastructure-improvements/RENOVATE-RESEARCH.md`
   - Configuration strategy: No organization-level preset exists; extend `config:recommended` with conservative overrides
   - Conservative settings identified: `automerge: false`, rate limits, scheduling, maintainer team reviewers/assignees

2. **Cursor Agent Integration**:
   - Trigger pattern: `@cursor` (matches official Cursor GitHub integration pattern)
   - Events: `issue_comment`, `pull_request_review_comment`, `issues`, `pull_request_review` (same as Claude/OpenCode)
   - Implementation: Install Cursor CLI via curl script, run `cursor-agent` command with `CURSOR_API_KEY` secret
   - Security: Check author association (OWNER, MEMBER, COLLABORATOR) to prevent unauthorized triggers
   - Follows pattern of `claude.yml` and `opencode-gpt-5-codex.yml` for consistency
   - Requires `CURSOR_API_KEY` secret (organization-level recommended)

3. **Template Audit Implementation**:
   - CI action should use GitHub Actions workflow with monthly schedule and `workflow_dispatch` for on-demand execution
   - CI workflow invokes Cursor agent (or similar AI workflow) with the audit prompt from `prompts/repository-template-audit.md`
   - Audit prompt contains all audit logic: comprehensive audit checking both file presence and content differences
   - Manual AI prompt completed: `prompts/repository-template-audit.md` following AI prompt engineering patterns
   - Prompt includes structured workflow phases, Chain-of-Verification, and comprehensive audit coverage
   - Prompt supports both template-derived and independent repositories
   - CI workflow passes target repository as argument to the AI agent; the prompt handles all audit work
   - Should be configurable to run against any repository URL via workflow_dispatch input

4. **Secret Management**:
   - Cursor agent requires secret: `CURSOR_API_KEY` (confirmed)
   - Documentation must explain secret setup at organization or repository level
   - Follow existing patterns from `README.md` secrets documentation

5. **CODEOWNERS File Format**:
   - Must use GitHub CODEOWNERS syntax: `* @liatrio-labs/liatrio-labs-maintainers`
   - Location must be `.github/CODEOWNERS` (not root `CODEOWNERS`) per GitHub standards

6. **SECURITY.md Template**:
   - Use standard GitHub Security Policy template
   - Should be customizable by downstream repositories (may include placeholders or guidance)

## Success Metrics

1. **Security Documentation**: SECURITY.md file exists and is accessible, providing clear vulnerability reporting path

2. **Dependency Management**: Renovate Bot configuration file exists at `.github/renovate.json` with documented conservative settings; research findings documented in `RENOVATE-RESEARCH.md` for review

3. **Code Ownership**: CODEOWNERS file exists and GitHub recognizes it (verified via test PR requiring maintainer approval)

4. **AI Workflow Integration**: Cursor workflow file exists, follows established patterns, and includes complete documentation for setup and usage

5. **Template Audit Capability**: Manual AI prompt exists at `prompts/repository-template-audit.md`; automated CI workflow with monthly schedule and `workflow_dispatch` support still needed (workflow invokes AI agent with prompt); comprehensive audit scope (file presence and content differences) defined in prompt; both methods documented, enabling template synchronization workflows

6. **Workflow Documentation**: SDD workflow README exists in `docs/specs/` with clear explanation and link to workflow repository

7. **Documentation Completeness**: All new components have documentation explaining setup, configuration, and usage

## Open Questions

No open questions remain. All implementation details have been determined through research and best practices.

**Resolved Questions:**

- ✅ **Renovate Config File Location**: Determined to be `.github/renovate.json` per research findings (aligns with repository structure conventions)
- ✅ **Renovate Organization Preset**: Confirmed that `liatrio-labs` organization does not have a Renovate preset; configuration will extend `config:recommended` directly
- ✅ **Template Audit Manual Prompt**: Completed at `prompts/repository-template-audit.md` with comprehensive audit workflow
- ✅ **Template Audit Frequency**: CI workflow will run monthly on a schedule and support on-demand execution via `workflow_dispatch`
- ✅ **Template Audit Scope**: CI audit will perform comprehensive checks including both file presence and content differences
- ✅ **Cursor Secret Name**: Confirmed to use `CURSOR_API_KEY` for authentication
- ✅ **Cursor Agent Trigger Pattern**: Determined to use `@cursor` trigger pattern (matches official Cursor GitHub integration); workflow follows same event structure and security checks as Claude/OpenCode workflows
