# Implementation & Development Plan

## Project Overview
Legal Ground Truth Platform: Continuous legal knowledge ingestion and verified point-of-truth retrieval via an authenticated Model Context Protocol (MCP) server.

## Architectural Objectives
- Layout-aware extraction with physical page coordinate mapping (PAWLS/Docling).
- Self-healing legal graph with unresolved citation backlogs (phantom nodes).
- Fast, zero-inference verbatim statutory search using SQLite FTS5.
- Privilege & confidentiality guardrails (ABA Model Rule 1.6 / Post-Heppner screening).
- Deterministic legal hierarchy navigation via PostgreSQL `ltree`.
- Efficient CPU inference (FastEmbed ONNX runtime) for dense, sparse (SPLADE), ColBERT multi-vector, and cross-encoder reranking.
- Indirect prompt injection defense with rotating randomized delimiters.
- Mandatory governance envelopes (`not_legal_advice`, `human_review_recommended`).
- Standardized methodology playbooks via `.agents/skills/` (`SKILL.md`).

## Phase Breakdown

### Phase 1: Foundations & Storage (Weeks 1–3)
- [ ] Setup PostgreSQL with `ltree` extension for deterministic hierarchy dot-paths (`USC.Title_26.Sec_501.c.3`).
- [ ] Initialize SQLite FTS5 database schemas for verbatim statutory corpuses.
- [ ] Setup Qdrant collection schemas for dense vector embeddings.
- [ ] Establish repository OKF (Open Knowledge Format) schema and baseline test suites.

### Phase 2: Ingestion Pipeline & Layout Extraction (Weeks 4–6)
- [ ] Implement async Ingestion API gateway with HMAC signature validation and payload schemas.
- [ ] Integrate layout parser (PAWLS/Docling) to capture token-level bounding boxes (`bbox [x0, y0, x1, y1]`).
- [ ] Implement parent-child agentic chunker (100-token child chunks mapped to parent `ltree` nodes).
- [ ] Configure FastEmbed (ONNX Runtime) embedding pipelines for Dense and SPLADE sparse representations.
- [ ] Implement multi-index fan-out worker pipeline with Redis status aggregation.

### Phase 3: Crawlers, Scrapers & Self-Healing Backlog (Weeks 7–8)
- [ ] Build scrapers for Federal Register, state gazettes, and court dockets with webhook support.
- [ ] Implement phantom graph nodes (`status: unresolved`) for missing external statutory citations.
- [ ] Implement Redis stream consumer for automated citation scraping backlog.
- [ ] Add cost controls and feature flags (`X-Feature-Flag: paid_crawler`) for metered sources (e.g., PACER).

### Phase 4: Retrieval, Fusion & Guardrails (Weeks 9–11)
- [ ] Implement 3-way hybrid retrieval: Dense (Qdrant) + Sparse (SQLite FTS5 / SPLADE) + ColBERT.
- [ ] Build Reciprocal Rank Fusion (RRF, $k=60$) blending algorithm.
- [ ] Implement single-shot parent hierarchy context stitching via PostgreSQL `ltree` (`@>` operator).
- [ ] Add FastEmbed cross-encoder reranker (`cross-encoder/ms-marco-MiniLM-L-6-v2`).
- [ ] Implement privilege screening guardrail (`check_privilege_risk`) with audit logging.
- [ ] Implement indirect prompt injection defense (`<<<UNTRUSTED_CONTENT_{hash}>>>`).
- [ ] Implement citation grounding verification against ground-truth indices.

### Phase 5: Commercial MCP Gateway & Agent Skills (Weeks 12–14)
- [ ] Build authenticated MCP server exposing JSON-RPC tools (`legal_search`, `get_statute_verbatim`, `get_statutory_context`, `verify_citation`, `get_highlight`).
- [ ] Implement mandatory governance envelope middleware for all tool responses.
- [ ] Implement multi-tenant token bucket rate limiting (Redis Lua script) and API key validation.
- [ ] Create standardized agent skills in `.agents/skills/` (`SKILL.md` workflows).
- [ ] Implement evaluation suite: Ragas faithfulness benchmark, Context Recall@k, and adversarial tests.
