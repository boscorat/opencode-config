---
description: "Expert assistance with bank_statement_parser config creation and optimization"
agent: bank-config-expert
subtask: true
---

Request expert assistance with bank_statement_parser configuration (including metadata-driven testing as of PR #95).

**Usage examples:**
- Create new bank config: "Please create a config for this TSB statement: anonymised_tsb_nov2024.pdf"
- Review existing config: "Optimize this config for HSBC_UK; here's the statement I'm testing with"
- Improve extraction: "My transaction rows are merging on page breaks; what should I adjust?"
- Architecture help: "Suggest Python improvements to the config loading system"
- Test submission: "I'm ready to submit this config to the test suite. What metadata do I need?"

**Requirements:**
- All bank statements must be anonymised (filename starts with `anonymised_`)
- Agent will refuse non-anonymised PDFs and suggest the anonymiser library
- Agent handles iterative testing, pdfplumber optimization, Python improvements, and metadata validation
- All code changes validated against 204+ test suite before recommendation
- Transaction count validation now uses SQLite `statement_lines` table (PR #95)

**Input:** $ARGUMENTS

