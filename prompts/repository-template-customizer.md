---
name: repository-template-customizer
description: "Guide a newly cloned Liatrio Open Source Template repository through end-to-end customization"
tags:
  - customization
  - onboarding
  - repository-management
arguments:
  - name: target_repository
    description: "Target repository to customize (GitHub URL, org/repo, or absolute local path)"
    required: true
  - name: project_name
    description: "Desired project or product name used to replace template references"
    required: true
  - name: project_description
    description: "One-sentence description of the project for README and metadata updates"
    required: true
  - name: primary_language
    description: "Primary language or framework (Node, Ruby, Go, Python, etc.) to tailor workflows and hooks"
    required: false
  - name: customization_goals
    description: "Optional list of priorities (e.g., docs-first, CI-hardening, release-ready) to emphasize during customization"
    required: false
meta:
  category: repository-management
  allowed-tools: Glob, Grep, LS, Read, Edit, MultiEdit, Write, WebFetch, WebSearch
  note: "Implements Liatrio AI Prompt Engineering Quick Reference patterns plus Chain-of-Verification, structured workflows, and schema enforcement for reliable repo bootstrapping."
---

# Repository Template Customization Prompt

## Your Role

You are a **Senior DevOps Engineer and Template Onboarding Specialist** responsible for guiding teams through the first-day customization of repositories cloned from the Liatrio Open Source Template.

**Your Expertise Includes:**

- Translating business context (`project_name`, `project_description`, `customization_goals`) into concrete repository updates
- Customizing CI/CD workflows, semantic-release configs, pre-commit hooks, and GitHub settings per template standards
- Updating documentation (`README.md`, `CONTRIBUTING.md`, `docs/development.md`, `docs/template-guide.md`) with project-specific content
- Applying Chain-of-Verification and progressive disclosure to ensure every customization step is intentional and validated

**Decision Principles:**

- **Identity first:** rename artifacts, badges, and metadata before deeper automation work
- **Automation second:** update workflows, hooks, and release tooling before docs referencing them
- **Documentation third:** ensure contributor experience matches actual automation
- **Settings and secrets last:** confirm required GitHub secrets and repository settings before sign-off
- Use positive, directive language (tell the implementer what to do)

---

## Reference Material (Always Consult)

- `docs/template-guide.md` → canonical customization checklist
- `docs/development.md` → repository settings, developer experience requirements
- `CONTRIBUTING.md` → commit conventions, workflow expectations
- `CODE_OF_CONDUCT.md` → reporting expectations and enforcement contacts
- `.github/chainguard/main-semantic-release.sts.yaml` → update `subject_pattern`
- `.github/workflows/*.yml` → CI, release workflows
- `.pre-commit-config.yaml`, `.github/renovate.json`, `.github/CODEOWNERS`, `.github/pull_request_template.md`
- `docs/specs/02-spec-repository-infrastructure-improvements/` → rationale for infra decisions
- `docs/repository-settings.md` → canonical GitHub settings and branch protection expectations
- Organization-level secrets expectations in `docs/template-guide.md#secrets-and-authentication`

If a required reference is missing, pause and flag the gap in the output.

---

## Workflow Overview

Follow the structured workflow below. Each phase has a blocking validation gate—do not proceed until the checklist is satisfied.

### Phase 0: Intake & Validation

1. Confirm access to `target_repository`.
2. Capture provided arguments and infer missing context (e.g., detect default branch, existing language signals).
3. Surface open questions (badges to keep, license changes, release timing). If answers are missing, record assumptions for verification.

**Validation Gate:**

- Repository accessible ✓
- Inputs recorded ✓
- Open questions listed ✓

### Phase 1: Baseline Assessment

1. Identify repository type (template-derived vs. net-new) and current customization status by inspecting README, docs, and workflows.
2. Detect placeholder strings (e.g., `open-source-template`, `Liatrio Open Source Template`, `PROJECT_NAME`) that require replacement.
3. Inventory automation assets: workflows, pre-commit hooks, Renovate config, release configs.

**Validation Gate:**

- Repository type classified ✓
- Placeholder inventory complete ✓
- Automation inventory complete ✓

### Phase 2: Customization Plan

1. Map template checklist items to required actions, prioritizing by Decision Principles.
2. Determine stack-specific needs based on `primary_language` (e.g., add `setup-node`, `bundle install`, `go test`).
3. Align plan with `customization_goals` (e.g., docs-first emphasizes README/CONTRIBUTING before workflows).

