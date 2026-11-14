# ROADMAP.md — Legal Ground Truth Platform

## Milestone 1: Foundations & Storage Engines (v0.1.0)
**Goal:** Establish PostgreSQL `ltree` schema, SQLite FTS5 database, Qdrant client connection, and FastEmbed ONNX CPU runtime.
- [ ] Phase 1.1: Docker environment configuration (Postgres + `ltree`, Qdrant, Redis).
- [ ] Phase 1.2: Database schema definitions & migrations (`sections` table with `path LTREE`, `bbox JSONB`).
- [ ] Phase 1.3: SQLite FTS5 schema & test statutory database generator.
- [ ] Phase 1.4: FastEmbed ONNX inference pipeline verification (Dense + SPLADE + ColBERT + Cross-Encoder).

## Milestone 2: Ingestion API & Layout Coordinate Extraction (v0.2.0)
**Goal:** Implement async Ingestion API gateway, HMAC authentication, layout coordinate extraction, and parent-child chunking.
- [ ] Phase 2.1: FastAPI `/ingest` payload validation and HMAC-SHA256 signature middleware.
- [ ] Phase 2.2: PDF layout coordinate mapping pipeline (`bbox [x0, y0, x1, y1]` extraction).
- [ ] Phase 2.3: Parent-child chunker generating dot-path hierarchy identifiers.
- [ ] Phase 2.4: 4-Way multi-index fan-out workers with Redis status synchronization.

## Milestone 3: Continuous Crawlers & Self-Healing Backlog (v0.3.0)
**Goal:** Ingest from external feeds, detect unresolved citations, and self-heal missing knowledge.
- [ ] Phase 3.1: Source crawler microservices with webhook listeners.
- [ ] Phase 3.2: Phantom citation node generation (`status: unresolved`) for missing statutes.
- [ ] Phase 3.3: Redis stream backlog consumer for automated citation scraping.
- [ ] Phase 3.4: Cost control feature flags (`X-Feature-Flag: paid_crawler`) for metered endpoints.

## Milestone 4: Query Engine, Context Stitching & Guardrails (v0.4.0)
**Goal:** 3-Way hybrid retrieval, RRF fusion, `ltree` context stitching, reranking, and privilege/injection guardrails.
- [ ] Phase 4.1: Parallel retrieval over Dense (Qdrant), Sparse (FTS5/SPLADE), and ColBERT.
- [ ] Phase 4.2: Reciprocal Rank Fusion (RRF, $k=60$) blending algorithm.
- [ ] Phase 4.3: PostgreSQL `ltree` single-query ancestor walk-up context stitcher.
- [ ] Phase 4.4: FastEmbed cross-encoder reranking.
- [ ] Phase 4.5: Privilege screening guardrail (`check_privilege_risk`) and audit logging.
- [ ] Phase 4.6: Rotating token prompt injection defense and citation grounding verifier.

## Milestone 5: Authenticated MCP Gateway & Agent Skills (v1.0.0)
**Goal:** Commercial-ready MCP server with JSON-RPC tools, governance envelopes, rate limits, and `.agents/skills/`.
- [ ] Phase 5.1: MCP protocol handler (SSE / Stdio) with tool definitions.
- [ ] Phase 5.2: Mandatory governance envelope middleware.
- [ ] Phase 5.3: API key authentication and Redis token bucket rate limiting.
- [ ] Phase 5.4: Bundled client methodology playbooks (`.agents/skills/*.SKILL.md`).
- [ ] Phase 5.5: End-to-end evaluation suite (Ragas Faithfulness, Recall@k, adversarial benchmarks).
