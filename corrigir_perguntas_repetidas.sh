#!/bin/bash
set -e
cd assets/questions

limpar_json() {
  local arquivo="$1"
  echo "Corrigindo: $arquivo"
  jq 'unique_by(.pergunta)' "$arquivo" > tmp.json && mv tmp.json "$arquivo"
}

limpar_json "nr1.json"
limpar_json "nr20.json"

cd ../..
git add assets/questions/nr1.json assets/questions/nr20.json
git commit -m "Removidas perguntas repetidas das avaliações NR-1 e NR-20"
git push
echo "✅ Perguntas duplicadas removidas com sucesso!"
