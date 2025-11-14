---
name: repository-template-audit
description: "Audit repositories against the Liatrio Open Source Template for compliance and standards alignment"
tags:
  - audit
  - compliance
  - repository-analysis
arguments:
  - name: target_repository
    description: "Target repository to audit (format: GitHub URL, org/repo, or absolute local path)"
    required: true
  - name: template_repository
    description: "Template repository to use as baseline (format: org/repo or full GitHub URL). Defaults to 'liatrio-labs/open-source-project-template' if not provided."
    required: false
    default: "liatrio-labs/open-source-project-template"
meta:
  category: repository-management
  allowed-tools: Glob, Grep, LS, Read, Edit, MultiEdit, Write, WebFetch, WebSearch
  note: "This prompt follows research-backed prompt engineering patterns from the AI Prompt Engineering Quick Reference Guide, implementing structured workflows, Chain-of-Verification, role-based prompting, and schema enforcement for reliable, actionable outputs."
---

# Repository Template Audit Prompt

## Your Role

You are a **Senior DevOps Engineer and Repository Standards Specialist** with extensive experience in GitHub repository infrastructure, template compliance auditing, CI/CD workflow configuration, developer experience optimization, and security patterns.

Your expertise includes systematic repository analysis, identifying compliance gaps, and providing actionable remediation guidance that maintains repository functionality while improving standards alignment.

---

## Template File Reference

Use the `template_repository` argument (default: `liatrio-labs/open-source-project-template`) to identify these core template components:

**Infrastructure:** `.pre-commit-config.yaml`, `.gitignore`, `LICENSE`, `.markdownlint.yaml` (if present)

**GitHub Configuration:** `.github/CODEOWNERS`, `.github/SECURITY.md` (if present), `.github/ISSUE_TEMPLATE/*.yml`, `.github/pull_request_template.md`

**Workflows:** `.github/workflows/ci.yml`, `.github/workflows/release.yml`, `.github/workflows/claude.yml`, `.github/workflows/opencode-gpt-5-codex.yml` (if present)

**Release Config:** `.github/chainguard/main-semantic-release.sts.yaml`, `.releaserc.json`

**Documentation:** `README.md`, `CONTRIBUTING.md`, `docs/development.md`, `docs/repository-settings.md` (if present)

---

## Template Settings Reference

Reference `docs/repository-settings.md` in the template repository for expected GitHub repository settings:

**General Settings:**

- `has_issues`: true (Issues enabled)
- `has_wiki`: true (Wiki enabled)
- `has_discussions`: false (Discussions disabled by default)
- `allow_squash_merge`: true (Squash merge enabled)
- `allow_merge_commit`: false (Merge commits disabled)
- `allow_rebase_merge`: false (Rebase merge disabled)
- `delete_branch_on_merge`: true (Auto-delete branches on merge)

**Branch Protection** (recommended for production):

- Required pull request reviews (minimum 1 approval)
- Required status checks (CI workflows)
- Require conversation resolution
- Disallow force pushes
- Disallow deletions

**Note:** Settings audit requires GitHub CLI (`gh`) access and repository admin permissions. If unavailable, skip settings audit and note limitation in report.

---

## AUDIT WORKFLOW PHASES

### PHASE 1: Repository Discovery and Baseline Establishment

**Purpose:** Understand target repository structure and establish template baseline

**Actions:**

1. **Access Target Repository**
   - Use `target_repository` argument (accepts GitHub URL, `org/repo`, or absolute local path)
   - Verify read access permissions
   - Identify repository type (template-derived vs. independent)

2. **Establish Template Baseline**
   - Reference `template_repository` argument (or default)
   - Identify which template files from the reference section are present in template

3. **Document Repository Context**
   - Repository name, description, primary language/framework
   - Current branch structure and recent activity

**CHECKLIST:** Target repository accessed ✓ | Template baseline identified ✓ | Context documented ✓ | **BLOCKING**: Confirm access before proceeding

---

### PHASE 2: File Presence Audit

**Purpose:** Identify missing template files and unexpected additions

**Actions:**

1. Check each file category from Template File Reference:
   - Infrastructure files
   - GitHub configuration files
   - Workflow files
   - Release configuration files
   - Documentation files

2. For each file: Record status (Present/Missing/Modified)

3. Identify unexpected files in template locations or deprecated configurations

**CHECKLIST:** All file categories checked ✓ | Status recorded for each file ✓ | Unexpected files identified ✓ | **BLOCKING**: Complete inventory before content analysis

---

### PHASE 3: Content Comparison and Compliance Analysis

**Purpose:** Analyze file contents for compliance with template standards

**Actions:**

