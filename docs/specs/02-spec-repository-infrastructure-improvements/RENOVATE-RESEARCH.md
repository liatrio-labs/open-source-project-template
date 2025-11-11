# Renovate Bot Configuration Research

This document summarizes research findings for Renovate Bot configuration, comparing official documentation with patterns used in other Liatrio repositories.

## Official Renovate Bot Documentation Summary

### Installation and Setup

**GitHub App Installation:**

- Install from https://github.com/apps/renovate
- Choose between "All repositories" or "Select repositories"
- Renovate automatically ignores forks and repositories without package files
- Creates an onboarding PR after installation

**Configuration File Locations:**
Renovate supports multiple configuration file locations (checked in order):

- `renovate.json` (root directory)
- `renovate.json5` (root directory)
- `.github/renovate.json`
- `.github/renovate.json5`
- `.gitlab/renovate.json` (GitLab)
- `.renovaterc` / `.renovaterc.json` / `.renovaterc.json5`
- `package.json` (deprecated, in `"renovate"` section)

**Recommended Location:** `.github/renovate.json` aligns with repository structure conventions

### Configuration Options for Conservative Setup

**Key Settings for Conservative (No Auto-Merge) Configuration:**

```json
{
  "$schema": "https://docs.renovatebot.com/schemas/renovate-schema.json",
  "extends": ["config:recommended"],
  "prConcurrentLimit": 10,
  "prHourlyLimit": 2,
  "dependencyDashboard": true,
  "dependencyDashboardTitle": "🤖 Dependency Dashboard",
  "labels": ["dependencies"],
  "automerge": false,
  "automergeType": "pr",
  "ignorePresets": [
    ":automergeMinor"
  ],
  "updateNotScheduled": false,
  "schedule": ["before 3am on monday"],
  "timezone": "America/Los_Angeles",
  "packageRules": [
    {
      "matchUpdateTypes": ["major"],
      "groupName": "major dependency updates",
      "labels": ["dependencies", "breaking-change"]
    },
    {
      "matchUpdateTypes": ["minor", "patch"],
      "groupName": "dependency updates",
      "labels": ["dependencies"]
    }
  ],
  "reviewers": ["@liatrio-labs/liatrio-labs-maintainers"],
  "assignees": ["@liatrio-labs/liatrio-labs-maintainers"]
}
```

**Conservative Configuration Highlights:**

- `automerge: false` - No automatic merging
- `prHourlyLimit: 2` - Limits PR creation rate
- `prConcurrentLimit: 10` - Limits concurrent open PRs
- `schedule` - Batches updates to specific time windows
- `dependencyDashboard: true` - Provides overview of all dependencies
- `reviewers` and `assignees` - Routes PRs to maintainer team

### Organization-Level Presets

Renovate supports organization-level configuration presets that can be extended:

- Organization presets can define shared configuration
- Repository configs can extend org presets: `"extends": ["config:liatrio-labs"]`
- This allows consistent configuration across multiple repositories

**Recommendation:** Check if `liatrio-labs` organization has a Renovate preset that should be extended

## Comparison with Other Liatrio Repositories

### Research Needed

To complete this comparison, we need to:

1. Check if `liatrio-labs` organization has Renovate preset configuration
2. Review configuration files in top-level Liatrio repositories:
   - `liatrio-labs/spec-driven-workflow`
   - Other top-level repos mentioned in notes
3. Identify common patterns:
   - Configuration file location preference
   - Extent of org preset usage
   - Conservative vs. aggressive settings
   - Label and reviewer assignment patterns

### Questions to Answer

1. **Do other Liatrio repos use organization-level Renovate presets?**
   - If yes, which preset name do they extend?
   - What shared configuration is defined at org level?

2. **What configuration file location do other repos use?**
   - Root `renovate.json` vs `.github/renovate.json`
   - Is there a standard convention?

3. **What level of conservatism do other repos use?**
   - Auto-merge settings for minor/patch?
   - PR rate limits?
   - Scheduling preferences?

4. **How are reviewers and assignees configured?**
   - Individual maintainers vs. teams?
   - Same maintainer team used consistently?

## Recommended Approach

Based on official documentation, recommended conservative configuration:

**File Location:** `.github/renovate.json` (aligns with repository structure)

**Configuration Strategy:**

1. Check for organization preset first
   - If org preset exists, extend it: `"extends": ["config:liatrio-labs", "config:recommended"]`
   - Override specific settings for conservative behavior
2. If no org preset, start with recommended defaults and customize:
   - `"extends": ["config:recommended"]`
   - Add conservative settings (no auto-merge, rate limits, scheduling)

**Conservative Settings to Include:**

- `automerge: false` - Require manual review for all updates
- `prHourlyLimit: 2` - Prevent PR spam
- `dependencyDashboard: true` - Provide overview
- Schedule updates to off-hours
- Require reviews from maintainer team

## Next Steps

1. **Research Liatrio repositories** to identify:
   - Organization-level Renovate preset (if exists)
   - Configuration patterns used in other repos
   - File location conventions

2. **Document findings** in this file before implementation

3. **Create configuration** based on research findings while maintaining conservative approach

## References

- [Renovate Bot Official Docs - Getting Started](https://docs.renovatebot.com/getting-started/installing-onboarding/)
- [Renovate Bot Configuration Options](https://docs.renovatebot.com/configuration-options/)
- [GitHub App Installation](https://github.com/apps/renovate)
