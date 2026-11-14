# STATE.md — Legal Ground Truth Platform

## Current Lifecycle State
- **Current Milestone:** Milestone 1 — Foundations & Storage Engines (v0.1.0)
- **Active Phase:** Phase 1.1 — Docker Environment Configuration
- **Status:** In Progress
- **Last Updated:** 2026-11-14

## Active Decisions
- Primary hierarchy model: PostgreSQL `ltree` via GiST index (replacing standalone Neo4j for section tree).
- Primary verbatim lookup engine: SQLite FTS5 (zero GPU inference cost).
- Primary embedding runtime: FastEmbed on CPU via ONNX Runtime.

## Next Work Items
1. Create `docker-compose.yml` defining PostgreSQL (with `ltree`), Qdrant, and Redis services.
2. Verify Docker service startup and health checks.
3. Write database schema migration for the `sections` table (`id`, `path LTREE`, `title`, `content`, `bbox JSONB`, `tenant_id`).
