---
description: Execute or plan a semantic versioned release with towncrier changelog consolidation
agent: git-expert
subtask: true
---

The user wants to execute a release workflow. If they provided a version number (e.g., `/release-workflow 2.1.0`), use it. Otherwise, ask them for:
1. Version number (semantic version: MAJOR.MINOR.PATCH)
2. Confirmation before consolidating towncrier fragments and creating release tag

Then follow the release checklist:
1. Verify CI passes on main/master
2. List towncrier fragments to consolidate
3. Consolidate fragments with towncrier
4. Update version in pyproject.toml (or equivalent)
5. Create annotated git tag
6. Push tag to remote
7. Verify release package published (if applicable)

Ask for approval at each step before proceeding.
