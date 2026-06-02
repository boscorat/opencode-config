# Documentation Reviewer Skills

Subordinate skills for the `documentation-reviewer` agent. These skills work together to analyze, review, and improve documentation for multiple audiences with support for Python docstring synchronization, PySide6 UI component documentation, and Zensical GitHub Pages publishing.

## Skills Overview

### `doc-analyse`
Reviews documentation for clarity, accuracy, and audience appropriateness. Auto-detects target audience from metadata. Produces structured analysis with:
- Issues categorized by severity (critical/medium/minor)
- Audience assessment and style guide applied
- Zensical validation (metadata, links, assets)
- Python docstring sync analysis
- PySide6 widget documentation gaps
- Works on individual files or entire documentation trees
- Auto-reads Zensical and Python versions from `uv.lock`

### `doc-implement`
Transforms documentation based on review suggestions into audience-appropriate content. Includes:
- Rewrites for different audience levels
- Zensical metadata and structure validation
- Python docstring synchronization
- Link/asset validation
- Diff preview before applying changes
- Validation through static checks and build verification
- Works on individual files or entire documentation trees
- Auto-reads Zensical and Python versions from `uv.lock`

### `doc-docstring`
Manages Python docstring extraction, validation, and synchronization with published documentation. Includes:
- Extraction of Google-style docstrings
- Quality review and completeness checking
- Sync analysis (code ↔ documentation)
- Format consistency enforcement
- Works on individual files or entire modules
- Auto-reads Python version from `uv.lock`

## Quick Commands

- `/doc_analyse_repo` — Analyze entire documentation tree
- `/doc_analyse_file <path>` — Analyze specific documentation file
- `/doc_analyse_docstrings` — Analyze Python docstrings and sync gaps

## Audience Levels & Style Guides

The documentation-reviewer agent auto-detects target audience from metadata (frontmatter tags, file structure, existing prose style) and applies the appropriate style guide. Use these guidelines when writing or updating documentation.

### Technical Audience

**Target**: Developers with experience in the technology stack; familiar with programming concepts and technical terminology.

**Vocabulary**:
- Assume familiarity with domain-specific jargon
- Use technical terms without explanation on first mention
- Reference advanced concepts freely (async/await, event loops, signal dispatch, etc.)
- Acceptable: "Connect slots using Qt.DirectConnection for same-thread optimization"

**Complexity**:
- Advanced examples are welcome
- Include edge cases and performance considerations
- Discuss design patterns and architectural trade-offs
- Expected: Multi-step examples, conditional scenarios

**Examples**:
- Code-heavy examples showing real-world usage
- Include error handling and edge cases
- Reference API signatures directly
- Show performance characteristics when relevant

**Tone**:
- Concise and direct (peer-to-peer)
- Assume reader can infer steps between statements
- Focus on "what" and "why", less on "how to do this step"
- Use active voice, minimal hedging

**Example snippet**:
> "Override `QAbstractListModel.data()` to return model data indexed by role. Use `Qt.DisplayRole` for default column content and custom roles for auxiliary data. Emit `dataChanged()` when model updates."

---

### General Audience

**Target**: Developers new to the technology or users with mixed experience levels; need clear explanations without assuming deep domain knowledge.

**Vocabulary**:
- Explain technical terms on first use
- Avoid jargon where plain language works
- Provide context for unfamiliar concepts
- Acceptable: "Connect a slot (a function that responds to events) to a signal (a notification sent by a widget)"

**Complexity**:
- Step-by-step breakdown of processes
- Mix conceptual explanations with practical examples
- One main idea per paragraph
- Provide context before diving into code

**Examples**:
- Mix of practical and conceptual examples
- Show common use cases first, advanced variations later
- Include annotations in code to explain what's happening
- Provide complete, runnable examples

**Tone**:
- Friendly and approachable
- Clear transitions between ideas
- Encourage questions (through design, not explicitly)
- Explain the reasoning behind recommendations

**Example snippet**:
> "A slot is a function that responds to a signal. When you connect a signal to a slot, the slot automatically runs whenever the signal is sent. For example, when a button is clicked, it sends a `clicked` signal, which can trigger your slot function:
> ```python
> button.clicked.connect(self.on_button_clicked)
> ```"

---

### Beginner Audience

**Target**: Newcomers to programming or the specific technology; need very clear, patient explanations with lots of support.

