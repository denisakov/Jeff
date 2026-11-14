# Engineering Changelog & Activity Log

All significant technical decisions, code implementations, schema migrations, and operational updates are logged chronologically here.

## [2026-11-14] - Project Kickoff & Repository Initialization
- **Author**: Platform Architecture Team
- **Actions Completed**:
  - Established project structure with modular microservice packages (`src/ingestion`, `src/query`, `src/graph`, `src/mcp`).
  - Incorporated architectural recommendations:
    - PostgreSQL `ltree` for deterministic hierarchy navigation.
    - FastEmbed (ONNX Runtime) CPU inference for multi-vector and dense representations.
    - In-process SQLite FTS5 for zero-inference verbatim statutory serving.
    - Coordinate bounding box mapping (`bbox`) for visual ground truth.
    - ABA Model Rule 1.6 / Post-Heppner privilege screening guardrail.
    - Standardized `.agents/skills/` layer.
    - Mandatory governance envelopes (`not_legal_advice: true`).
    - Rotating token prompt-injection defense.
  - Configured git remote and credential flow via GitHub CLI (`gh auth setup-git`).
  - Pushed initial scaffold to GitHub repository: `https://github.com/denisakov/Jeff.git`.
  - Created development plan, progress tracker, and changelog structure in `docs/plan/`.
- **Decisions & Rationale**:
  - Replaced Neo4j heavy N-hop graph traversals for document hierarchy with PostgreSQL `ltree` to achieve sub-10ms ancestor lookups.
  - Substituted full PyTorch runtime with FastEmbed ONNX to ensure light container footprint and cost-effective CPU scaling.

---

## Log Template for New Entries
```markdown
## [YYYY-MM-DD] - <Work Item Title>
- **Author**: <Name or Role>
- **Phase/Component**: <Phase 1-5 / Ingestion, Query, MCP, etc.>
- **Changes Implemented**:
  - <Item 1>
  - <Item 2>
- **Testing & Verification**:
  - <Test runs, benchmarks, or command output>
- **Blockers / Next Steps**:
  - <Any open items or next tasks>
```
