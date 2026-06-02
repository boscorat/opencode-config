---
description: Analyze a specific Python file for refactoring opportunities
agent: python-pyside6-reviewer
subtask: true
---

Analyze the specified Python file (`$1`) for refactoring opportunities. Use the `py_analyse` skill to:
1. Examine the provided file
2. Identify code issues, security risks, and refactoring suggestions  
3. Produce a markdown report with severity levels and before/after examples

Focus on readability and maintainability improvements. Read Python and PySide6 versions from `uv.lock` for compatibility.