**Vocabulary**:
- Define every technical term
- Use familiar, everyday language
- Minimize jargon (define it if necessary)
- Acceptable: "A signal is like a notification that says 'something happened' (like a button being clicked). A slot is a function (a block of code) that listens for that notification and runs when it arrives."

**Complexity**:
- Simple, linear step-by-step instructions
- One concept at a time
- Provide lots of context before code
- Repeat important concepts naturally
- Celebrate small wins ("You've successfully created your first widget!")

**Examples**:
- Very practical, "follow along" examples
- Show each step separately before putting together
- Include lots of comments in code
- Provide expected output and how to verify it
- Show what happens if something goes wrong and how to fix it

**Tone**:
- Patient and encouraging
- Celebrate progress
- Reassure that mistakes are learning opportunities
- Use "we" language to build connection
- Avoid jargon; explain everything

**Example snippet**:
> "A signal is like a bell in a classroom. When the teacher rings the bell, all the students hear it and know it's time to line up. In the same way, when you click a button (the 'bell'), the button sends out a signal saying 'I was clicked!' Any code that's listening for that signal will run.
>
> A slot is the code that listens and responds. Let's create a simple slot:
> ```python
> def on_button_clicked(self):
>     print('The button was clicked!')
> ```
> Now we connect the button's click signal to this slot so it runs when clicked."

---

### API Reference

**Target**: Developers looking up specific function/class signatures and behavior; need formal, precise documentation.

**Vocabulary**:
- Formal, standardized terminology
- Jargon expected and defined in formal terms
- Consistency with official API documentation
- Acceptable: "`QObject.connect(sender, signal, receiver, slot: Callable) -> bool`"

**Complexity**:
- Minimal prose; structured format only
- Focus on signatures, parameters, return values
- Include type information explicitly
- Brief description of behavior

**Examples**:
- Minimal; focus on signature clarity
- Show parameter usage if needed
- One example per item, keep it short
- Cross-reference related items

**Tone**:
- Formal, accurate, concise
- No conversational language
- Direct and factual
- Structured for scannability

**Example snippet**:
> "`QObject.connect(sender: QObject, signal: Signal, receiver: QObject, slot: Callable) -> bool`
>
> Creates a connection between a signal emitted by `sender` and a `slot` in `receiver`. Returns `True` if connection succeeds, `False` if connection already exists or invalid parameters.
>
> Parameters:
> - `sender`: Object that emits the signal
> - `signal`: Signal to connect from sender
> - `receiver`: Object that will receive the signal
> - `slot`: Function to call when signal is emitted
>
> Raises: `TypeError` if signal or slot are invalid"

---

## Zensical Integration

The documentation-reviewer validates:
- **YAML Frontmatter** — Required fields, format compliance
- **File Structure** — Folder organization and naming conventions
- **Internal Links** — All cross-references are valid
- **Assets** — Images and files referenced in docs exist at documented paths
- **SEO Metadata** — Completeness of metadata fields

The skills auto-read the Zensical version from `uv.lock` to ensure compatibility with your project's publishing setup.

## Python Docstring Format

All docstring work uses **Google-style format**. Structure:

```python
def function_name(param1: str, param2: int = 5) -> bool:
    """Brief description of what the function does.
    
    Longer description with more details if needed. Can span
    multiple lines.
    
    Args:
        param1: Description of param1. Type info in docstring is optional
            (type hints in signature are preferred).
        param2: Description of param2. Defaults to 5.
    
    Returns:
        Brief description of return value and its type.
    
    Raises:
        ValueError: When something goes wrong.
        TypeError: For type errors.
    
    Example:
        >>> result = function_name("test", 10)
        >>> print(result)
        True
    """
    pass
```

## PySide6 UI Documentation

The skills validate PySide6 UI documentation through:
- **Code inspection** — Extract widget names and hierarchy from Python code
- **Widget name validation** — Ensure documented names match actual code
- **Component documentation** — Identify missing signal/slot documentation
- **Sync checking** — Verify documented behavior matches implementation

No QtDesigner files are used; all documentation is validated against the actual Python source code.

## Integration with Code Reviews

When `python-pyside6-reviewer` detects code changes, it can suggest running `documentation-reviewer` to check if documentation needs updating. This is optional and user-driven — no automatic documentation changes are made.
