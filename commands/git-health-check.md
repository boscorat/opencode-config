---
description: Diagnose repository health: stale branches, CI status, branch protection, orphaned commits, uncommitted changes
agent: git-expert
subtask: true
---

Run a comprehensive health check on the repository. Output:

1. **Branch Health**:
   - List stale branches (no commits for 30+ days)
   - Show age of each remote branch
   - Identify orphaned local branches

2. **Commit Health**:
   - Check for uncommitted changes
   - List unpushed commits on current branch
   - Verify recent commits follow conventional commit format

3. **CI Status**:
   - Show latest workflow run status
   - Identify failing/flaky tests
   - Check required status checks

4. **GitHub Configuration**:
   - Verify branch protection rules on main
   - Check for required reviews, status checks, dismissals
   - List secret scanning or security features

5. **Release Readiness**:
   - Check if towncrier fragments present
   - Verify CHANGELOG.md exists and is current
   - List tags and recent releases

Output format:
```
GIT REPOSITORY HEALTH REPORT
============================

✓ BRANCH HEALTH (GREEN)
  - main: up to date with origin (last commit 2 hours ago)
  - develop: 3 commits ahead of origin (push needed)
  
⚠ STALE BRANCHES (YELLOW)
  - feature/old-ui: no commits for 89 days (consider deletion)

✗ UNCOMMITTED CHANGES (RED)
  - src/module.py: modified
  - test/test.py: staged
```

Allow filtering: `/git-health-check stale-branches`, `/git-health-check ci-status`, etc.
