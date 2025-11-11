# 02-spec-repository-infrastructure-improvements.md

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

- Renovate Bot configuration file exists (e.g., `renovate.json` or `.github/renovate.json`)
- Configuration uses conservative settings: no auto-merge, PRs for all updates
- Documentation added explaining Renovate setup and configuration approach
- Research findings included for review (comparing with other Liatrio repos)

**Proof Artifacts:**

- File: Configuration file (location TBD based on research)
- File: Documentation section explaining Renovate setup
- File: Research notes comparing with other Liatrio repositories
- CLI: `cat renovate.json` (or appropriate config file) shows conservative settings

### [Unit 3]: Cursor Agent Workflow Integration

**Purpose:** Integrate Cursor agent into GitHub Actions workflows following established AI workflow patterns
**Demo Criteria:**

- Workflow file `.github/workflows/cursor.yml` exists following pattern of `claude.yml` and `opencode-gpt-5-codex.yml`
- Documentation added explaining Cursor agent usage, secrets setup, and command triggers
- Workflow responds to appropriate triggers (issues, PRs, comments) similar to existing AI workflows
- Guide provided for additional secrets setup requirements

**Proof Artifacts:**

- File: `.github/workflows/cursor.yml` with proper configuration
- File: Documentation section explaining Cursor agent setup and usage
- URL: GitHub Actions tab shows cursor workflow available
- Documentation: Guide for setting up `CURSOR_API_KEY` or equivalent secret

### [Unit 4]: Template Audit Automation

**Purpose:** Provide both automated and manual tools for auditing downstream repositories against the template
**Demo Criteria:**

- CI workflow exists for periodic template audits that can open PRs with necessary changes
- Manual script/prompt exists for on-demand repository audits
- AI prompt created for auditing repositories (including those not created from template)
- Documentation explains how to use both automated and manual audit methods
- Reference provided to AI prompt engineering guide

**Proof Artifacts:**

- File: `.github/workflows/template-audit.yml` (or similar) for CI automation
- File: Script or prompt file for manual audits (location TBD)
- File: AI prompt following patterns from `~/.config/ai_prompts/ai-prompt-engineering-quick-reference.md`
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

3. **The system shall** include Renovate Bot configuration file with conservative settings:
   - No automatic merging enabled
   - Pull requests created for all dependency updates
   - Configuration documented with research findings comparing to other Liatrio repositories

4. **The system shall** include a Cursor agent workflow file (`.github/workflows/cursor.yml`) that:
   - Follows the pattern of existing `claude.yml` and `opencode-gpt-5-codex.yml` workflows
   - Triggers on appropriate GitHub events (issues, PRs, comments)
   - Requires necessary permissions and secrets
   - Includes documentation for setup and usage

5. **The system shall** provide template audit automation in two forms:
   - Automated CI action that runs periodically and can open PRs with necessary changes
   - Manual script/prompt for on-demand repository audits

6. **The system shall** include an AI prompt for auditing repositories that:
   - Can audit repositories created from this template
   - Can audit repositories not created from this template
   - Follows patterns from the AI prompt engineering quick reference guide

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
   - Configuration file can be placed in root (`renovate.json`) or `.github/renovate.json` based on repository conventions
   - Research needed to determine if other Liatrio repos use org-level presets that should be extended

2. **Cursor Agent Integration**:
   - Must research official Cursor CLI GitHub Actions documentation
   - May require organization-level secret configuration similar to Claude and OpenCode
   - Should follow existing workflow patterns for consistency with `claude.yml` and `opencode-gpt-5-codex.yml`

3. **Template Audit Implementation**:
   - CI action should use GitHub Actions workflow
   - Manual script/prompt can reference AI prompt engineering patterns
   - May need to handle authentication for accessing downstream repositories
   - Should be configurable to run against any repository URL

4. **Secret Management**:
   - Cursor agent may require new secret: `CURSOR_API_KEY` or similar
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

2. **Dependency Management**: Renovate Bot configuration file exists with documented conservative settings and research findings provided for review

3. **Code Ownership**: CODEOWNERS file exists and GitHub recognizes it (verified via test PR requiring maintainer approval)

4. **AI Workflow Integration**: Cursor workflow file exists, follows established patterns, and includes complete documentation for setup and usage

5. **Template Audit Capability**: Both automated (CI) and manual audit tools exist and are documented, enabling template synchronization workflows

6. **Workflow Documentation**: SDD workflow README exists in `docs/specs/` with clear explanation and link to workflow repository

7. **Documentation Completeness**: All new components have documentation explaining setup, configuration, and usage

## Open Questions

1. **Renovate Configuration Research**: What configuration patterns do other top-level Liatrio repositories use for Renovate Bot? Should we extend an organization preset or use standalone configuration?

2. **Cursor Agent Trigger Pattern**: What trigger pattern should the Cursor workflow use? Should it follow exact pattern of Claude (`@claude`) and OpenCode (`/oc-codex`), or use a different trigger pattern like `@cursor`?

3. **Template Audit Frequency**: How often should the automated CI template audit run? Weekly, monthly, or on-demand via workflow_dispatch?

4. **Audit Scope**: What specific aspects of the template should the audit check? Should it check file presence, content differences, or both?

5. **Cursor Secret Name**: What will the required secret be named for Cursor agent? Is it `CURSOR_API_KEY` or something else?

6. **Renovate Config File Location**: Should Renovate configuration be in root (`renovate.json`) or `.github/renovate.json`? Are there Liatrio conventions to follow?

No open questions at this time that would block specification approval, but research and clarification needed during implementation phase.
