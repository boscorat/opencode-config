---
description: Analyze specific documentation file for issues
agent: documentation-reviewer
subtask: true
---

Analyze the specified documentation file (`$1`) for:
1. Clarity and appropriateness for target audience
2. Technical accuracy and consistency
3. Zensical metadata/links/assets validation
4. Related Python docstring references
5. PySide6 UI component documentation

Auto-detect audience from metadata or ask user if unclear.
Use `doc-analyse` skill. Read Zensical version from uv.lock.
