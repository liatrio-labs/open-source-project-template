## Relevant Files

- `README.md` - Contains incorrect repository references in badge URLs (lines 5-6) and template CLI command example (line 25). Needs updates to use `liatrio-labs/open-source-project-template`.
- `.github/ISSUE_TEMPLATE/config.yml` - Contains incorrect repository references in contact links (lines 4 and 7). Needs updates to use correct repository path.
- `.github/workflows/opencode-gpt-5-codex.yml` - Contains inline comment about `@latest` usage (line 50). Needs comment update to reference new documentation file.
- `docs/github-actions.md` - **NEW FILE** - Needs to be created with GitHub Actions version strategy documentation explaining `@latest` usage, monitoring guidance, and version pinning recommendations.
- `docs/repository-settings.md` - Contains repository settings documentation but lacks metadata section. Needs new section with recommended repository description and topics, plus manual configuration instructions.
- `scripts/apply-repo-settings.sh` - Repository settings automation script. Needs validation to confirm branch protection and `delete_branch_on_merge` functionality (no code changes expected, validation only).
- `CHANGELOG.md` - Contains repository links that are already correct. Validate only, no changes needed.

### Notes

- Unit tests are not applicable for this task as these are documentation and configuration file updates.
- Changes are primarily text replacements and documentation additions.
- The `tasks/` directory is explicitly excluded from repository reference updates per spec requirements.

## Tasks

- [x] 1.0 Fix Repository References Throughout Codebase
  - Demo Criteria: "Run `grep -r 'liatrio/open-source-template' . --exclude-dir=tasks` and verify zero matches; all badge URLs in README.md display correctly on GitHub pointing to `liatrio-labs/open-source-project-template`; issue template config.yml links resolve to correct repository"
  - Proof Artifact(s): "CLI: `grep -r 'liatrio/open-source-template' . --exclude-dir=tasks` returns zero matches; README.md badges display correctly on GitHub; File list: README.md, .github/ISSUE_TEMPLATE/config.yml, scripts/apply-repo-settings.sh"
  - [x] 1.1 Update badge URLs in README.md (lines 5-6) from `liatrio/open-source-template` to `liatrio-labs/open-source-project-template`
  - [x] 1.2 Update template CLI command example in README.md (line 25) from `liatrio/open-source-template` to `liatrio-labs/open-source-project-template`
  - [x] 1.3 Update contact link URLs in `.github/ISSUE_TEMPLATE/config.yml` (lines 4 and 7) from `liatrio/open-source-template` to `liatrio-labs/open-source-project-template`
  - [x] 1.4 Verify CHANGELOG.md already contains correct repository references (validate only, no changes needed)
  - [x] 1.5 Run verification command: `grep -r 'liatrio/open-source-template' . --exclude-dir=tasks` and confirm zero matches
- [x] 2.0 Document GitHub Action Version Strategy
  - Demo Criteria: "New `docs/github-actions.md` file exists explaining why `sst/opencode/github@latest` uses `@latest`, includes monitoring guidance, and explains when to pin versions vs. use `@latest`; workflow file comment references the documentation file"
  - Proof Artifact(s): "File: `docs/github-actions.md` with complete documentation; Updated comment in `.github/workflows/opencode-gpt-5-codex.yml` referencing `docs/github-actions.md`"
  - [x] 2.1 Create new file `docs/github-actions.md` with documentation explaining GitHub Actions version strategy
  - [x] 2.2 Document rationale for using `@latest` for `sst/opencode/github` action (rapid development, frequent updates)
  - [x] 2.3 Add monitoring guidance section explaining how to track `@latest` action updates and identify stable versions
  - [x] 2.4 Add section explaining when to pin versions vs. use `@latest` (security considerations, stability needs)
  - [x] 2.5 Update inline comment in `.github/workflows/opencode-gpt-5-codex.yml` (line 50) to reference `docs/github-actions.md` instead of inline explanation
- [x] 3.0 Add Repository Metadata Documentation and Validate Settings Script
  - Demo Criteria: "`docs/repository-settings.md` includes section with recommended repository description and topics; documentation includes manual configuration instructions for metadata; script validation confirms `scripts/apply-repo-settings.sh` correctly handles branch protection and `delete_branch_on_merge` setting"
  - Proof Artifact(s): "Updated `docs/repository-settings.md` with metadata section including recommended description: 'A battle-tested GitHub template repository with opinionated developer experience, quality gates, and CI/CD automation ready for customization' and topics: `automation`, `ci-cd`, `devops`, `github-actions`, `github-template`, `developer-tools`, `liatrio`, `pre-commit`, `semantic-release`; Script validation notes confirming branch protection and delete_branch_on_merge functionality"
  - [x] 3.1 Add new "Repository Metadata" section to `docs/repository-settings.md` with recommended repository description: "A battle-tested GitHub template repository with opinionated developer experience, quality gates, and CI/CD automation ready for customization"
  - [x] 3.2 Add recommended repository topics list: `automation`, `ci-cd`, `devops`, `github-actions`, `github-template`, `developer-tools`, `liatrio`, `pre-commit`, `semantic-release`
  - [x] 3.3 Add manual configuration instructions for setting repository description via GitHub UI and `gh` CLI
  - [x] 3.4 Add manual configuration instructions for setting repository topics via GitHub UI and `gh` CLI
  - [x] 3.5 Note that repository metadata configuration is manual-only (no script automation) with brief explanation
  - [x] 3.6 Validate `scripts/apply-repo-settings.sh` correctly implements branch protection (verify `apply_branch_protection` function uses correct GitHub API endpoint and JSON payload structure)
  - [x] 3.7 Validate `scripts/apply-repo-settings.sh` correctly sets `delete_branch_on_merge=true` (verify `apply_general_settings` function includes this parameter in API call on line 87)
