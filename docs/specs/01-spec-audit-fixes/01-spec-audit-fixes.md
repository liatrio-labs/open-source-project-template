# 01-spec-audit-fixes.md

## Introduction/Overview

This specification addresses audit findings from three independent AI code reviews to prepare the repository for public release. The audit identified critical issues including incorrect repository references, missing repository metadata, and opportunities to improve repository configuration and documentation. This spec will systematically address all audit findings (critical, high, medium, and low priority) to ensure the template repository is properly configured, documented, and ready for use by Liatrio team members.

## Goals

1. **Correct all repository references** - Update incorrect references from `liatrio/open-source-template` to `liatrio-labs/open-source-project-template` throughout the codebase
2. **Document GitHub Action version monitoring** - Add clear guidance for monitoring `@latest` pinned actions, particularly `sst/opencode/github@latest`
3. **Enhance repository metadata** - Add repository description and topics to improve discoverability
4. **Validate and document repository settings** - Ensure branch protection and repository settings automation is properly documented and validated

## User Stories

**As a** template repository maintainer
**I want to** have all repository references correct and pointing to the actual repository location
**So that** badges, links, and documentation work correctly for Liatrio team members using the template

**As a** Liatrio developer using this template
**I want** the template to have accurate Liatrio-specific references and configuration
**So that** I can quickly set up new projects with correct organization settings and secrets

**As a** security-conscious developer
**I want** clear documentation about why certain GitHub Actions use `@latest` instead of pinned versions
**So that** I understand the risk trade-offs and monitoring requirements

**As a** open source contributor
**I want** repository metadata (description, topics) to be properly configured
**So that** I can discover and understand the repository's purpose easily

**As a** repository administrator
**I want** comprehensive documentation for repository settings automation
**So that** I can confidently apply recommended settings to new repositories

## Demoable Units of Work

### [Unit 1]: Repository Reference Corrections

**Purpose:** Fix all incorrect repository references to ensure badges, links, and documentation point to the correct repository location
**Demo Criteria:**

- All badge URLs in README.md point to `liatrio-labs/open-source-project-template`
- All repository references in issue templates point to correct repository
- All documentation links use correct repository path
- CHANGELOG.md links already point to correct repository (validate only)

**Proof Artifacts:**

- CLI: `grep -r "liatrio/open-source-template" .` returns zero matches (excluding tasks/ directory)
- README.md badges display correctly on GitHub
- Issue template config.yml links resolve correctly
- File list: README.md, .github/ISSUE_TEMPLATE/config.yml, scripts/apply-repo-settings.sh

### [Unit 2]: GitHub Action Version Documentation

**Purpose:** Document the monitoring approach for GitHub Actions using `@latest` and provide clear guidance on version management
**Demo Criteria:**

- Clear documentation explains why `sst/opencode/github@latest` uses `@latest`
- Documentation includes monitoring guidance and update process
- Documentation explains when to pin versions vs. use `@latest`
- Comment in workflow file references the documentation

**Proof Artifacts:**

- New `docs/github-actions.md` file explaining GitHub Action version strategy
- Updated comment in `.github/workflows/opencode-gpt-5-codex.yml` referencing `docs/github-actions.md`
- File list: `.github/workflows/opencode-gpt-5-codex.yml`, `docs/github-actions.md`

### [Unit 3]: Repository Metadata and Settings Documentation

**Purpose:** Add repository description, topics, and comprehensive documentation for repository settings automation
**Demo Criteria:**

- Repository description and topics documented with recommended values
- Repository settings script validated and documented
- Branch protection automation verified and documented
- Clear instructions for applying settings manually or via script

**Proof Artifacts:**

- Documentation section in `docs/repository-settings.md` with recommended repository description: "A battle-tested GitHub template repository with opinionated developer experience, quality gates, and CI/CD automation ready for customization"
- Documentation section with recommended topics: `automation`, `ci-cd`, `devops`, `github-actions`, `github-template`, `developer-tools`, `liatrio`, `pre-commit`, `semantic-release`
- Verification that `scripts/apply-repo-settings.sh` correctly handles branch protection
- Updated `docs/repository-settings.md` with metadata configuration guidance (manual-only approach)
- File list: `docs/repository-settings.md`, `scripts/apply-repo-settings.sh`

## Functional Requirements

1. **FR-1: Repository Reference Updates**
   - The system shall update all occurrences of `liatrio/open-source-template` to `liatrio-labs/open-source-project-template` in documentation files
   - The system shall exclude `tasks/` directory from reference updates (as per user requirement)
   - The system shall update badge URLs in README.md to use correct repository path
   - The system shall update issue template configuration URLs to use correct repository path
   - The system shall validate that CHANGELOG.md links already point to correct repository

