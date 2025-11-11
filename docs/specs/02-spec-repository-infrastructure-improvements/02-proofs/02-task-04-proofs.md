# 02-task-04-proofs.md

## Task 4.0: Create Template Audit CI Workflow

### File Verification

- ✅ `.github/workflows/template-audit.yml` exists with monthly schedule and workflow_dispatch
- ✅ YAML syntax is valid
- ✅ Documentation added to README.md
- ✅ Manual prompt referenced: `prompts/repository-template-audit.md` (already exists)

### Workflow Configuration

**Triggers:**

- **Schedule**: Monthly on the 1st at midnight UTC (`cron: '0 0 1 * *'`)
- **Workflow Dispatch**: Manual trigger with input parameters

**Input Parameters:**

- `target_repository` (required): Repository to audit (GitHub URL, org/repo, or local path)
- `template_repository` (optional): Template baseline (defaults to `liatrio-labs/open-source-project-template`)

**Workflow Steps:**

1. Checkout repository
2. Install Cursor CLI (same as cursor.yml workflow)
3. Read audit prompt from `prompts/repository-template-audit.md`
4. Invoke Cursor agent with prompt and repository arguments

**Permissions:**

- `contents: read`
- `pull-requests: write`
- `issues: write`

**Timeout:**

- 30 minutes (matches Cursor workflow timeout)

### YAML Syntax Validation

```bash
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/template-audit.yml'))" && echo "YAML syntax valid"
```

```text
YAML syntax valid
```

### Demo Criteria Validation

- ✅ CI workflow exists with monthly schedule (`schedule: cron: '0 0 1 * *'`)
- ✅ `workflow_dispatch` trigger with input parameter for target repository
- ✅ Workflow invokes Cursor agent with audit prompt from `prompts/repository-template-audit.md`
- ✅ Workflow passes target repository as argument
- ✅ Documentation explains both automated (CI workflow) and manual (AI prompt) audit methods
- ✅ Manual prompt referenced with instructions

### Documentation Updates

**README.md Changes:**

Added "Template Audit Automation" section with:

1. **Automated Audit (CI Workflow)**:
   - Monthly schedule explanation
   - Manual trigger instructions
   - Input parameters documentation

2. **Manual Audit (AI Prompt)**:
   - Instructions for using prompt directly
   - Argument requirements
   - Reference to prompt file

3. **Audit Scope**:
   - List of checked file categories
   - Reference to detailed audit methodology

### Workflow File Location

- File: `.github/workflows/template-audit.yml`
- Will appear in GitHub Actions tab after commit
- Can be triggered manually via Actions → Template Audit → Run workflow
- Runs automatically on the 1st of each month

### Integration with Cursor Workflow

- Uses same Cursor CLI installation method
- Uses same `CURSOR_API_KEY` secret
- Follows same timeout and permission patterns
- Reuses Cursor agent infrastructure