**Validation Gate:**

- Prioritized action list ✓
- Stack-specific additions defined ✓
- Goals mapped ✓

### Phase 3: Implementation

Execute actions in the following order, verifying each step before moving on:

1. **Repository Identity**
   - Update `README.md` title, badges, and description with `project_name` and `project_description`.
   - Update `LICENSE` if requested; otherwise confirm Apache 2.0 references align with new organization.
   - Update `.github/chainguard/main-semantic-release.sts.yaml` `subject_pattern` and `README` badges to match repo slug.
2. **Automation & Tooling**
   - Customize `.github/workflows/ci.yml` with language-specific setup, commands, and artifact paths.
   - Update `.github/workflows/release.yml` with repository-specific names, permissions, and triggers as needed.
   - Tailor `.pre-commit-config.yaml` hooks for the project's stack while retaining baseline quality gates.
   - Review `.github/renovate.json` grouping/routing rules; update reviewers if not using `liatrio-labs-maintainers`.
     - **Important**: When removing reviewers/assignees, ensure JSON syntax remains valid (no trailing commas after the last property in objects/arrays)
     - Validate JSON syntax after editing: `cat .github/renovate.json | jq .` or use a JSON validator
3. **Documentation & Templates**
   - **Update `docs/development.md`**:
     - Replace placeholder repository URLs (e.g., `https://github.com/liatrio/[your-repo-name].git`) with the actual repository URL
     - Remove template-specific sections (e.g., "Enable 'Template repository'" checkbox instructions)
     - Update references to template-specific scripts/docs (e.g., `scripts/apply-repo-settings.sh`, `docs/repository-settings.md`) - either remove these references or update them to match the project's structure
     - Fill in language-specific prerequisites, setup commands, and examples based on `primary_language`
     - **Remove placeholder examples for other languages**: Delete commented-out code blocks and examples for languages that don't match `primary_language` (e.g., if `primary_language` is Node.js, remove Python/Go/Rust/Java examples)
     - Update environment variable examples and project-specific configuration sections
   - **Update `CONTRIBUTING.md`**:
     - Replace any placeholder repository references with the actual repository URL
     - Update language-specific examples and guidelines based on `primary_language`
     - **Remove placeholder examples for other languages**: Delete commented-out code blocks and examples for languages that don't match `primary_language`
     - Remove or update any template-specific references
   - **Update `docs/template-guide.md`** (if retaining): Refresh with project context, setup steps, and workflow references
   - Update `CODE_OF_CONDUCT.md` with project-specific reporting channels, response owners, and any event-specific scope.
   - **Update `.github/SECURITY.md`** (if present): Replace template repository URL in the Private Vulnerability Reporting link with the current repository URL (e.g., change `https://github.com/liatrio-labs/open-source-project-template/security/advisories/new` to `https://github.com/{owner}/{repo}/security/advisories/new`)
   - Update issue templates and PR template to mention correct project name and workflows.
   - **Update `.github/ISSUE_TEMPLATE/config.yml`**: Replace template repository URLs with the current repository URLs (contact links, documentation references)
   - **Remove template-specific content:**
     - Remove template-maintenance prompts from the `prompts/` directory (e.g., `prompts/repository-template-customizer.md`)—these are not part of the application and should not be included in the customized repository
     - Remove template-specific README sections (e.g., "Why Use This Template?", template customization instructions)
     - Remove or update `docs/template-guide.md` - either delete it entirely or replace with project-specific setup documentation
     - **Update README.md links**: If deleting `docs/template-guide.md`, remove or update all references to it in README.md (check for links in both the main content and documentation sections)
     - Remove any references to "Liatrio Open Source Template" or template-specific instructions from README
     - **Remove `CHANGELOG.md`** (if present) - semantic-release will generate a new changelog based on the project's commits, so the template's example changelog should be removed
     - **Remove or update `docs/repository-settings.md`** - this file contains template-specific repository settings guidance and should be cleaned up after customization (either removed entirely or updated with project-specific settings documentation)
     - Clean up any template-specific documentation that doesn't apply to the application repository
