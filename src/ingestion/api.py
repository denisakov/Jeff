# src/ingestion/api.py
"""Ingestion API routes (FastAPI)."""
from fastapi import APIRouter, Request, HTTPException
router=APIRouter()
@router.post("/ingest",status_code=202)
def ingest(request:Request):
  payload=request.json()
  # validation placeholder
  return{"status":"accepted"}
