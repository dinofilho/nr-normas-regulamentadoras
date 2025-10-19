#!/bin/bash
set -e
cd ~/nr-normas-regulamentadoras

mkdir -p conteudos

# ------ helper p/ montar páginas de estudo ------
make_page () {
  local FILE="$1" TITLE="$2" OBJ="$3" CH="$4" BODY="$5"
  cat > "conteudos/$FILE" <<EOF
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<title>$TITLE – Conteúdo Programático</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-50 text-gray-900">
  <main class="max-w-4xl mx-auto p-4 sm:p-8">
    <a href="../$6" class="inline-block mb-4 text-blue-700 hover:underline">← Voltar para o curso</a>
    <h1 class="text-2xl sm:text-3xl font-bold text-blue-800 mb-2">$TITLE</h1>
    <p class="text-sm text-gray-600 mb-6">Conteúdo Programático (para estudo antes da avaliação)</p>

    <section class="bg-white border rounded-xl shadow-sm p-5 space-y-4">
      <div>
        <h2 class="text-lg font-semibold text-gray-800">Objetivo</h2>
        <p class="mt-1">$OBJ</p>
      </div>

      <div>
        <h2 class="text-lg font-semibold text-gray-800">Carga Horária</h2>
        <p class="mt-1">$CH</p>
      </div>

      <div>
        <h2 class="text-lg font-semibold text-gray-800">Conteúdos</h2>
        <div class="prose max-w-none mt-2">
          $BODY
        </div>
      </div>
    </section>

    <div class="mt-6 flex gap-3">
      <a href="../$6#avaliacao" class="inline-block bg-blue-700 text-white px-5 py-3 rounded-xl hover:bg-blue-800">Fazer Avaliação</a>
    </div>
  </main>
</body>
</html>
EOF
}

# ------ cria páginas de estudo de cada NR ------
make_page "nr1.html"  "NR-1 — Disposições Gerais e GRO" \
"Apresentar fundamentos das NRs, responsabilidades de empregador/empregado e a integração do GRO/PGR." \
"Teoria EAD." \
"<ul>
<li>Finalidade das NRs e campo de aplicação.</li>
<li>Responsabilidades: empregador (gestão de riscos, capacitar, registrar) e empregado.</li>
<li>GRO (ciclo PDCA) e integração com demais NRs.</li>
<li>PGR: Inventário de Riscos e Plano de Ação (estrutura mínima).</li>
<li>Avaliação de riscos e hierarquia de controles (eliminação → EPC → EPI).</li>
<li>Capacitação: conteúdo, avaliação, registros e EAD quando permitido.</li>
<li>Monitoramento/revisão do PGR; registros e evidências.</li>
</ul>" "nr1.html"

make_page "nr05.html" "NR-05 — CIPA" \
"Capacitar sobre objetivos, estrutura e funcionamento da CIPA e sua interface com o PGR." \
"Teoria EAD." \
"<ul>
<li>Objetivo da CIPA, dimensionamento e processo eleitoral.</li>
<li>Atribuições e papéis (presidente, vice, secretário).</li>
<li>Identificação de perigos e avaliação de riscos (interface com PGR).</li>
<li>Investigação de acidentes e quase acidentes.</li>
<li>Plano de trabalho, reuniões, atas e SIPAT.</li>
<li>Capacitação/reciclagem e documentação.</li>
</ul>" "nr05.html"

make_page "nr06.html" "NR-06 — Equipamentos de Proteção Individual (EPI)" \
"Ensinar responsabilidades, critérios de seleção e gestão de EPIs, com integração ao PGR/GRO." \
"Teoria EAD." \
"<ul>
<li>Responsabilidades de empregador e empregado.</li>
<li>Tipos de EPI e critérios de seleção conforme risco.</li>
<li>CA (Certificado de Aprovação): validade e rastreabilidade.</li>
<li>Ajuste, higienização, guarda e substituição.</li>
<li>Integração EPI ↔ PGR/GRO.</li>
<li>Registro de entrega e auditoria.</li>
</ul>" "nr06.html"

make_page "nr10.html" "NR-10 — Segurança em Instalações e Serviços em Eletricidade" \
"Tratar perigos elétricos, medidas de controle, documentação e requisitos operacionais." \
"Teoria EAD. <strong>Prática presencial obrigatória.</strong>" \
"<ul>
<li>Perigos elétricos: choque, arco e queimaduras.</li>
<li>Medidas de controle: seccionamento, aterramento, EPC/EPI e zonas.</li>
<li>Trabalho desenergizado × energizado (requisitos).</li>
<li>Bloqueio e Etiquetagem (LOTO) e documentação.</li>
<li>Prontuário/diagramas (conteúdo mínimo).</li>
<li>Procedimentos e autorização de trabalho; emergências.</li>
</ul>" "nr10.html"