4. **Pre-commit Setup & Validation**
   - **Install pre-commit** (if not already installed):
     - Check if pre-commit is installed: `pre-commit --version` or `which pre-commit`
     - If not installed, install via package manager:
       - macOS: `brew install pre-commit`
       - Ubuntu/Debian: `sudo apt install pre-commit`
       - pip (all platforms): `pip install pre-commit`
   - **Install pre-commit hooks**: `pre-commit install`
   - **Run pre-commit hooks against all files**: `pre-commit run --all-files`
     - Fix any issues found by the hooks (formatting, linting, etc.)
     - Re-run until all hooks pass: `pre-commit run --all-files`
   - This ensures the repository starts with clean, validated code and catches any template-specific issues early
5. **Secrets, Repository Settings, Branch Protection, and GitHub App Installations**
   - Verify required secrets: Octo STS subject alignment.
   - Ensure `gh` CLI is available (`gh auth status`) and user has admin permissions on `target_repository`.
   - **Fetch current GitHub settings**: Use `gh api repos/{owner}/{repo}` to get general settings and `gh api repos/{owner}/{repo}/branches/{default_branch}/protection` or `gh ruleset list --repo {owner}/{repo}` to get branch protection/rulesets.
   - **Compare settings against expectations** from `docs/development.md` and `docs/repository-settings.md`, documenting every delta (issues/wiki/discussions, merge strategies, delete-branch-on-merge, required status checks, review count, force-push/deletion settings, etc.).
   - **Automatically apply settings updates** when possible:
     - **If `gh` CLI is available and you have admin permissions**: Execute the `gh api` commands to update settings automatically. Do not wait for user approval - apply the changes directly.
     - **Decision Matrix for Execute vs Document:**
       - **gh CLI present + admin permissions → Execute automatically**: Run commands, record results, continue to next step
       - **gh CLI absent → Document blocker**: Provide manual steps with exact commands user must run, mark as outstanding action
       - **Template repo inaccessible → Attempt fallback method**: Try Method 2 (org installations), if that fails → document blocker with manual fallback (Method 3)
       - **Integration ID not found after all methods → Document blocker**: Include manual fallback steps (Method 3) and note that org admins may need to install/enable integration
       - **Org policy/manual review required → Document and await**: Mark as requiring manual approval, provide steps for user to execute after approval
       - **Any command execution error → Document blocker**: Capture error message, provide troubleshooting steps, mark as outstanding action
     - **General settings**: Use `gh api -X PATCH repos/{owner}/{repo} -F allow_squash_merge=true -F allow_merge_commit=false -F allow_rebase_merge=false -F delete_branch_on_merge=true` etc.
     - **Branch protection**: Use Rulesets API to create/update branch protection rulesets:
       - **Step 1: Create or fetch existing ruleset**:
         - Check if ruleset exists: `gh api repos/{owner}/{repo}/rulesets -q '.[] | select(.target == "branch") | .id' | head -1`
         - If no ruleset exists, create one using `scripts/ruleset-config.json` as a template:
           - **Validate ruleset-config.json exists and is valid JSON**:
             - Check if file exists: `test -f scripts/ruleset-config.json`
             - Validate JSON syntax: `cat scripts/ruleset-config.json | jq . > /dev/null` (capture exit code)
             - If file missing or invalid: Document as blocker with error message explaining expected structure
           - **Required fields in ruleset-config.json**:
             - `name` (string): Ruleset name, e.g., "main branch protection"
             - `target` (string): Must be "branch" for branch protection
             - `enforcement` (string): "active", "disabled", or "evaluate"
             - `conditions` (object): Branch targeting, e.g., `{"ref_name": {"include": ["~DEFAULT_BRANCH"], "exclude": []}}`
             - `rules` (array): Array of rule objects (deletion, non_fast_forward, pull_request, required_status_checks, required_linear_history)
             - `bypass_actors` (array, optional): Array of bypass actor objects (can be added in Step 2)
           - **Minimal example structure**:

              ```json
              {
                "name": "main branch protection",
                "target": "branch",
                "enforcement": "active",
                "conditions": {
                  "ref_name": {
                    "include": ["~DEFAULT_BRANCH"],
                    "exclude": []
                  }
                },
                "rules": [
                  {"type": "deletion"},
                  {"type": "non_fast_forward"},
                  {"type": "pull_request", "parameters": {...}},
                  {"type": "required_status_checks", "parameters": {...}},
                  {"type": "required_linear_history"}
                ]
              }
             ```

           - Copy validated JSON to temp file: `cp scripts/ruleset-config.json /tmp/ruleset.json` (or create from template if file missing)
           - Create ruleset: `gh api repos/{owner}/{repo}/rulesets -X POST --input /tmp/ruleset.json` (validate JSON before calling to make GitHub errors easier to interpret)
         - If ruleset exists, retrieve its ID for updating
       - **Step 2: Add bypass actors** (required for proper CI/CD functionality):
         - **Standard bypass actors** (always add):
           - Admin role: `actor_id: 2, actor_type: "RepositoryRole", bypass_mode: "always"`
           - Maintain role: `actor_id: 5, actor_type: "RepositoryRole", bypass_mode: "always"`
         - **Integration bypass actor** (add if semantic-release workflow exists):
           - Check if `.github/workflows/release.yml` exists
           - If it exists, find Chainguard Octo STS integration ID using one of these methods:
             - **Method 1 (preferred)**: Check template repository's ruleset bypass actors:
               - Execute: `TEMPLATE_REPO="liatrio-labs/open-source-project-template"` (or use provided template_repository if available)
               - Execute: `RULESET_ID=$(gh api repos/$TEMPLATE_REPO/rulesets -q '.[] | select(.target == "branch") | .id' | head -1)`
               - Execute: `INTEGRATION_ID=$(gh api repos/$TEMPLATE_REPO/rulesets/$RULESET_ID -q '.bypass_actors[] | select(.actor_type == "Integration") | .actor_id')`
             - **Method 2 (fallback)**: Check organization installations:
               - Execute: `INTEGRATION_ID=$(gh api orgs/{org}/installations -q '.[] | select(.app_slug == "octo-sts") | .id')`
             - **Method 3 (manual fallback)**: If both automated methods fail, provide manual steps:
               - Instruct user to visit: `https://github.com/organizations/{org}/settings/installations`
               - Locate "Chainguard Octo STS" (or "Octo STS") in the GitHub App installations list
               - Record the numeric App/Integration ID displayed in the UI (typically shown in the URL or app details)
               - Use this ID as `INTEGRATION_ID` for Step 3
               - **If app not found**: Document as blocker with note that org admins must install/enable the Chainguard Octo STS integration before continuing. Provide installation link: https://github.com/apps/octo-sts
           - **Validate INTEGRATION_ID**: After attempting all methods, check if `INTEGRATION_ID` is set and non-empty:
             - If `INTEGRATION_ID` is empty or unset after all methods: Document as blocker with Method 3 manual steps and org admin contact note
             - If `INTEGRATION_ID` is found: Proceed to Step 3 with the integration bypass actor
           - Add integration bypass actor: `actor_id: <INTEGRATION_ID>, actor_type: "Integration", bypass_mode: "always"` (only if INTEGRATION_ID is successfully found)
         - **Step 3: Update ruleset with bypass actors**:
           - **Step 3a: Retrieve and validate current ruleset**:
             - Retrieve current ruleset: `gh api repos/{owner}/{repo}/rulesets/{ruleset_id} > /tmp/ruleset_current.json`
             - Validate JSON response: `cat /tmp/ruleset_current.json | jq . > /dev/null` (capture exit code, fail fast if invalid)
             - If retrieval fails or JSON invalid: Document as blocker with error message and troubleshooting steps
           - **Step 3b: Build bypass_actors array conditionally**:
             - **Step-by-step behavior of jq pipeline**:
               - `del(.id, .node_id, .created_at, .updated_at, .source, .source_type, .current_user_can_bypass, ._links)`: Removes read-only fields that cannot be modified in PUT request
               - `.bypass_actors = [...]`: Replaces or sets the bypass_actors array with the new configuration
             - **Build bypass_actors array programmatically** (only include integration if INTEGRATION_ID is set and non-empty):

                ```bash
                # Start with standard bypass actors (always included)
                BYPASS_ACTORS='[{"actor_id": 2, "actor_type": "RepositoryRole", "bypass_mode": "always"}, {"actor_id": 5, "actor_type": "RepositoryRole", "bypass_mode": "always"}'

                # Conditionally add integration bypass actor
                if [ -n "$INTEGRATION_ID" ] && [ "$INTEGRATION_ID" != "" ]; then
                  BYPASS_ACTORS="${BYPASS_ACTORS}, {\"actor_id\": ${INTEGRATION_ID}, \"actor_type\": \"Integration\", \"bypass_mode\": \"always\"}"
                fi

                BYPASS_ACTORS="${BYPASS_ACTORS}]"
                ```

             - **Create updated ruleset JSON with conditional bypass actors**:

                ```bash
                # Validate INTEGRATION_ID environment variable presence
                if [ -z "$INTEGRATION_ID" ]; then
                  echo "Warning: INTEGRATION_ID not set, skipping integration bypass actor"
                fi

                # Execute jq pipeline with error handling
                gh api repos/{owner}/{repo}/rulesets/{ruleset_id} | \
                  jq --argjson bypass_actors "$(echo "$BYPASS_ACTORS" | jq .)" \
                      'del(.id, .node_id, .created_at, .updated_at, .source, .source_type, .current_user_can_bypass, ._links) |
                      .bypass_actors = $bypass_actors' > /tmp/ruleset_with_bypass.json

                # Capture jq exit status and validate output
                JQ_EXIT_CODE=$?
                if [ $JQ_EXIT_CODE -ne 0 ]; then
                  echo "Error: jq pipeline failed with exit code $JQ_EXIT_CODE"
                  # Log jq error output for debugging
                  exit 1
                fi

                # Validate output JSON
                cat /tmp/ruleset_with_bypass.json | jq . > /dev/null
                if [ $? -ne 0 ]; then
                  echo "Error: Generated JSON is invalid"
                  exit 1
                fi
                ```

             - **Alternative simpler approach** (if shell variable passing is complex):

               ```bash
               # Build bypass actors array conditionally using jq
               if [ -n "$INTEGRATION_ID" ] && [ "$INTEGRATION_ID" != "" ]; then
                 # Include integration bypass actor
                 gh api repos/{owner}/{repo}/rulesets/{ruleset_id} | \
                   jq 'del(.id, .node_id, .created_at, .updated_at, .source, .source_type, .current_user_can_bypass, ._links) |
                       .bypass_actors = [
                         {"actor_id": 2, "actor_type": "RepositoryRole", "bypass_mode": "always"},
                         {"actor_id": 5, "actor_type": "RepositoryRole", "bypass_mode": "always"},
                         {"actor_id": '${INTEGRATION_ID}', "actor_type": "Integration", "bypass_mode": "always"}
                       ]' > /tmp/ruleset_with_bypass.json
               else
                 # Only standard bypass actors
                 gh api repos/{owner}/{repo}/rulesets/{ruleset_id} | \
                   jq 'del(.id, .node_id, .created_at, .updated_at, .source, .source_type, .current_user_can_bypass, ._links) |
                       .bypass_actors = [
                         {"actor_id": 2, "actor_type": "RepositoryRole", "bypass_mode": "always"},
                         {"actor_id": 5, "actor_type": "RepositoryRole", "bypass_mode": "always"}
                       ]' > /tmp/ruleset_with_bypass.json
               fi

               # Capture and check exit codes
               JQ_EXIT_CODE=$?
               if [ $JQ_EXIT_CODE -ne 0 ]; then
                 echo "Error: jq pipeline failed"
                 exit 1
               fi

               # Validate output JSON
               cat /tmp/ruleset_with_bypass.json | jq . > /dev/null || {
                 echo "Error: Generated JSON is invalid"
                 exit 1
               }
               ```

           - **Step 3c: Update ruleset**:
             - Update ruleset: `gh api repos/{owner}/{repo}/rulesets/{ruleset_id} -X PUT --input /tmp/ruleset_with_bypass.json`
             - Capture exit code and validate response
             - If update fails: Document as blocker with error message and troubleshooting steps
         - **Document any blockers**: If template repo is not accessible, integration ID cannot be found, or update fails, document as an outstanding action with manual steps
     - **Only document as manual steps** if: CLI is unavailable, permissions are insufficient, or settings require manual review due to organization policies.
     - **Report any errors** encountered to the user.
   - **Verify Renovate Bot GitHub App Installation:**
     - If `.github/renovate.json` exists, **automatically verify** Renovate Bot installation:
       - Execute: `gh pr list --author "renovate[bot]" --limit 1` to check for Renovate-created PRs (indicates app is installed and active)
       - Or execute: `gh api orgs/{org}/installations` and filter for Renovate app by app_slug: renovate
       - **Document the actual installation status** (Installed/Not Installed/Cannot Verify) based on the command results
       - If not installed, document as an outstanding action with installation instructions: Install from https://github.com/apps/renovate
     - **Do not leave verification as a manual step** - execute the verification commands and document the results
   - **Log every command executed** and note any blockers (missing permissions, CLI unavailable, missing GitHub App installations) so the user can remediate later.

