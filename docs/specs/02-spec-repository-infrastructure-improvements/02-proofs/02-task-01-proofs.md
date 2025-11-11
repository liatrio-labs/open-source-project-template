# 02-task-01-proofs.md

## Task 1.0: Create Security Documentation and Code Ownership Files

### CLI Output

#### SECURITY.md File Verification

```bash
cat SECURITY.md
```

```text
# Security Policy

## Supported Versions

We actively support security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| Latest  | :white_check_mark: |

## Reporting a Vulnerability

We take the security of our software seriously. If you believe you have found a security vulnerability, please report it to us as described below.

**Please do not report security vulnerabilities through public GitHub issues.**

Instead, please report them via one of the following methods:

1. **Private Vulnerability Reporting** (Preferred): Use GitHub's [Private Vulnerability Reporting](https://github.com/liatrio-labs/open-source-project-template/security/advisories/new) feature
2. **Email**: Contact the maintainer team at `@liatrio-labs/liatrio-labs-maintainers`

### What to Include

When reporting a vulnerability, please include:

- A description of the vulnerability
- Steps to reproduce the issue
- Potential impact of the vulnerability
- Any suggested fixes or mitigations (if available)

### Response Timeline

- **Initial Response**: Within 48 hours
- **Status Update**: Within 7 days
- **Resolution**: Depends on severity and complexity

### Disclosure Policy

We follow a coordinated disclosure process:

1. We will acknowledge receipt of your report within 48 hours
2. We will investigate and provide status updates as appropriate
3. We will work with you to understand and resolve the issue
4. We will credit you for the discovery (unless you prefer to remain anonymous)
5. We will publish a security advisory once the issue is resolved

### Security Best Practices

When using this template or creating repositories from it:

- Keep dependencies up to date
- Review and customize security settings for your specific use case
- Enable branch protection rules
- Use CODEOWNERS to ensure code review
- Regularly audit your repository configuration

## Security Updates

Security updates will be released as patches to the latest version. We recommend keeping your repository up to date with the latest template changes.
```

#### CODEOWNERS File Verification

```bash
cat .github/CODEOWNERS
```

```text
* @liatrio-labs/liatrio-labs-maintainers
```

### File Verification

- ✅ `SECURITY.md` exists at repository root
- ✅ `.github/CODEOWNERS` exists with correct team reference
- ✅ Both files are properly formatted
- ✅ Markdownlint passed on SECURITY.md

### Demo Criteria Validation

- ✅ SECURITY.md file exists at repository root with standard GitHub Security Policy template content
- ✅ `.github/CODEOWNERS` file exists with `@liatrio-labs/liatrio-labs-maintainers` team entry
- ✅ Both files are properly formatted and accessible

### Configuration Details

**SECURITY.md** includes:

- Supported versions table
- Vulnerability reporting instructions (Private Vulnerability Reporting and email contact)
- Response timeline expectations
- Coordinated disclosure policy
- Security best practices guidance

**CODEOWNERS** includes:

- Single entry: `* @liatrio-labs/liatrio-labs-maintainers`
- Follows GitHub CODEOWNERS syntax
- Located at `.github/CODEOWNERS` (standard location)
