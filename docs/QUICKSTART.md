# Start Rapid

## 1. Instalare Completă
```bash
cd knowledge-forge
make setup      # Instalează backend + generează UI Next.js
```

## 2. Pornire Backend
```bash
make api        # http://localhost:8000
```

## 3. Pornire Frontend
```bash
make ui         # http://localhost:3000
```

## 4. Aplicația Completă
```bash
make run        # Pornește backend + frontend simultan
```

## UI Features
- Design modern cu TailwindCSS
- Form pentru întrebări
- Răspunsuri în timp real
- Status cards pentru monitorizare

## Troubleshooting
- `make verify` - verifică instalarea
- `make setup-ui` - regenerează UI-ul
- `make clean` - curăță și reinstalează

## Dependințe Node.js
Dacă npm/npx nu sunt instalate:
1. Descarcă Node.js din https://nodejs.org
2. Rulează `make setup-ui` pentru a genera UI-ul