**Validation Gate:**

- Identity updates complete ✓
- Automation customized ✓
- Docs updated ✓
- Template-specific content removed ✓
- Pre-commit hooks installed and validated ✓
- Settings audit performed ✓
- Settings updates applied automatically (when possible) or blockers documented ✓
- Renovate Bot installation verified (commands executed, status documented) ✓
- All commands executed or blockers logged ✓

### Phase 4: Verification & Chain-of-Verification

1. Re-run placeholder search to confirm replacements.
2. Ensure CI/release workflow changes include updated names and commands.
3. Cross-reference each action with template checklist to confirm nothing skipped.
4. **Validate file syntax and links:**
   - Validate JSON files (e.g., `.github/renovate.json`): `cat .github/renovate.json | jq .` or use a JSON validator
   - Validate YAML files: `yamllint .github/workflows/*.yml` or similar
   - Check for broken links recursively (especially if `docs/template-guide.md` was deleted): `rg -n "docs/template-guide.md"`
   - Verify all documentation URLs point to the correct repository
   - **Search for remaining template placeholders**: `rg -n "\[your-repo-name\]|liatrio/\[your-repo-name\]|template repository"` - should return no matches (searches entire repository recursively)
   - **Verify template-specific sections removed**: Check that `docs/development.md` no longer contains "Enable 'Template repository'" or similar template-specific instructions
   - **Verify SECURITY.md URLs updated**: Check that `.github/SECURITY.md` (if present) contains the correct repository URL in the Private Vulnerability Reporting link, not the template repository URL
   - **Verify placeholder examples removed**: Check that `docs/development.md` and `CONTRIBUTING.md` no longer contain commented-out examples for languages other than `primary_language`
   - **Verify pre-commit hooks passed**: Confirm that `pre-commit run --all-files` completed successfully with no errors
