#!/bin/bash
set -e
cd ~/nr-normas-regulamentadoras
mkdir -p conteudos

mk() { # mk <arquivo> <titulo> <volta> <html_do_conteudo>
  local F="$1" T="$2" BACK="$3" BODY="$4"
  cat > "conteudos/$F" <<EOF
<!doctype html><html lang="pt-br"><head>
<meta charset="utf-8"/><meta name="viewport" content="width=device-width,initial-scale=1"/>
<title>$T – Conteúdo completo</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head><body class="bg-gray-50 text-gray-900">
<main class="max-w-5xl mx-auto p-4 sm:p-8">
  <a class="inline-block mb-4 text-blue-700 hover:underline" href="../$BACK">← Voltar ao curso</a>
  <h1 class="text-3xl font-bold text-blue-800 mb-1">$T</h1>
  <p class="text-sm text-gray-600 mb-6">Conteúdo completo para estudo antes da avaliação</p>
  <div class="space-y-6">$BODY</div>
  <div class="mt-8">
    <a href="../$BACK#avaliacao" class="inline-block bg-blue-700 hover:bg-blue-800 text-white px-5 py-3 rounded-xl">Fazer Avaliação</a>
  </div>
</main>
</body></html>
EOF
}

sec() { # sec <titulo> <html>
  echo "<section class='bg-white border rounded-xl shadow-sm p-5'><h2 class='text-xl font-semibold mb-2'>$1</h2>$2</section>"
}

ul() { # ul <li;li;li>
  local IFS=';'; local arr=($1); echo "<ul class='list-disc ml-6 space-y-1'>"; for x in "${arr[@]}"; do echo "<li>$x</li>"; done; echo "</ul>"
}

# -------------------- NR-1 --------------------
mk "nr1.html" "NR-1 — Disposições Gerais e GRO" "nr1.html" "$(
  sec 'Objetivo' "<p>Apresentar fundamentos das NRs, responsabilidades e a gestão de riscos por meio do GRO/PGR.</p>"
  sec 'Público-alvo' "$(ul 'Trabalhadores em geral;Supervisores e gestores;Profissionais de SST')"
  sec 'Requisitos' "$(ul 'Leitura prévia das políticas internas;Sem pré-requisito técnico')"
  sec 'Carga horária sugerida' '<p>Teoria EAD.</p>'
  sec 'Conteúdo Programático' "$(
    ul 'Finalidade das NRs e campo de aplicação;Definições básicas;Responsabilidades: empregador (gestão, capacitar, registrar) e empregado;GRO — ciclo PDCA e integração com demais NRs;PGR — Inventário de Riscos e Plano de Ação: estrutura mínima;Avaliação de riscos e hierarquia de controles (eliminação → EPC → EPI);Capacitação: conteúdo, avaliação, registros e quando EAD é permitido;Monitoramento, medição e revisão do PGR;Registros e guarda de evidências'
  )"
  sec 'Avaliação e critérios' "$(ul 'Prova teórica EAD (≥70%);Registro nominal da avaliação')" 
  sec 'Registros/Certificados' "$(ul 'Lista de presença (quando aplicável);Registro da avaliação;Comprovante com nome/CPF/nota')" 
  sec 'Observações legais' "<p>Os tópicos devem estar alinhados às versões vigentes das NRs.</p>"
)"

# -------------------- NR-05 -------------------
mk "nr05.html" "NR-05 — CIPA" "nr05.html" "$(
  sec 'Objetivo' "<p>Apresentar objetivos, estrutura e funcionamento da CIPA e sua interface com o PGR.</p>"
  sec 'Público-alvo' "$(ul 'Membros eleitos/indicados;Gestores e RH;SST')"
  sec 'Requisitos' "$(ul 'Sem pré-requisito;Recomendável NR-1/GRO básico')"
  sec 'Carga horária sugerida' '<p>Teoria EAD.</p>'
  sec 'Conteúdo Programático' "$(
    ul 'Finalidade e competências da CIPA;Dimensionamento e processo eleitoral;Atribuições dos membros;Identificação de perigos e avaliação de riscos (interface com PGR);Investigação e análise de acidentes;Plano de trabalho, reuniões e atas;SIPAT;Capacitação inicial e reciclagem;Registros e documentação'
  )"
  sec 'Avaliação e critérios' "$(ul 'Prova teórica EAD (≥70%);Participação em atividades da CIPA')" 
  sec 'Registros/Certificados' "$(ul 'Registro da avaliação;Lista de membros e capacitações')" 
  sec 'Observações legais' "<p>Seguir dimensionamento/eleição conforme normativa.</p>"
)"

