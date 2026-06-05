---
description: Trigger debate between confidence and paranoia agents
agent: confidence
subtask: true
---

Start a structured debate between Confidence and Paranoia about the following project, idea, or code.

**Flow**:
1. Confidence provides initial analysis (70% theatrical, 30% grounded)
2. User will then trigger: `/paranoia_respond` with the full context below
3. Paranoia responds to Confidence's analysis (70% theatrical, 30% grounded)
4. User can continue alternating between `/confidence_respond` and `/paranoia_respond`
5. Either agent can recognize natural language signs of debate ending ("that's enough", "finish discussion", etc.)

**Initial analysis target**: $ARGUMENTS

Start with Confidence's initial analysis in debate mode (70% theatrical, 30% grounded).