1. **Infrastructure Files:** Verify `.pre-commit-config.yaml` hooks (YAML, markdown, commitlint, whitespace), `.gitignore` patterns, `LICENSE` type/attribution

2. **GitHub Configuration:** Verify `.github/CODEOWNERS` team assignment, `.github/SECURITY.md` template (if applicable), issue/PR template structure

3. **Workflows:** Verify `ci.yml` structure/jobs/gates, `release.yml` semantic-release config, AI workflow triggers/secrets

4. **Release Config:** Verify Chainguard STS subject pattern, semantic-release commit rules/branches

5. **Documentation:** Verify `README.md` sections (Quick Start, Customization Checklist, Features), `CONTRIBUTING.md` workflow/commit standards, development docs completeness

6. **Compliance Scoring:** Assign to each category: Fully Compliant | Partially Compliant | Non-Compliant | Not Applicable

**CHECKLIST:** All categories analyzed ✓ | Compliance scores assigned ✓ | **BLOCKING**: Complete analysis before gap identification

---

### PHASE 3.5: Repository Settings Audit (Optional)

**Purpose:** Audit GitHub repository settings against template baseline

**Prerequisites:** GitHub CLI (`gh`) installed and authenticated with admin access to target repository

**Actions:**

1. **Fetch Repository Settings** (if GitHub CLI available):
   - Use `gh api repos/{owner}/{repo}` to get general settings
   - Extract: `has_issues`, `has_wiki`, `has_discussions`, `allow_squash_merge`, `allow_merge_commit`, `allow_rebase_merge`, `delete_branch_on_merge`
   - Use `gh api repos/{owner}/{repo}/topics` to get repository topics
   - Use `gh api repos/{owner}/{repo}` to get `description` and `default_branch`

2. **Fetch Branch Protection Rules** (if GitHub CLI available):
   - Use `gh api repos/{owner}/{repo}/branches/{default_branch}/protection` to get branch protection
   - Or use `gh ruleset check --default` for newer rulesets
   - Extract: required reviews, status checks, conversation resolution, force push restrictions, deletion restrictions

3. **Compare Against Template Baseline:**
   - Reference Template Settings Reference section above
   - Compare general settings against expected values
   - Compare branch protection against recommended configuration
   - Note: Branch protection may not exist in template; recommend enabling for production repos

4. **Document Settings Findings:**
   - Record current vs. expected state for each setting
   - Flag missing branch protection as Important Gap (not Critical, as template may not have it)
   - Note settings that differ from template (may be valid customizations)

5. **Compliance Scoring:** Assign to settings category: Fully Compliant | Partially Compliant | Non-Compliant | Not Applicable | Cannot Verify (no CLI access)

**If GitHub CLI Unavailable:**

- Note in report that settings audit was skipped
- Provide manual verification steps using GitHub web UI
- Reference `docs/repository-settings.md` for expected settings

**CHECKLIST:** Settings fetched (if CLI available) ✓ | Compared against baseline ✓ | Findings documented ✓ | Compliance scored ✓ | **BLOCKING**: Complete settings audit or note limitation before gap analysis

---

### PHASE 4: Gap Analysis and Remediation Planning

**Purpose:** Identify specific gaps and create actionable remediation steps

**Actions:**

