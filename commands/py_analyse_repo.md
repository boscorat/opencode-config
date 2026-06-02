---
description: Analyze entire repository for refactoring opportunities
agent: python-pyside6-reviewer
subtask: true
---

Analyze the entire current repository for refactoring opportunities. Use the `py_analyse` skill to:
1. Scan all Python files recursively from the current directory
2. Identify code issues, security risks, and refactoring suggestions
3. Produce a comprehensive markdown report with severity levels

Focus on readability and maintainability improvements. Read Python and PySide6 versions from `uv.lock` for compatibility.
