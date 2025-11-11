# 02-task-03-proofs.md

## Task 3.0: Create Cursor Agent Workflow Integration

### File Verification

- ✅ `.github/workflows/cursor.yml` exists with proper configuration
- ✅ YAML syntax is valid
- ✅ Documentation added to README.md
- ✅ Secret documentation added to Required GitHub Secrets section

### Workflow Configuration

The Cursor workflow follows the same pattern as Claude and OpenCode workflows:

**Event Triggers:**

- `issue_comment` (created)
- `pull_request_review_comment` (created)
- `issues` (opened, edited)
- `pull_request_review` (submitted)

**Trigger Pattern:**

- Checks for `@cursor` mention in comment body or issue title
- Validates author association (OWNER, MEMBER, COLLABORATOR)
- Uses concurrency control to prevent duplicate runs

**Workflow Steps:**

1. Checkout repository (fetch-depth: 1)
2. Install Cursor CLI via official curl script
3. Run `cursor-agent` command with `CURSOR_API_KEY` secret

**Permissions:**

- `contents: read`
- `pull-requests: write`
- `issues: write`

**Timeout:**

- 30 minutes (matches OpenCode timeout for extended operations)

### YAML Syntax Validation

```bash
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/cursor.yml'))" && echo "YAML syntax valid"
```

```text
YAML syntax valid
```

### Demo Criteria Validation

- ✅ Workflow file `.github/workflows/cursor.yml` exists following pattern of `claude.yml` and `opencode-gpt-5-codex.yml`
- ✅ Workflow triggers on all required events
- ✅ Workflow checks for `@cursor` mention in comment body
- ✅ Workflow validates author association (OWNER, MEMBER, COLLABORATOR)
- ✅ Workflow installs Cursor CLI and runs `cursor-agent` command
- ✅ Documentation added explaining Cursor agent usage, secrets setup, and command triggers

### Documentation Updates

**README.md Changes:**

1. Updated "AI Workflow Integration" section to include Cursor
2. Added `CURSOR_API_KEY` to "Required GitHub Secrets" section with:
   - Usage explanation (`@cursor` trigger)
   - Setup instructions
   - Link to Cursor documentation
   - Note about automatic CLI installation

### Workflow File Location

- File: `.github/workflows/cursor.yml`
- Will appear in GitHub Actions tab after commit
- Can be triggered by commenting `@cursor help` on a PR or issue
