# Progress Tracker & Milestone Status

## Overall Status Summary
- **Current Phase**: Phase 1 (Foundation & Storage)
- **Active Sprint**: Sprint 1 — Storage Engines & Core Schemas
- **Last Updated**: 2026-11-14

## Milestone Progress Matrix

| Milestone | Target Completion | Status | Owner | Blockers / Dependencies |
| :--- | :--- | :--- | :--- | :--- |
| **M1: Core Storage & Schemas** | Week 3 | In Progress | Core Eng | None |
| **M2: Ingestion & Layout BBox** | Week 6 | Pending | Ingestion Team | M1 |
| **M3: Crawlers & Phantom Backlog** | Week 8 | Pending | Data Team | M2 |
| **M4: Hybrid Retrieval & Fusion** | Week 11 | Pending | Search Team | M2, M3 |
| **M5: MCP Service & Governance** | Week 14 | Pending | Platform Team | M4 |

## Granular Work Package Checklist

### Phase 1: Storage & Schemas
- [x] Repository scaffold & GitHub sync configured
- [ ] PostgreSQL Docker configuration with `ltree` extension enabled
- [ ] Schema definition for `sections` table (`path LTREE`, `bbox JSONB`)
- [ ] SQLite FTS5 database bootstrap script for verbatim statutes
- [ ] Qdrant collection setup (`legal_dense`) via Python client
- [ ] FastEmbed baseline ONNX runtime benchmark on CPU

### Phase 2: Ingestion & Layout
- [ ] FastAPI `/ingest` payload schema validation (Pydantic v2)
- [ ] HMAC-SHA256 signature verification middleware
- [ ] PDF parser pipeline with token bounding box coordinate mapping
- [ ] Parent-child chunking with dot-path hierarchy generator
- [ ] Redis status aggregator for 4-way indexing synchronization

### Phase 3: Crawlers & Scraping
- [ ] Webhook listeners for OKF Git commits
- [ ] Unresolved citation backlog queue in Redis
- [ ] PACER / paid crawl feature gating & spend warning emitter

### Phase 4: Retrieval Engine
- [ ] Parallel query executor (Dense + SQLite FTS5 + ColBERT)
- [ ] RRF rank fusion algorithm ($k=60$)
- [ ] `ltree` parent context hierarchy fetcher
- [ ] Privilege risk screening regex pipeline & audit logger
- [ ] Prompt injection randomized token wrapper

### Phase 5: MCP Server & Skills
- [ ] MCP JSON-RPC protocol router over SSE / stdio
- [ ] Mandatory governance envelope middleware
- [ ] Per-tenant Redis token bucket rate limiter
- [ ] Client methodology playbooks (`.agents/skills/*.SKILL.md`)
- [ ] Automated Ragas evaluation benchmark
