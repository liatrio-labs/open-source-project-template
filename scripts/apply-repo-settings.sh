#!/usr/bin/env bash
#
# Apply recommended repository settings via GitHub CLI (gh)
#
# Usage:
#   ./scripts/apply-repo-settings.sh [owner/repo]
#
# Prerequisites:
#   - GitHub CLI (gh) installed and authenticated
#   - Repository admin access
#
# Example:
#   ./scripts/apply-repo-settings.sh liatrio/my-new-project
#

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    if ! command -v gh &> /dev/null; then
        error "GitHub CLI (gh) is not installed. Please install it from https://cli.github.com/"
        exit 1
    fi

    if ! gh auth status &> /dev/null; then
        error "GitHub CLI is not authenticated. Run 'gh auth login' to authenticate."
        exit 1
    fi

    info "Prerequisites check passed"
}

# Parse repository from arguments or detect from git remote
get_repository() {
    if [ $# -eq 1 ]; then
        echo "$1"
    else
        # Try to detect from git remote
        if git remote get-url origin &> /dev/null; then
            local remote_url
            remote_url=$(git remote get-url origin)
            # Extract owner/repo from various URL formats
            if [[ $remote_url =~ github\.com[:/](.+/[^/]+)(\.git)?$ ]]; then
                echo "${BASH_REMATCH[1]}" | sed 's/\.git$//'
            else
                error "Could not parse repository from git remote"
                exit 1
            fi
        else
            error "No git remote found. Please specify repository as: owner/repo"
            exit 1
        fi
    fi
}

# Apply general repository settings
apply_general_settings() {
    local repo=$1
    info "Applying general repository settings to $repo..."

    gh api -X PATCH "repos/$repo" \
        -F has_issues=true \
        -F has_wiki=true \
        -F has_discussions=false \
        -F allow_squash_merge=true \
        -F allow_merge_commit=false \
        -F allow_rebase_merge=false \
        -F delete_branch_on_merge=true \
        > /dev/null

    info "✓ General settings applied successfully"
}

# Apply branch protection rules
apply_branch_protection() {
    local repo=$1
    info "Applying branch protection rules to $repo (main branch)..."

    # Check if protection already exists
    if gh api "repos/$repo/branches/main/protection" &> /dev/null; then
        warn "Branch protection already exists. Updating..."
    fi

    # Apply protection rules
    gh api -X PUT "repos/$repo/branches/main/protection" \
        --input - > /dev/null <<'EOF'
{
  "required_status_checks": {
    "strict": true,
    "contexts": ["test", "lint"]
  },
  "enforce_admins": false,
  "required_pull_request_reviews": {
    "dismissal_restrictions": {},
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": false,
    "required_approving_review_count": 1
  },
  "restrictions": null,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "required_conversation_resolution": true
}
EOF

    info "✓ Branch protection rules applied successfully"
}

# Verify settings
verify_settings() {
    local repo=$1
    info "Verifying applied settings..."

    echo ""
    echo "General Settings:"
    gh api "repos/$repo" | jq '{
        has_issues,
        has_wiki,
        has_discussions,
        allow_squash_merge,
        allow_merge_commit,
        allow_rebase_merge,
        delete_branch_on_merge
    }'

    echo ""
    echo "Branch Protection (main):"
    if gh api "repos/$repo/branches/main/protection" &> /dev/null; then
        gh api "repos/$repo/branches/main/protection" | jq '{
            required_status_checks: .required_status_checks.contexts,
            required_approving_review_count: .required_pull_request_reviews.required_approving_review_count,
            dismiss_stale_reviews: .required_pull_request_reviews.dismiss_stale_reviews,
            required_conversation_resolution: .required_conversation_resolution
        }'
    else
        warn "Branch protection not configured"
    fi
}

# Main execution
main() {
    echo "========================================="
    echo "  Repository Settings Application"
    echo "========================================="
    echo ""

    check_prerequisites

    local repo
    repo=$(get_repository "$@")
    info "Target repository: $repo"

    echo ""
    read -p "Apply settings to $repo? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        warn "Aborted by user"
        exit 0
    fi

    echo ""
    apply_general_settings "$repo"
    echo ""
    apply_branch_protection "$repo"
    echo ""
    verify_settings "$repo"

    echo ""
    info "Settings applied successfully!"
    info "See docs/repository-settings.md for additional manual configuration steps."
}

main "$@"