2. **FR-2: GitHub Action Version Documentation**
   - The system shall create a new `docs/github-actions.md` file for GitHub Actions documentation (to support future extensibility)
   - The system shall document the rationale for using `@latest` for `sst/opencode/github` action
   - The system shall provide monitoring guidance for `@latest` pinned actions
   - The system shall document the process for identifying stable versions to pin
   - The system shall update workflow file comments to reference the documentation file

3. **FR-3: Repository Metadata Documentation**
   - The system shall document the recommended repository description: "A battle-tested GitHub template repository with opinionated developer experience, quality gates, and CI/CD automation ready for customization"
   - The system shall document recommended repository topics: `automation`, `ci-cd`, `devops`, `github-actions`, `github-template`, `developer-tools`, `liatrio`, `pre-commit`, `semantic-release`
   - The system shall provide instructions for setting repository metadata via GitHub UI and gh CLI
   - The system shall include metadata configuration in repository settings documentation
   - The system shall note that repository metadata configuration remains manual-only (no script automation)

4. **FR-4: Repository Settings Validation**
   - The system shall verify that `scripts/apply-repo-settings.sh` correctly implements branch protection
   - The system shall verify that `scripts/apply-repo-settings.sh` correctly sets `delete_branch_on_merge=true`
   - The system shall document the script's capabilities and limitations
   - The system shall provide manual configuration alternatives for all automated settings

5. **FR-5: Documentation Consistency**
   - The system shall ensure all documentation references use consistent repository naming
   - The system shall ensure all Liatrio-specific references are accurate and consistent
   - The system shall ensure documentation cross-references are accurate and complete

## Non-Goals (Out of Scope)

1. **Internal task files removal** - Task files in `tasks/` directory are excluded from changes per user requirement
2. **SECURITY.md creation** - Security policy file creation is excluded per user requirement
3. **GitHub Action version pinning** - We will document monitoring approach but not pin `sst/opencode/github@latest` to a specific version
4. **Repository settings automation changes** - We will validate and document existing automation but not modify the script unless critical issues are found
5. **CHANGELOG.md link updates** - CHANGELOG.md already contains correct links; validation only, no changes needed
6. **CODEOWNERS file creation** - Low priority item excluded from this spec
7. **.env.example file creation** - Low priority item excluded from this spec
8. **Dependabot configuration** - Medium priority item excluded from this spec

## Design Considerations

No specific UI/UX design requirements. This spec focuses on documentation updates, reference corrections, and configuration documentation. All changes are text-based and documentation-focused.

## Technical Considerations

1. **Repository Reference Updates**
   - Use case-sensitive search and replace for `liatrio/open-source-template` → `liatrio-labs/open-source-project-template`
   - Exclude `tasks/` directory from automated updates
   - Preserve existing CHANGELOG.md links (already correct)

2. **Script Validation**
   - Verify `scripts/apply-repo-settings.sh` uses correct GitHub API endpoints
   - Validate branch protection JSON payload structure
   - Confirm script handles both new and existing branch protection rules

3. **Documentation Structure**
   - Create new `docs/github-actions.md` file for GitHub Actions version documentation (supports future extensibility)
   - Update `docs/repository-settings.md` with metadata configuration section including recommended description and topics
   - Ensure all documentation follows existing markdown formatting conventions

4. **GitHub API Considerations**
   - Repository metadata (description, topics) requires repository admin access
   - Branch protection requires repository admin access
   - Script validation should account for API rate limits and error handling

5. **Backward Compatibility**
   - Changes should not break existing workflows or scripts
   - Documentation updates should enhance clarity without removing essential information
   - Liatrio-specific references should remain accurate and helpful for Liatrio team members

## Success Metrics

1. **Reference Accuracy**: Zero incorrect repository references in documentation (excluding tasks/ directory)
2. **Documentation Completeness**: All audit findings addressed with appropriate documentation
3. **Liatrio Alignment**: Template documentation accurately reflects Liatrio-specific configuration and organization settings
4. **Clarity**: GitHub Action version strategy clearly documented with monitoring guidance
5. **Automation Validation**: Repository settings script validated and documented with verified functionality

## Resolved Decisions

The following questions have been resolved and incorporated into the specification:

1. **GitHub Actions documentation location**: Create a separate `docs/github-actions.md` file to support future extensibility with additional GitHub Actions content.

2. **Repository description**: The recommended description is: "A battle-tested GitHub template repository with opinionated developer experience, quality gates, and CI/CD automation ready for customization" (already configured in repository).

3. **Repository topics**: The recommended topics are: `automation`, `ci-cd`, `devops`, `github-actions`, `github-template`, `developer-tools`, `liatrio`, `pre-commit`, `semantic-release` (includes current topics plus `github-actions` and `developer-tools` for better discoverability).

4. **Repository metadata script enhancement**: Keep repository metadata (description, topics) configuration manual-only. No script automation is needed as metadata changes are infrequent and manual configuration provides better control and clarity.
