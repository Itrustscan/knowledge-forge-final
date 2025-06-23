#!/bin/bash
# Verificare dependențe

echo "🔍 Verificare dependențe Knowledge Forge"
echo "========================================"

# Verifică Python
if command -v python3 &>/dev/null; then
    echo "✅ Python 3: $(python3 --version)"
else
    echo "❌ Python 3 nu este instalat"
fi

# Verifică pip3
if command -v pip3 &>/dev/null; then
    echo "✅ pip3: disponibil"
else
    echo "❌ pip3 nu este instalat"
fi

# Verifică npm
if command -v npm &>/dev/null; then
    echo "✅ npm: $(npm --version)"
else
    echo "⚠️ npm nu este instalat (necesar pentru UI)"
fi

# Verifică npx
if command -v npx &>/dev/null; then
    echo "✅ npx: disponibil"
else
    echo "⚠️ npx nu este disponibil (necesar pentru UI)"
fi

# Verifică FastAPI
if pip3 show fastapi &>/dev/null; then
    echo "✅ FastAPI: instalat"
else
    echo "❌ FastAPI nu este instalat"
fi

# Verifică uvicorn
if pip3 show uvicorn &>/dev/null; then
    echo "✅ Uvicorn: instalat"
else
    echo "❌ Uvicorn nu este instalat"
fi
