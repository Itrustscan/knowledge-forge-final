.PHONY: help setup install run clean test api ui ingest index verify setup-ui

# Default target
help:
	@echo "🏛️ United Europe - Knowledge Forge"
	@echo "=================================="
	@echo ""
	@echo "Comenzi disponibile:"
	@echo "  make setup     - Instalare completă (backend + UI)"
	@echo "  make setup-ui  - Generează doar UI-ul Next.js"
	@echo "  make run       - Pornește aplicația completă"
	@echo "  make api       - Pornește doar backend-ul"
	@echo "  make ui        - Pornește doar frontend-ul"
	@echo "  make ingest    - Procesează documente"
	@echo "  make index     - Construiește indexul"
	@echo "  make verify    - Verifică instalarea"
	@echo "  make clean     - Curăță fișierele generate"

# Instalare completă
setup:
	@echo "🚀 Instalez Knowledge Forge complet..."
	@echo "📦 Instalez dependențele Python..."
	@pip3 install -r backend/requirements.txt || (echo "❌ Eroare la instalarea pachetelor Python" && exit 1)
	@if command -v npm >/dev/null 2>&1 && command -v npx >/dev/null 2>&1; then \
		echo "⚛️ Generez UI-ul Next.js cu TailwindCSS..."; \
		make setup-ui; \
	else \
		echo "⚠️ npm/npx nu sunt disponibile - UI-ul va fi sărit"; \
		echo "💡 Instalează Node.js din https://nodejs.org pentru UI complet"; \
	fi
	@echo "✅ Instalarea completă!"

# Generează UI-ul Next.js cu TailwindCSS
setup-ui:
	@echo "⚛️ Generez UI-ul Next.js cu TailwindCSS + TypeScript..."
	@if ! command -v npm >/dev/null 2>&1; then \
		echo "❌ npm nu este instalat"; \
		echo "💡 Instalează Node.js din https://nodejs.org"; \
		exit 1; \
	fi
	@if ! command -v npx >/dev/null 2>&1; then \
		echo "❌ npx nu este disponibil"; \
		echo "💡 Reinstalează Node.js corect"; \
		exit 1; \
	fi
	@if [ -d ui ]; then \
		echo "🗑️ Șterg UI-ul existent..."; \
		rm -rf ui; \
	fi
	@echo "📦 Creez proiectul Next.js cu TailwindCSS..."
	@npx create-next-app@latest ui --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm --no-git
	@echo "🔧 Configurez UI-ul pentru Knowledge Forge..."
	@cd ui && npm install @types/node @types/react @types/react-dom
	@echo "✅ UI generat cu succes!"

# Pornește API-ul backend
api:
	@echo "🚀 Pornesc API-ul backend..."
	@if ! command -v uvicorn >/dev/null 2>&1; then \
		echo "📦 Instalez uvicorn..."; \
		pip3 install uvicorn; \
	fi
	@echo "🌐 API disponibil la: http://localhost:8000"
	@cd backend && uvicorn api:app --reload --host 0.0.0.0 --port 8000

# Pornește frontend-ul
ui:
	@echo "⚛️ Pornesc frontend-ul Next.js..."
	@if [ ! -d ui ]; then \
		echo "❌ UI-ul nu este generat!"; \
		echo "🔧 Rulează 'make setup-ui' pentru a-l genera"; \
		exit 1; \
	fi
	@if [ ! -d ui/node_modules ]; then \
		echo "📦 Instalez dependențele Node.js..."; \
		cd ui && npm install; \
	fi
	@echo "🌐 Frontend disponibil la: http://localhost:3000"
	@cd ui && npm run dev

# Pornește aplicația completă
run:
	@echo "🔧 Pornesc Knowledge Forge complet..."
	@if ! command -v uvicorn >/dev/null 2>&1; then \
		echo "📦 Instalez uvicorn..."; \
		pip3 install uvicorn; \
	fi
	@trap 'kill 0' EXIT; \
	echo "🚀 Pornesc backend-ul pe portul 8000..."; \
	(cd backend && uvicorn api:app --reload --host 0.0.0.0 --port 8000) & \
	if [ -d ui ] && command -v npm >/dev/null 2>&1; then \
		sleep 3; \
		echo "⚛️ Pornesc frontend-ul pe portul 3000..."; \
		(cd ui && npm run dev) & \
	else \
		echo "⚠️ Frontend indisponibil - doar backend activ"; \
		echo "💡 Rulează 'make setup-ui' pentru a genera UI-ul"; \
	fi; \
	wait

# Procesează documente
ingest:
	@echo "📄 Procesez documentele..."
	@if [ -f backend/ingest.py ]; then \
		python3 backend/ingest.py; \
	else \
		echo "❌ Scriptul de ingest nu există"; \
	fi

# Construiește indexul de căutare
index:
	@echo "🔍 Construiesc indexul de căutare..."
	@if [ -f backend/build_index.py ]; then \
		python3 backend/build_index.py; \
	else \
		echo "❌ Scriptul de indexare nu există"; \
	fi

# Verifică instalarea
verify:
	@echo "🔍 Verific instalarea..."
	@echo "Dependențe sistem:"
	@python3 --version 2>/dev/null || echo "❌ Python 3 lipsește"
	@pip3 --version 2>/dev/null || echo "❌ pip3 lipsește"
	@if command -v npm >/dev/null 2>&1; then echo "✅ npm: $$(npm --version)"; else echo "⚠️ npm lipsește"; fi
	@if command -v npx >/dev/null 2>&1; then echo "✅ npx: disponibil"; else echo "⚠️ npx lipsește"; fi
	@echo ""
	@echo "Dependențe Python:"
	@pip3 show fastapi >/dev/null 2>&1 && echo "✅ FastAPI instalat" || echo "❌ FastAPI lipsește"
	@pip3 show uvicorn >/dev/null 2>&1 && echo "✅ Uvicorn instalat" || echo "❌ Uvicorn lipsește"
	@echo ""
	@echo "Fișiere proiect:"
	@if [ -f backend/api.py ]; then echo "✅ backend/api.py"; else echo "❌ backend/api.py lipsește"; fi
	@if [ -f backend/requirements.txt ]; then echo "✅ backend/requirements.txt"; else echo "❌ backend/requirements.txt lipsește"; fi
	@if [ -d ui ]; then echo "✅ ui/ generat"; else echo "⚠️ ui/ nu este generat - rulează 'make setup-ui'"; fi
	@if [ -f ui/package.json ]; then echo "✅ ui/package.json"; else echo "⚠️ ui/package.json lipsește"; fi

# Curăță fișierele generate
clean:
	@echo "🧹 Curăț fișierele generate..."
	@rm -rf backend/__pycache__ backend/*.pyc
	@rm -rf ui/node_modules ui/.next ui/out
	@rm -rf src-tauri/target
	@echo "✨ Curățenie completă!"
