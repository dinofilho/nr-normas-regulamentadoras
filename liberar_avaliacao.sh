#!/bin/bash
# uso: ./liberar_avaliacao.sh 123.456.789-00 nr20
set -e
CPF="$1"
CURSO="$(echo "$2" | tr '[:upper:]' '[:lower:]')"
if [ -z "$CPF" ] || [ -z "$CURSO" ]; then
  echo "Uso: $0 <CPF> <curso: nr1|nr20|nr33|nr35|nr10|nr05|nr06>"
  exit 1
fi
CPF_NUM="$(echo "$CPF" | tr -cd 0-9)"
HASH="$(printf "%s-%s" "$CPF_NUM" "$CURSO" | sha256sum | awk "{print \$1}")"

# garante json
[ -f assets/approved.json ] || echo '{"items":[]}' > assets/approved.json

# adiciona se não tiver
if grep -q "$HASH" assets/approved.json; then
  echo "Já liberado: $CPF_NUM / $CURSO"
else
  tmp="$(mktemp)"
  jq '.items += ["'"$HASH"'"] | .items |= unique' assets/approved.json > "$tmp"
  mv "$tmp" assets/approved.json
  echo "Liberado: $CPF_NUM / $CURSO"
fi

git add assets/approved.json
git commit -m "Liberação $CPF_NUM $CURSO" >/dev/null || true
git push