make_page "nr20.html" "NR-20 — Inflamáveis e Combustíveis" \
"Abordar perigos e controles em instalações com inflamáveis/combustíveis e resposta a emergências." \
"Teoria EAD. <strong>Prática presencial conforme nível do curso.</strong>" \
"<ul>
<li>Propriedades de inflamáveis/combustíveis e perigos associados.</li>
<li>Classificação de áreas e instalações.</li>
<li>Análise de risco e medidas de controle (EPC/EPI).</li>
<li>Procedimentos e Permissão de Trabalho (PT).</li>
<li>Plano de Resposta a Emergências.</li>
<li>Sinalização, inspeções, registros e reciclagem.</li>
<li>Integração com PGR/GRO (NR-1).</li>
</ul>" "nr20.html"

make_page "nr33.html" "NR-33 — Segurança e Saúde em Espaços Confinados" \
"Tratar reconhecimento, avaliação, controle e operações seguras em EC, incluindo PET e resgate." \
"Teoria EAD. <strong>Prática presencial obrigatória.</strong>" \
"<ul>
<li>Definições e reconhecimento de Espaço Confinado (EC).</li>
<li>PET — Permissão de Entrada e Trabalho: responsabilidades.</li>
<li>Monitoramento de atmosfera e ventilação.</li>
<li>Funções: autorizado, vigia e supervisor.</li>
<li>Bloqueio/etiquetagem, comunicação e EPIs/EPCs.</li>
<li>Plano de emergência e resgate; registros e reciclagem.</li>
</ul>" "nr33.html"

make_page "nr35.html" "NR-35 — Trabalho em Altura" \
"Orientar sobre análise de risco, SPQ, EPIs, planejamento e resgate em trabalho em altura." \
"Teoria EAD. <strong>Prática presencial obrigatória.</strong>" \
"<ul>
<li>Riscos de queda e análise preliminar (APR/PGR).</li>
<li>EPIs (cinturão, talabarte, trava-quedas) e ancoragem.</li>
<li>Planejamento do trabalho e SPQ.</li>
<li>Condições impeditivas e plano de resgate.</li>
<li>Responsabilidades legais e documentação.</li>
</ul>" "nr35.html"

# ------ garante botão/link "Conteúdo Programático" nas páginas principais ------
linka_btn () {
  local FILE="$1" DEST="$2"
  [ -f "$FILE" ] || { echo "• $FILE não encontrado (ok)"; return; }

  # Se já tiver link para conteudos/DEST, não duplica
  if grep -q "conteudos/$DEST" "$FILE"; then
    echo "• $FILE já aponta para conteudos/$DEST"
    return
  fi

  # Insere um botão roxo antes do botão 'Fazer Avaliação' (se existir), senão após <main>
  BTN='<a class="inline-block bg-purple-600 hover:bg-purple-700 text-white px-5 py-3 rounded-xl mr-3" href="conteudos/'"$DEST"'">Conteúdo Programático</a>'
  if grep -q 'Fazer Avalia' "$FILE"; then
    sed -i "0,/\(Fazer Avalia\)/s//$(printf '%s' "$BTN" | sed -e 's/[\/&]/\\&/g')\n\1/" "$FILE"
    echo "✓ Botão adicionado em $FILE → conteudos/$DEST"
  elif grep -q '<main' "$FILE"; then
    sed -i "0,/<main[^>]*>/s//&\n$BTN\n/" "$FILE"
    echo "✓ Botão adicionado pós-<main> em $FILE → conteudos/$DEST"
  else
    echo -e "\n$BTN" >> "$FILE"
    echo "✓ Botão anexado ao final de $FILE → conteudos/$DEST"
  fi
}

linka_btn "nr1.html"  "nr1.html"
linka_btn "nr05.html" "nr05.html"
linka_btn "nr06.html" "nr06.html"
linka_btn "nr10.html" "nr10.html"
linka_btn "nr20.html" "nr20.html"
linka_btn "nr33.html" "nr33.html"
linka_btn "nr35.html" "nr35.html"

git add conteudos/*.html nr*.html
git commit -m "Páginas de estudo (conteudos/*.html) + botão Conteúdo Programático em todas as NRs"
git push
echo "✅ Publicado. Abra uma NR e clique em 'Conteúdo Programático'."
