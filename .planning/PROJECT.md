# PROJECT.md — Legal Ground Truth Platform

## Project Overview
A continuously ingesting legal knowledge platform serving as a verified point-of-truth for third-party LLMs and enterprise copilots via an authenticated Model Context Protocol (MCP) gateway.

## Core Problem & Value Proposition
- **The Problem:** General-purpose LLMs hallucinate statutes, fail to cite accurate physical paragraphs in PDF sources, risk waiving attorney-client privilege (Post-Heppner), and incur high GPU inference costs for verbatim statutory lookups.
- **The Solution:** A decoupled legal knowledge architecture featuring layout-aware coordinate mapping (`bbox`), deterministic hierarchy navigation via PostgreSQL `ltree`, zero-inference verbatim statutory search using SQLite FTS5, privilege screening, self-healing phantom graph nodes for missing cross-references, and an authenticated, rate-limited MCP gateway.

## Technical Architecture & Decisions
- **Hierarchy & Document Storage:** PostgreSQL with `ltree` extension for deterministic dot-paths (`USC.Title_26.Sec_501.c.3`) to achieve single-digit millisecond parent-child traversal.
- **Dense Vector Search:** Qdrant collection (`legal_dense`) for semantic similarity.
- **Verbatim Statute Serving:** In-process SQLite FTS5 database (`statutes.db`) for $0 inference deterministic statutory queries.
- **Embedding & Reranker Runtime:** FastEmbed (CPU via ONNX Runtime) running dense, SPLADE++, ColBERT token-level, and cross-encoders without heavy PyTorch/CUDA dependencies.
- **Visual Ground Truth:** PAWLS/Docling bounding box extraction mapped to `bbox [x0, y0, x1, y1]` in PostgreSQL `jsonb`.
- **Self-Healing Graph Backlog:** Unresolved external statutory citations queued into Redis streams for automated ingestion.
- **Privilege & Ethical Guardrails:** Pre-inference privilege risk screening (`check_privilege_risk`) complying with ABA Model Rule 1.6 and United States v. Heppner precedents.
- **Prompt Injection Defense:** Randomized rotating boundary wrappers (`<<<UNTRUSTED_CONTENT_{hash}>>>`).
- **Commercial MCP Gateway:** JSON-RPC over SSE / Stdio with mandatory governance envelopes (`not_legal_advice: true`, `human_review_recommended: true`).
- **Standardized Methodology:** Bundled `.agents/skills/*.SKILL.md` playbooks.

## Project Structure
- `src/ingestion`: Scanners, parsers, chunking, and multi-index fan-out.
- `src/query`: 3-way hybrid retrieval, RRF fusion, parent stitching, cross-encoder reranking.
- `src/graph`: PostgreSQL `ltree` hierarchy and phantom citation backlog.
- `src/mcp`: FastAPI/Rust MCP gateway, tool definitions, governance middleware.
- `.agents/skills`: Standardized SKILL.md methodology playbooks for client LLMs.
- `docs/plan`: Human-facing implementation plan and progress docs.
- `.planning`: GSD operational state, roadmap, and milestone tracking.
