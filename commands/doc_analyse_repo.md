---
description: Analyze entire documentation tree for issues and improvements
agent: documentation-reviewer
subtask: true
---

Analyze the entire documentation tree from the current directory for:
1. Clarity and appropriateness for target audience
2. Technical accuracy and consistency
3. Python docstring sync (automatic extraction)
4. PySide6 UI component documentation gaps
5. Zensical structure/metadata/links/assets validation

Auto-detect audience from metadata. Use `doc-analyse` skill.
Read Zensical version from uv.lock for compatibility.