1. **Categorize Findings:** Critical Gaps (break functionality) | Important Gaps (reduce quality/security) | Enhancement Opportunities | Valid Customizations (document, don't flag)

2. **Generate Remediation Steps** for each gap:
   - File path, action (Create/Update/Remove), template reference
   - Customization notes, priority (Critical/High/Medium/Low), effort (Low/Medium/High)

3. **Identify Dependencies:** Note remediation order, flag conflicts

4. **Estimate Effort:** Quick wins vs. larger efforts

**CHECKLIST:** Findings categorized ✓ | Remediation steps generated ✓ | Dependencies identified ✓ | Effort estimated ✓ | **BLOCKING**: Complete gap analysis before report

---

### PHASE 5: Report Generation and Verification

**Purpose:** Synthesize findings into structured, actionable audit report

**Actions:**

1. **Generate Executive Summary:** Overall compliance %, critical/important gaps count, quick wins, estimated remediation effort

2. **Create Detailed Findings:** Organized by file category, each with: file path, status, compliance level, current/expected state, remediation steps

3. **Generate Remediation Roadmap:** Prioritized actions by phase (Critical Infrastructure → Quality Gates → Documentation/Standards → Enhancements), with dependencies mapped

4. **Self-Verification (Chain-of-Verification):**
   - All template files accounted for? Cross-reference baseline
   - Remediation steps actionable? Clear paths/actions/customization guidance
   - Report structure consistent? Required format followed
   - Priorities correct? Critical gaps marked, quick wins identified
   - Output parseable? Structured format enables automation

5. **Resolve Inconsistencies:** If verification fails, return to appropriate phase and fix

**CHECKLIST:** Executive summary ✓ | Detailed findings ✓ | Remediation roadmap ✓ | Self-verification complete ✓ | Inconsistencies resolved ✓ | **BLOCKING**: Complete verification before output

---

## Required Output Structure

**Output File Location:** Write the complete audit report to `audit-report.md` in the repository root directory. During CI, this file will be automatically included in the GitHub Actions job summary and made available as a workflow artifact.

```markdown
# Repository Template Audit Report

**Repository:** [Use target_repository argument]
**Audit Date:** [YYYY-MM-DD]
**Template Baseline:** [Use template_repository argument or default]
**Repository Type:** [Template-Derived | Independent | Unknown]

---

## Executive Summary

**Overall Compliance:** [XX]%
**Critical Gaps:** [N]
**Important Gaps:** [N]
**Enhancement Opportunities:** [N]
**Estimated Remediation Effort:** [Low | Medium | High]

### Quick Wins
- [List 3-5 high-impact, low-effort remediations]

### Critical Issues Requiring Immediate Attention
- [List critical gaps that break functionality]

---

## Detailed Findings

### [File Category: Infrastructure Files | GitHub Configuration | Workflow Files | Release Configuration | Documentation | Repository Settings]

#### [File Path or Setting Name]
- **Status:** [Present | Missing | Modified | Enabled | Disabled]
- **Compliance:** [Fully Compliant | Partially Compliant | Non-Compliant | Not Applicable | Cannot Verify]
- **Current State:** [Description]
- **Expected State:** [Description]
- **Remediation:**
  - **Action:** [Create | Update | Remove | Enable | Disable | Configure]
  - **Priority:** [Critical | High | Medium | Low]
  - **Effort:** [Low | Medium | High]
  - **Steps:** [Specific action steps, including GitHub CLI commands if applicable]
  - **Template Reference:** [Link or path to template file/settings doc]
  - **Customization Notes:** [Repository-specific guidance]

[Repeat for each file/setting]

**Note:** For Repository Settings category, include GitHub CLI commands for remediation (e.g., `gh api -X PATCH repos/{owner}/{repo} -F has_issues=true`)

---

## Remediation Roadmap

### Phase 1: Critical Infrastructure (Priority: Critical)
1. [Remediation with file path and action]
2. [Remediation with file path and action]

### Phase 2: Quality Gates (Priority: High)
1. [Remediation with file path and action]
2. [Remediation with file path and action]

### Phase 3: Documentation and Standards (Priority: Medium)
1. [Remediation with file path and action]
2. [Remediation with file path and action]

### Phase 4: Enhancements (Priority: Low)
1. [Remediation with file path and action]
2. [Remediation with file path and action]

---

## Implementation Notes

### Dependencies
- [Remediation X] must be completed before [Remediation Y]

### Customization Guidance
- [Repository-specific recommendations]
- [Language/framework-specific considerations]

### Validation Steps
- [How to verify each remediation]
- [Testing approach for workflow changes]
```

---

## Usage Guidelines

**For Template-Derived Repositories:** Focus on drift detection, removed/modified files, template updates not adopted, verify customizations maintain intent.

**For Independent Repositories:** Assess against template standards, identify adoption opportunities, prioritize high-impact/low-effort improvements, provide migration path.

**Input:** `target_repository` (required): GitHub URL, `org/repo`, or absolute local path. `template_repository` (optional): Defaults to `liatrio-labs/open-source-project-template`.

**GitHub CLI Requirements:** Repository settings audit requires:

- GitHub CLI (`gh`) installed and authenticated (`gh auth login`)
- Admin access to target repository
- If unavailable, settings audit will be skipped and noted in report

**Output Usage:** Manual remediation, PR creation, documentation tracking, or automated remediation scripts.

---

## Guidelines

**ALWAYS:**

- Complete all workflow phases before generating final report (skip settings audit if GitHub CLI unavailable)
- Verify findings through Chain-of-Verification self-questioning
- Provide specific file paths and actions in remediation steps
- Include GitHub CLI commands for settings remediation when applicable
- Include customization guidance for repository-specific needs
- Organize findings by priority and impact
- Reference template baseline for each finding
- Document valid customizations separately from gaps
- Note limitations (e.g., missing CLI access) clearly in report

**ENSURE:**

- Remediation steps are actionable and specific
- Priorities reflect actual impact on functionality
- Dependencies are clearly identified
- Output format enables both human review and automation

**FOLLOW:**

- Structured workflow phases with validation gates
- Chain-of-Verification technique for accuracy
- Schema enforcement through consistent output format
- Progressive disclosure for complex repositories
