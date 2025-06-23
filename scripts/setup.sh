#!/bin/bash
# Script de setup pentru Knowledge Forge

echo "🏛️ United Europe - Knowledge Forge Setup"
echo "========================================"

echo "🔍 Verific dependențele..."

# Verifică Python și pip3
if ! command -v python3 &>/dev/null; then
    echo "❌ Python 3 nu este instalat"
    exit 1
fi

if ! command -v pip3 &>/dev/null; then
    echo "❌ pip3 nu este instalat"
    exit 1
fi

echo "📦 Instalez dependențele Python..."
pip3 install -r backend/requirements.txt

if command -v npm &>/dev/null && command -v npx &>/dev/null; then
    if [ ! -d ui ]; then
        echo "⚛️ Generez UI-ul Next.js..."
        make setup-ui
    elif [ -f ui/package.json ]; then
        echo "📦 Instalez dependențele Node.js..."
        cd ui && npm install && cd ..
    fi
fi

echo "✅ Setup complet!"
echo "🚀 Rulează 'make api' pentru a porni serverul"
