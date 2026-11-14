# REQUIREMENTS.md — Legal Ground Truth Platform

## 1. Functional Requirements

### FR-01: Ingestion & Layout-Aware Parsing
- Ingestion API endpoint (`/ingest`) validates payloads using HMAC-SHA256 signatures.
- Layout parser extracts physical page token bounding boxes (`bbox [x0, y0, x1, y1]`) per paragraph and table cell.
- Parent-child chunking generates 100-token searchable child chunks mapped to parent sections with dot-path hierarchy identifiers.

### FR-02: Deterministic Storage & Indexing
- Hierarchical document sections indexed in PostgreSQL using `ltree` with GiST indexes.
- Semantic embeddings stored in Qdrant vector database (`legal_dense`).
- Full-text statutory articles indexed in in-process SQLite FTS5 database (`statutes.db`).
- Token-level representations indexed for ColBERT late-interaction matching.

### FR-03: Self-Healing Citation Graph
- Ingestion identifies cited external statutes not present in local storage.
- Missing citations created as phantom graph nodes (`status: unresolved`) and enqueued in Redis streams.
- Dedicated crawler workers consume Redis stream and scrape missing statutes.

### FR-04: Hybrid Retrieval & Context Stitching
- Query engine executes 3-way hybrid search: Dense + Sparse (SQLite FTS5 / SPLADE) + ColBERT.
- Blends candidate rankings using Reciprocal Rank Fusion (RRF, $k=60$).
- Single-query parent context stitching executed via PostgreSQL `ltree` (`@>` ancestor operator).
- Candidates reranked via FastEmbed cross-encoder (`cross-encoder/ms-marco-MiniLM-L-6-v2`).

### FR-05: Privilege & Security Guardrails
- Pre-retrieval privilege screening (`check_privilege_risk`) checks query payload against ABA Model Rule 1.6 / Post-Heppner criteria.
- Indirect prompt injection defense wraps external retrieved passages in rotating random boundary tokens (`<<<UNTRUSTED_CONTENT_{hash}>>>`).
- Verbatim statutory lookup (`get_statute_verbatim`) returns pure statutory text with $0 LLM inference.

### FR-06: Authenticated MCP Gateway & Governance
- Exposes MCP tools: `legal_search`, `get_statute_verbatim`, `get_statutory_context`, `verify_citation`, `get_highlight`.
- All JSON-RPC tool responses strictly include top-level governance envelope:
  `{ not_legal_advice: true, human_review_recommended: true, jurisdiction: string, retrieval_timestamp: string }`.
- Multi-tenant API key validation with Redis token bucket rate limiting.
- Exposes standardized agent playbooks in `.agents/skills/` (`SKILL.md`).

## 2. Non-Functional Requirements
- **Latency**: P95 retrieval latency ≤ 300ms; P99 ≤ 600ms. Verbatim FTS5 retrieval ≤ 5ms.
- **Resource Footprint**: FastEmbed ONNX runtime runs on CPU without requiring dedicated PyTorch GPU clusters.
- **Accuracy**: Ragas Faithfulness ≥ 0.85; Citation Grounding Precision ≥ 0.98.