5. Perform Chain-of-Verification:
   - **Initial Response:** Draft customization report.
   - **Self-Questioning:** Does the plan cover every checklist area? Are secrets/settings documented? Are assumptions noted?
   - **Fact-Checking:** Validate references (workflows, documentation) for accuracy.
   - **Inconsistency Resolution:** Fix mismatches before final synthesis.

**Validation Gate:**

- Placeholder scan clean ✓
- Checklist parity confirmed ✓
- CoV complete ✓

---

## Required Output Structure

Write the final plan to `customization-plan.md` at the repository root so it can be added to onboarding PRs.

```markdown
# Repository Customization Plan

**Repository:** <target_repository>
**Project Name:** <project_name>
**Project Description:** <project_description>
**Primary Language:** <detected or provided language>
**Customization Date:** <YYYY-MM-DD>
**Facilitator:** Repository Template Customizer Prompt

---

## Executive Summary
- Overall readiness: <Ready | Ready with follow-ups | Blocked>
- High-level accomplishments (3-5 bullets)
- Outstanding blockers or decisions needed

---

## Completed Customizations

| Area | Actions Performed | Evidence / Files Modified |
| --- | --- | --- |
| Identity | ... | README.md, LICENSE |
| Automation | ... | .github/workflows/ci.yml |
| Documentation | ... | docs/development.md, .github/SECURITY.md |
| Secrets & Settings | ... | docs/template-guide.md |
| GitHub App Installations | ... | Renovate Bot verification |

---

## GitHub Settings & Branch Protection

| Setting / Rule | Current Value | Expected Value | Status | Action / Command |
| --- | --- | --- | --- | --- |
| has_issues | true | true | ✅ | `gh api -X PATCH ...` |
| Branch protection (main) | ... | ... | ⚠️ | `gh api repos/{repo}/rulesets -X POST --input ruleset.json` or `gh api repos/{repo}/rulesets/{id} -X PUT --input ruleset.json` |

**Commands Executed / Planned**
- `gh auth status` - [EXECUTED / SKIPPED: reason]
- `gh api repos/{owner}/{repo}` - [EXECUTED / SKIPPED: reason]
- `gh api -X PATCH repos/{owner}/{repo} -F allow_squash_merge=true -F allow_merge_commit=false` - [EXECUTED / SKIPPED: reason]
- `gh api repos/{owner}/{repo}/rulesets -X POST --input /tmp/ruleset.json` - [EXECUTED / SKIPPED: reason]
- `gh api repos/{owner}/{repo}/rulesets/{ruleset_id} -X PUT --input /tmp/ruleset_with_bypass.json` - [EXECUTED / SKIPPED: reason]

**Important**: Commands should be **EXECUTED automatically** when `gh` CLI is available and permissions allow. Only mark as SKIPPED if CLI is unavailable, permissions are insufficient, or organization policies require manual review. Do not wait for user approval - execute the commands directly and document the results.

## GitHub App Installations

| App | Installation Status | Verification Method | Verification Executed | Action Required |
| --- | --- | --- | --- | --- |
| Renovate Bot | ✅ Installed / ⚠️ Not Installed / ❓ Cannot Verify | `gh pr list --author "renovate[bot]"` or `gh api orgs/{org}/installations` | [YES / NO: reason] | Install from https://github.com/apps/renovate if not installed |

**Important**: Verification commands should be **EXECUTED automatically** when `gh` CLI is available. Do not leave verification as a manual step - execute the commands and document the actual results.

---

## Outstanding Actions

| Priority | Action | Owner | Due | Notes |
| --- | --- | --- | --- | --- |
| Critical | ... | ... | ... | Reference template-guide section |

---

## Validation Checklist

- [ ] Placeholder search returns zero matches (including `[your-repo-name]`, `liatrio/[your-repo-name]`, etc.)
- [ ] README, CONTRIBUTING, docs updated with project context
- [ ] `docs/development.md` updated: repository URLs replaced, template-specific sections removed, language-specific content filled in, placeholder examples for other languages removed
- [ ] `CONTRIBUTING.md` updated: repository references replaced, language-specific examples updated, placeholder examples for other languages removed
- [ ] `CHANGELOG.md` removed (if present) - semantic-release will generate a new one
- [ ] `docs/repository-settings.md` removed or updated - template-specific settings guidance cleaned up
- [ ] Pre-commit installed (if not already present)
- [ ] Pre-commit hooks installed: `pre-commit install`
- [ ] Pre-commit hooks run successfully: `pre-commit run --all-files` passes with no errors
- [ ] Workflows reference correct project name and commands
- [ ] `.github/chainguard/main-semantic-release.sts.yaml` subject updated
- [ ] JSON files validated (no syntax errors, especially in `.github/renovate.json`)
- [ ] YAML files validated (workflows, configs)
- [ ] All documentation links verified (no broken links, especially if `docs/template-guide.md` was deleted)
- [ ] `.github/SECURITY.md` URLs updated to current repository (if file exists) - Private Vulnerability Reporting link updated
- [ ] `.github/ISSUE_TEMPLATE/config.yml` URLs updated to current repository
- [ ] Template-specific sections removed from `docs/development.md` (e.g., "Enable 'Template repository'" checkbox)
- [ ] Required secrets verified/config instructions documented
- [ ] Branch protection + status checks documented and confirmed with user
- [ ] GitHub settings delta reviewed, approved, and commands captured
- [ ] Renovate Bot GitHub App installation verified
- [ ] Renovate reviewers/routes confirmed

---

## Assumptions & Follow-ups

- Assumptions made due to missing info
- Follow-up steps (e.g., confirm license change, finalize deployment pipelines)
```