# -------------------- NR-06 -------------------
mk "nr06.html" "NR-06 — Equipamentos de Proteção Individual (EPI)" "nr06.html" "$(
  sec 'Objetivo' "<p>Capacitar na seleção, uso, conservação e gestão de EPIs, integrando-os ao PGR/GRO.</p>"
  sec 'Público-alvo' "$(ul 'Trabalhadores expostos a risco;Supervisores;SST e compras')"
  sec 'Requisitos' "$(ul 'Sem pré-requisito;NR-1 recomendada')" 
  sec 'Carga horária sugerida' '<p>Teoria EAD.</p>'
  sec 'Conteúdo Programático' "$(
    ul 'Responsabilidades: empregador e empregado;Tipos de EPI por risco e critérios de seleção;CA — Certificado de Aprovação (consulta, validade, rastreabilidade);Ajuste, higienização, guarda e substituição;Integração EPI ↔ PGR/GRO;Registros de entrega/treinamentos e auditoria'
  )"
  sec 'Avaliação e critérios' "$(ul 'Prova teórica (≥70%);Registro de entrega de EPI')" 
  sec 'Registros/Certificados' "$(ul 'Ficha de EPI;Comprovante de avaliação')" 
  sec 'Observações legais' "<p>Uso de EPI não substitui medidas de eliminação/engenharia sempre que viáveis.</p>"
)"

# -------------------- NR-10 -------------------
mk "nr10.html" "NR-10 — Segurança em Instalações e Serviços em Eletricidade" "nr10.html" "$(
  sec 'Objetivo' "<p>Capacitar para reconhecer perigos elétricos, aplicar medidas de controle e cumprir requisitos documentais/operacionais.</p>"
  sec 'Público-alvo' "$(ul 'Eletricistas e equipes de manutenção;Engenharia e supervisão;SST')"
  sec 'Requisitos' "$(ul 'Alfabetização;Aptidão e exame ocupacional;Conteúdos práticos presenciais são obrigatórios')" 
  sec 'Carga horária sugerida' '<p>Teoria EAD + <strong>prática presencial obrigatória</strong>.</p>'
  sec 'Conteúdo Programático' "$(
    ul 'Perigos elétricos: choque, arco, queimaduras;Medidas de controle: seccionamento, aterramento, EPC/EPI e zonas;Trabalho desenergizado × energizado (requisitos e procedimentos);Bloqueio e Etiquetagem (LOTO);Prontuário e diagramas (conteúdo mínimo);Documentação e autorização de trabalho;Emergências e primeiros socorros'
  )"
  sec 'Avaliação e critérios' "$(ul 'Prova teórica (≥70%);Avaliação prática presencial')" 
  sec 'Registros/Certificados' "$(ul 'Registros de autorização/treinamento;Comprovante da avaliação teórica')" 
  sec 'Observações legais' "<p>Somente profissionais autorizados podem executar intervenções elétricas.</p>"
)"

# -------------------- NR-20 -------------------
mk "nr20.html" "NR-20 — Inflamáveis e Combustíveis" "nr20.html" "$(
  sec 'Objetivo' "<p>Abordar perigos, medidas de controle e resposta a emergências em instalações com inflamáveis/combustíveis.</p>"
  sec 'Público-alvo' "$(ul 'Trabalhadores de postos/indústria;Manutenção;Supervisores;SST')"
  sec 'Requisitos' "$(ul 'Atender pré-requisitos do nível do curso;Exame ocupacional;Prática quando exigida pelo nível')" 
  sec 'Carga horária sugerida' '<p>Teoria EAD + <strong>prática presencial conforme nível</strong>.</p>'
  sec 'Conteúdo Programático' "$(
    ul 'Propriedades e perigos (inflamáveis e combustíveis);Classificação de áreas e instalações;Análise de risco e medidas de controle (EPC/EPI);Procedimentos operacionais e PT (Permissão de Trabalho);Plano de Resposta a Emergências;Sinalização, inspeções e registros;Integração com PGR/GRO (NR-1);Reciclagens conforme nível'
  )"
  sec 'Avaliação e critérios' "$(ul 'Prova teórica (≥70%);Avaliação prática conforme nível')" 
  sec 'Registros/Certificados' "$(ul 'Registros de PT/inspeções;Comprovante da avaliação')" 
  sec 'Observações legais' "<p>Treinamentos e reciclagens devem seguir o nível definido para a instalação/atividade.</p>"
)"

