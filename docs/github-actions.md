# GitHub Actions Version Strategy

This document explains the version management strategy for GitHub Actions used in this repository, including when to use pinned versions versus `@latest`, and how to monitor and update actions.

## Table of Contents

- [Quick Reference](#quick-reference)
- [Version Pinning Strategy](#version-pinning-strategy)
- [Using `@latest` for Rapid Development Actions](#using-latest-for-rapid-development-actions)
- [Monitoring `@latest` Actions](#monitoring-latest-actions)
- [When to Pin Versions](#when-to-pin-versions)
- [Version Update Process](#version-update-process)

## Quick Reference

### Common Scenarios

#### Scenario 1: Adding a new GitHub Action to a workflow

```yaml
# ✅ RECOMMENDED: Pin to a stable version
- uses: actions/checkout@v4
- uses: actions/setup-node@v4

# ⚠️ USE SPARINGLY: Only for rapidly evolving actions
- uses: sst/opencode/github@latest  # See docs/github-actions.md for monitoring guidance
```

#### Scenario 2: Deciding whether to pin or use `@latest`

- **Pin versions** when:
  - Action is stable and mature (e.g., `actions/checkout@v4`)
  - Workflow is critical for production
  - Reproducibility is required
  - Security-sensitive operations

- **Use `@latest`** when:
  - Action is rapidly evolving (e.g., `sst/opencode/github@latest`)
  - You need latest features immediately
  - Action is still in active early development
  - You commit to active monitoring

#### Scenario 3: Monitoring an `@latest` action

```bash
# Check current version
gh api repos/sst/opencode/releases/latest | jq '.tag_name'

# List recent releases
gh api repos/sst/opencode/releases --paginate | jq '.[] | {tag_name, published_at, name}'
```

#### Scenario 4: Updating a pinned version

1. Check release notes for breaking changes
2. Test in a development environment
3. Update workflow file: `@v4` → `@v5`
4. Test workflow execution
5. Commit and monitor first production run

#### Scenario 5: Transitioning from `@latest` to pinned

1. Monitor releases for a stable version
2. Test the specific version in staging
3. Update workflow: `@latest` → `@v1.2.3`
4. Document the change and rationale

### Quick Decision Tree

```text
New GitHub Action?
├─ Is it stable and mature?
│  └─ YES → Pin to specific version (e.g., @v4)
│  └─ NO → Is it rapidly evolving?
│     ├─ YES → Use @latest (with monitoring)
│     └─ NO → Pin to specific version
└─ Is it security-sensitive?
   └─ YES → Always pin to specific version
```

## Version Pinning Strategy

GitHub Actions can be referenced using:

- **Pinned versions** (`@v1.2.3` or `@v1`): Specific, stable version - recommended for production
- **SHA pinning** (`@abc123def456`): Exact commit hash - maximum security and stability
- **`@latest`**: Latest version from the default branch - used for rapidly evolving actions

**Best Practice**: Pin versions for production workflows to ensure reproducibility and stability. Use `@latest` only when necessary for rapidly evolving actions that require frequent updates.

## Using `@latest` for Rapid Development Actions

### Rationale for `sst/opencode/github@latest`

The `sst/opencode/github` action is currently using `@latest` because:

1. **Rapid Development**: The action is under active development with frequent releases and updates
2. **Feature Velocity**: New features and bug fixes are released frequently, making version pinning impractical
3. **Early Stage**: The action is in active development, and stable long-term versions may not yet be established
4. **Continuous Improvement**: Using `@latest` ensures access to the latest improvements and bug fixes

**Current Version Reference**: As of the latest update, the action is at `v0.15.3` or later. Check the [releases page](https://github.com/sst/opencode/releases) for the current version.

### Trade-offs

**Benefits:**

- Access to latest features and bug fixes
- No manual version updates required
- Staying current with rapid development

**Risks:**

- Potential breaking changes in updates
- Less predictable behavior over time
- Requires active monitoring

## Monitoring `@latest` Actions

### Active Monitoring Requirements

When using `@latest`, you must actively monitor for updates:

1. **Check Releases Regularly**: Monitor the action's [GitHub releases page](https://github.com/sst/opencode/releases) for new versions
2. **Watch for Breaking Changes**: Review release notes for breaking changes or deprecations
3. **Test Updates**: Before updating, test the new version in a development environment
4. **Document Changes**: Track version changes and their impact on workflows

### Identifying Stable Versions

To transition from `@latest` to a pinned version:

1. **Monitor Release Patterns**: Track releases for a period to identify stable versions
2. **Check Release Notes**: Look for "stable" or "LTS" designations
3. **Review Change Frequency**: Stable versions typically have longer intervals between releases
4. **Test in Staging**: Use a test repository to validate a specific version before pinning

### Monitoring Tools and Methods

```bash
# Check current version via GitHub API
gh api repos/sst/opencode/releases/latest | jq '.tag_name'

# List recent releases
gh api repos/sst/opencode/releases --paginate | jq '.[] | {tag_name, published_at, name}'

# Monitor repository for releases (requires GitHub notifications)
# Visit: https://github.com/sst/opencode/releases and click "Watch" → "Releases only"
```

## When to Pin Versions

### Recommended: Pin Versions For

- **Production Workflows**: Critical workflows that must be reproducible
- **Security-Sensitive Actions**: Actions that handle secrets, authentication, or sensitive data
- **Stable Actions**: Actions that have mature release cycles and stable versions
- **CI/CD Pipelines**: Build and deployment workflows requiring consistency
- **Compliance Requirements**: Workflows subject to regulatory or compliance standards

### Examples of Actions to Pin

```yaml
# Recommended: Pin stable actions
- uses: actions/checkout@v4
- uses: actions/setup-node@v4
- uses: actions/setup-python@v5

# Acceptable: Use @latest for rapidly evolving actions (with monitoring)
- uses: sst/opencode/github@latest  # See docs/github-actions.md for monitoring guidance
```

### Security Considerations

1. **Supply Chain Risk**: `@latest` can introduce unexpected changes or vulnerabilities
2. **Reproducibility**: Pinned versions ensure consistent behavior across environments
3. **Audit Trail**: Pinned versions provide clear audit trails for compliance
4. **Risk Assessment**: Evaluate the security impact of the action before using `@latest`

### Stability Needs

Consider pinning when:

- Workflows must produce identical results over time
- Workflows are part of critical business processes
- Actions are used in multiple repositories
- Version updates could break existing workflows

## Version Update Process

### For Pinned Versions

1. **Review Release Notes**: Check for breaking changes or new features
2. **Test in Development**: Test the new version in a non-production environment
3. **Update Workflow**: Change the version reference in the workflow file
4. **Test Workflow**: Run the workflow to ensure it works correctly
5. **Commit and Deploy**: Commit the change and monitor the first production run

### For `@latest` Actions

1. **Monitor Releases**: Regularly check for new releases
2. **Review Changes**: Read release notes for breaking changes
3. **Test Updates**: When a new version is released, test it in development
4. **Consider Pinning**: If a stable version is identified, consider pinning it
5. **Document Decision**: Record why `@latest` is still appropriate or why you're pinning

### Example Update Workflow

```bash
# 1. Check current version
gh api repos/sst/opencode/releases/latest | jq '.tag_name'

# 2. Review release notes
# Visit: https://github.com/sst/opencode/releases/latest

# 3. Test in development environment
# Create a test workflow or use a test repository

# 4. Update workflow file (if pinning)
# Change: uses: sst/opencode/github@latest
# To:     uses: sst/opencode/github@v0.15.3

# 5. Commit and verify
git add .github/workflows/
git commit -m "chore: pin sst/opencode/github to v0.15.3"
```

## Best Practices Summary

1. **Default to Pinning**: Pin versions for all actions unless there's a specific reason to use `@latest`
2. **Document Exceptions**: When using `@latest`, document why and include monitoring guidance
3. **Regular Reviews**: Periodically review `@latest` actions to identify stable versions for pinning
4. **Test Before Pinning**: Always test new versions before pinning in production workflows
5. **Monitor Security**: Use Dependabot or similar tools to monitor for security vulnerabilities
6. **Update Regularly**: Keep pinned versions updated to access security patches and bug fixes

## References

- [GitHub Actions: Using actions](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#using-action-versioning)
- [GitHub Actions: Security hardening](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
- [sst/opencode Releases](https://github.com/sst/opencode/releases)