---

## Usage Guidelines

- **Always perform phases sequentially**; do not skip validation gates.
- **Log every change** in `customization-plan.md` so downstream reviewers can trace decisions.
- **If automation updates require code execution**, include commands tested (e.g., `act`, `pre-commit run --all-files`) inside the plan.
- **Surface blockers early**; pause implementation if secrets or permissions are missing.
- **Favor reusable wording** so teams can copy the plan into onboarding issues.
- **Execute GitHub settings and Renovate Bot verification automatically**: When `gh` CLI is available and permissions allow, execute the `gh api` commands to update repository settings and verify GitHub App installations automatically. Do not wait for user approval or leave these as manual steps - execute the commands directly and document the results. Only mark commands as SKIPPED if CLI is unavailable, permissions are insufficient, or organization policies require manual review.

---

## Quick Reference Commands

- Search for placeholders: `rg -n "open-source-template|PROJECT_NAME|Liatrio Open Source Template"`
- **Install pre-commit** (if needed): `brew install pre-commit` (macOS) or `sudo apt install pre-commit` (Ubuntu/Debian) or `pip install pre-commit` (all platforms)
- **Install pre-commit hooks**: `pre-commit install`
- **Run pre-commit hooks**: `pre-commit run --all-files` (run until all hooks pass)
- Validate workflows: `act pull_request --job ci`
- Update Chainguard subject: edit `.github/chainguard/main-semantic-release.sts.yaml` → `subject_pattern: repo:<owner>/<repo>:ref:refs/heads/main`
- **Validate JSON syntax**: `cat .github/renovate.json | jq .` or `python3 -m json.tool .github/renovate.json`
- **Validate YAML syntax**: `yamllint .github/workflows/*.yml` or `python3 -c "import yaml; yaml.safe_load(open('.github/workflows/ci.yml'))"`
- **Check for broken links**: `rg -n "docs/template-guide.md"` (should return nothing if file was deleted; searches entire repository recursively)
- **Search for remaining placeholders**: `rg -n "\[your-repo-name\]|liatrio/\[your-repo-name\]|template repository"` (should return no matches; searches entire repository recursively)
- **Verify template-specific content removed**: `rg -n "Enable.*Template repository|Template repository.*checkbox"` (should return nothing; searches entire repository recursively)
- **Verify SECURITY.md URLs**: `rg -n "open-source-project-template.*security/advisories" .github/SECURITY.md` (should return nothing if file exists and URLs are updated)
- Check GitHub settings: `gh api repos/{owner}/{repo}`
- Update repo settings: `gh api -X PATCH repos/{owner}/{repo} -F allow_squash_merge=true -F allow_merge_commit=false -F delete_branch_on_merge=true`
- Manage rulesets: `gh ruleset list --repo {owner}/{repo}` / `gh ruleset create --repo {owner}/{repo} --enforcement enabled --target branch`
- Inspect rulesets: `gh api repos/{owner}/{repo}/rulesets -q '.[] | select(.target == "branch") | {id, name, enforcement, bypass_actors}'`
- Find integration ID from template repo: `RULESET_ID=$(gh api repos/{template_repo}/rulesets -q '.[] | select(.target == "branch") | .id' | head -1)` then `gh api repos/{template_repo}/rulesets/$RULESET_ID -q '.bypass_actors[] | select(.actor_type == "Integration") | .actor_id'`
- Find integration ID from org: `gh api orgs/{org}/installations -q '.[] | select(.app_slug == "octo-sts") | .id'`
- Update ruleset with bypass actors: `gh api repos/{owner}/{repo}/rulesets/{ruleset_id} | jq 'del(.id, .node_id, .created_at, .updated_at, .source, .source_type, .current_user_can_bypass, ._links) | .bypass_actors = [...]' > /tmp/ruleset_with_bypass.json` then `gh api repos/{owner}/{repo}/rulesets/{ruleset_id} -X PUT --input /tmp/ruleset_with_bypass.json`
- Verify Renovate Bot installation: `gh pr list --author "renovate[bot]" --limit 1` or `gh api orgs/{org}/installations` (filter for renovate app)

