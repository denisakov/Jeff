CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "ltree";

CREATE TABLE IF NOT EXISTS documents (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  source TEXT NOT NULL,
  uri TEXT NOT NULL UNIQUE,
  jurisdiction TEXT NOT NULL,
  published_at TIMESTAMPTZ NOT NULL,
  effective_from TIMESTAMPTZ NOT NULL,
  effective_to TIMESTAMPTZ,
  version TEXT NOT NULL,
  title TEXT,
  metadata JSONB DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS sections (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  document_id UUID REFERENCES documents(id) ON DELETE CASCADE,
  path LTREE NOT NULL,
  section_id TEXT NOT NULL,
  title TEXT,
  content TEXT NOT NULL,
  bbox JSONB,
  page_number INT,
  tenant_id TEXT DEFAULT 'global',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_sections_path ON sections USING GIST (path);
CREATE INDEX IF NOT EXISTS idx_sections_tenant ON sections (tenant_id);
CREATE INDEX IF NOT EXISTS idx_sections_document_id ON sections (document_id);

CREATE TABLE IF NOT EXISTS phantom_citations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  source_document_id UUID REFERENCES documents(id) ON DELETE CASCADE,
  citation TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'unresolved',
  attempts INT DEFAULT 0,
  last_attempt_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  CONSTRAINT uq_citation UNIQUE (citation)
);

CREATE INDEX IF NOT EXISTS idx_phantom_status ON phantom_citations (status);
