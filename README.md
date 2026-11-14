# Legal Ground Truth Platform

## Overview
A continuously ingesting legal knowledge platform that provides verified statutory, case‑law, and contractual content via an authenticated MCP server. Features include layout‑aware PDF parsing with coordinate mapping, phantom‑citation back‑log, zero‑LLM verbatim retrieval, privilege‑risk guardrails, standardized SKILL.md toolbox, prompt‑injection defense, and governance envelopes.

## Architecture
- src/ingestion: scanners, parsers, chunking, multi‑index fan‑out
- src/query: retrieval engine, RRF fusion, KG stitching, cross‑encoder rerank
- src/graph: Neo4j/ltree hybrid, phantom citation handling
- src/mcp: FastAPI/Rust gateway, tool definitions, governance middleware
- .agents/skills: SKILL.md files for client LLM orchestration
- scripts/: CI helpers, data loaders
- tests/: unit & integration tests
- docs/: design docs, API specs

## Quick Start
```bash
python -m venv env
source env/bin/activate
pip install -r requirements.txt
docker compose up -d
uvicorn src.mcp.main:app --reload
```

## License
Apache‑2.0
