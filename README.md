# 🏛️ United Europe - Knowledge Forge

**Sistem de Management al Bazei de Cunoștințe Offline**

## 🚀 Start Rapid

```bash
cd knowledge-forge
make setup      # Instalează backend + generează UI Next.js
make api        # Pornește backend-ul (port 8000)
make ui         # Pornește frontend-ul (port 3000)
```

Sau pentru aplicația completă:
```bash
make run        # Pornește backend + frontend simultan
```

## 📋 Comenzi Disponibile

- `make setup` - Instalare completă (backend + UI Next.js)
- `make setup-ui` - Generează doar UI-ul Next.js cu TailwindCSS
- `make api` - Pornește backend-ul (port 8000)
- `make ui` - Pornește frontend-ul (port 3000)
- `make run` - Pornește aplicația completă
- `make verify` - Verifică instalarea
- `make clean` - Curăță fișierele generate

## 🎨 Frontend UI

UI-ul este construit cu:
- **Next.js 14** (App Router)
- **TailwindCSS** pentru styling
- **TypeScript** pentru type safety
- Design responsive și modern

## 🔧 Configurare

1. Editează `backend/.env` cu căile tale
2. Rulează `make ingest` pentru a procesa documentele
3. Rulează `make index` pentru a construi indexul de căutare

## 🌐 API Endpoints

- `GET /` - Pagina principală
- `GET /health` - Verificare sănătate
- `POST /ask` - Întrebări despre documente
- `GET /docs` - Documentația API

## 📋 Dependențe

### Backend (Python)
- FastAPI + Uvicorn
- Sentence Transformers
- ChromaDB pentru vector search

### Frontend (Node.js)
- Next.js 14
- TailwindCSS
- TypeScript

## 📄 Licență

MIT License - vezi fișierul LICENSE
