#!/usr/bin/env python3
"""
United Europe - Knowledge Forge API
API funcțional minim pentru testare
"""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from datetime import datetime
import os

# Inițializez FastAPI
app = FastAPI(
    title="United Europe - Knowledge Forge API",
    description="Sistem de Management al Bazei de Cunoștințe Offline",
    version="1.0.0"
)

# Adaug CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Modele Pydantic pentru request/response
class AskRequest(BaseModel):
    question: str
    k: int = 4

class AskResponse(BaseModel):
    answer: str
    sources: list = []

# ═══════════════════════════════════════════════════════════════
# ENDPOINT-URI API
# ═══════════════════════════════════════════════════════════════

@app.get("/")
def read_root():
    """Endpoint principal - confirmă că API-ul funcționează"""
    return {
        "message": "🏛️ United Europe - Knowledge Forge API funcționează!",
        "status": "operational",
        "timestamp": datetime.now().isoformat(),
        "version": "1.0.0"
    }

@app.get("/health")
def health_check():
    """Verificare sănătate API"""
    return {
        "status": "healthy",
        "service": "Knowledge Forge API",
        "timestamp": datetime.now().isoformat(),
        "python_version": os.sys.version,
        "working_directory": os.getcwd()
    }

@app.post("/ask", response_model=AskResponse)
def ask_question(request: AskRequest):
    """
    Endpoint pentru întrebări
    Momentan returnează un răspuns mock - va fi implementat complet
    """
    mock_answer = f"""
    Ai întrebat: "{request.question}"
    
    Aceasta este o implementare de testare a API-ului Knowledge Forge.
    
    Pentru a obține răspunsuri reale:
    1. Rulează 'make ingest' pentru a procesa documentele
    2. Rulează 'make index' pentru a construi indexul de căutare
    3. API-ul va folosi baza de cunoștințe pentru răspunsuri reale
    
    Timestamp: {datetime.now().isoformat()}
    """
    
    return AskResponse(
        answer=mock_answer.strip(),
        sources=[
            {
                "title": "Document de test",
                "path": "/path/to/test/document.txt",
                "created": datetime.now().strftime("%Y-%m-%d")
            }
        ]
    )

@app.post("/ingest")
def start_ingest():
    """Pornește procesarea documentelor"""
    return {
        "status": "started",
        "message": "Procesarea documentelor a început",
        "timestamp": datetime.now().isoformat()
    }

@app.post("/index")
def start_index():
    """Pornește construirea indexului"""
    return {
        "status": "started", 
        "message": "Construirea indexului a început",
        "timestamp": datetime.now().isoformat()
    }

# ═══════════════════════════════════════════════════════════════
# STARTUP EVENT
# ═══════════════════════════════════════════════════════════════

@app.on_event("startup")
async def startup_event():
    """Event de pornire"""
    print("🏛️ United Europe - Knowledge Forge API")
    print("=" * 50)
    print("✅ API pornit cu succes!")
    print("🌐 Documentație: http://localhost:8000/docs")
    print("🔍 Health check: http://localhost:8000/health")
    print("=" * 50)

if __name__ == "__main__":
    import uvicorn
    print("🚀 Pornesc serverul de dezvoltare...")
    uvicorn.run("api:app", host="0.0.0.0", port=8000, reload=True)