# -------------------- NR-33 -------------------
mk "nr33.html" "NR-33 — Segurança e Saúde em Espaços Confinados" "nr33.html" "$(
  sec 'Objetivo' "<p>Ensinar reconhecimento, avaliação e controle de riscos em EC, PET e operações de resgate.</p>"
  sec 'Público-alvo' "$(ul 'Autorizados;Vigias;Supervisores;Equipes de resgate;SST')" 
  sec 'Requisitos' "$(ul 'Capacidade física/psicológica compatível;Exame ocupacional;Prática obrigatória')" 
  sec 'Carga horária sugerida' '<p>Teoria EAD + <strong>prática presencial obrigatória</strong>.</p>'
  sec 'Conteúdo Programático' "$(
    ul 'Definições e reconhecimento de Espaço Confinado;Riscos típicos e controle;Monitoramento de atmosfera e ventilação;PET — Permissão de Entrada e Trabalho (responsabilidades);Funções: autorizado, vigia e supervisor;Comunicação, bloqueio/etiquetagem e EPIs/EPCs;Plano de emergência e resgate;Registros e reciclagem'
  )"
  sec 'Avaliação e critérios' "$(ul 'Prova teórica (≥70%);Avaliação prática e simulado de resgate')" 
  sec 'Registros/Certificados' "$(ul 'Registros de PET/treinamentos;Comprovante da avaliação')" 
  sec 'Observações legais' "<p>Entrada em EC somente com PET válida e equipe capacitada.</p>"
)"

# -------------------- NR-35 -------------------
mk "nr35.html" "NR-35 — Trabalho em Altura" "nr35.html" "$(
  sec 'Objetivo' "<p>Orientar APR, SPQ, seleção de EPIs, planejamento e resgate em trabalhos acima de 2 m.</p>"
  sec 'Público-alvo' "$(ul 'Trabalhadores autorizados;Supervisores;SST;Contratadas')" 
  sec 'Requisitos' "$(ul 'Aptidão e exame ocupacional;Condições impeditivas;Prática obrigatória')" 
  sec 'Carga horária sugerida' '<p>Teoria EAD + <strong>prática presencial obrigatória</strong>.</p>'
  sec 'Conteúdo Programático' "$(
    ul 'Riscos de queda e APR/PGR;Sistema de Proteção contra Quedas (SPQ): ancoragem, linhas, conectores;EPIs (cinturão, talabarte, trava-quedas) — seleção, ajuste e inspeção;Planejamento do trabalho e procedimento operacional;Condições impeditivas;Plano de resgate e emergências;Responsabilidades legais e documentação'
  )"
  sec 'Avaliação e critérios' "$(ul 'Prova teórica (≥70%);Avaliação prática presencial')" 
  sec 'Registros/Certificados' "$(ul 'Registros de autorização/treinamento;Comprovante da avaliação')" 
  sec 'Observações legais' "<p>Trabalho em altura exige supervisão e plano de resgate disponível.</p>"
)"

# ---------- garante botão "Conteúdo Programático" nas páginas principais ----------
btn() {
  local FILE="$1" DEST="$2"
  [ -f "$FILE" ] || return 0
  grep -q "conteudos/$DEST" "$FILE" && { echo "• $FILE já linka para $DEST"; return 0; }
  BTN='<a class="inline-block bg-purple-600 hover:bg-purple-700 text-white px-5 py-3 rounded-xl mr-3" href="conteudos/'"$DEST"'">Conteúdo Programático</a>'
  if grep -q 'Fazer Avalia' "$FILE"; then
    sed -i "0,/\(Fazer Avalia\)/s//$(printf '%s' "$BTN" | sed 's/[\/&]/\\&/g')\n\1/" "$FILE"
    echo "✓ Botão inserido em $FILE"
  else
    sed -i "0,/<main[^>]*>/s//&\n$BTN\n/" "$FILE" || echo -e "\n$BTN" >> "$FILE"
    echo "✓ Botão adicionado pós-<main> em $FILE"
  fi
}

btn "nr1.html"  "nr1.html"
btn "nr05.html" "nr05.html"
btn "nr06.html" "nr06.html"
btn "nr10.html" "nr10.html"
btn "nr20.html" "nr20.html"
btn "nr33.html" "nr33.html"
btn "nr35.html" "nr35.html"

git add conteudos/*.html nr*.html
git commit -m "Conteúdo completo de estudo para NRs (1,5,6,10,20,33,35) + botão Conteúdo Programático"
git push
echo "✅ Conteúdos completos publicados. Recarregue o site (Ctrl+F5) e clique em 'Conteúdo Programático'."