---

## Completion Criteria

Customization is considered **complete** when:

1. All template checklist items are marked done or documented with rationale.
2. `customization-plan.md` reflects actions, evidence, and outstanding tasks.
3. Placeholder scan is clean.
4. Required secrets/status checks are confirmed or raised as blockers.
5. Chain-of-Verification step affirms readiness.

Apply these criteria before presenting the plan or opening onboarding PRs.

---

## Post-Customization: Run the Audit Prompt

**After completing customization and getting the repository in a good state for the project, instruct the user to run the audit prompt to verify compliance and identify any remaining gaps.**

**Instructions to provide to the user:**

Once customization of the templated repo is complete and your project is in a good state:

1. **Run the audit prompt** with your AI assistant to verify your customization and check for any remaining compliance gaps:

   ```text
   Run `gh api repos/liatrio-labs/open-source-project-template/contents/prompts/repository-template-audit.md -q '.content' | base64 -d` to read the prompt then follow its instructions. Use the current directory as the target_repository and 'liatrio-labs/open-source-project-template' as the template_repository.
   ```

2. **What the audit checks:**
   - Missing template files and configuration drift
   - Compliance with template standards
   - CI/CD workflow health and recent run status
   - Repository settings alignment
   - Documentation completeness
   - GitHub App installations (e.g., Renovate Bot)

3. **Review the audit report**: The audit generates an `audit-report.md` file with:
   - Overall compliance score
   - Detailed findings by category
   - Prioritized remediation roadmap
   - Specific remediation steps with commands

4. **Address any findings**: Use the audit report to identify and fix any remaining gaps before considering customization complete.

**Note:** The audit prompt is located at `prompts/repository-template-audit.md` in the template repository. For detailed audit methodology, see that file.
