# Python/PySide6 Reviewer Skills

Subordinate skills for the `python-pyside6-reviewer` agent. These skills work together to analyze Python/PySide6 code and refactor it for improved readability and maintainability.

## Skills

### `py-analyse`
Analyzes Python/PySide6 code to identify refactoring opportunities. Produces a markdown report with:
- Issues categorized by severity (critical/medium/minor)
- Security risk red-flags (SQL injection, hardcoded credentials, insecure operations, etc.)
- Refactoring suggestions with before/after examples
- Works on individual files or entire directories
- Auto-reads Python and PySide6 versions from `uv.lock`

### `py-implement`
Transforms code based on refactoring suggestions into clean, idiomatic Python/PySide6. Includes:
- Type hints and comprehensive docstrings
- Diff/preview before applying changes
- Validation through static analysis and test execution
- Works on individual files or entire directories
- Auto-reads versions from `uv.lock` for consistency

## Quick Commands

- `/py_analyse_repo` — Analyze entire repository for refactoring opportunities
- `/py_analyse_file <path>` — Analyze a specific Python file

## Design

These skills maintain a **balanced approach**:
- Improves readability and maintainability (primary goal)
- Avoids excessive micro-optimization (e.g., not creating thousands of functions for DRY compliance)
- Follows PCEP/PCAP Python standards and PySide6 best practices
