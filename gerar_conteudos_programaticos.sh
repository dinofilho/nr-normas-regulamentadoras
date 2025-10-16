#!/bin/bash
set -e
cd ~/nr-normas-regulamentadoras

mkdir -p conteudos

mk() { # mk <arquivo> <titulo> <subtitulo> <html_conteudo>
  cat > "conteudos/$1.html" <<EOF
<!DOCTYPE html><html lang="pt-BR"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>$2 — Conteúdo Programático</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head><body class="bg-gray-50 text-gray-900">
<header class="bg-blue-900 text-white p-4 shadow"><div class="max-w-6xl mx-auto flex justify-between items-center">
  <a href="../index.html" class="font-bold">NR NORMAS REGULAMENTADORAS</a>
  <nav class="space-x-4 text-sm">
    <a href="../nr1.html"  class="hover:text-yellow-400">NR-1</a>
    <a href="../nr20.html" class="hover:text-yellow-400">NR-20</a>
    <a href="../nr35.html" class="hover:text-yellow-400">NR-35</a>
    <a href="../nr33.html" class="hover:text-yellow-400">NR-33</a>
    <a href="../nr10.html" class="hover:text-yellow-400">NR-10</a>
    <a href="../nr05.html" class="hover:text-yellow-400">NR-05</a>
    <a href="../nr06.html" class="hover:text-yellow-400">NR-06</a>
  </nav>
</div></header>

<main class="max-w-4xl mx-auto p-6">
  <h1 class="text-2xl font-bold mb-2">$2 — Conteúdo Programático</h1>
  <p class="text-sm text-gray-600 mb-6">$3</p>

  $4

  <div class="mt-8 flex gap-3">
    <a href="../quiz.html?curso=$1" class="inline-block bg-blue-700 text-white px-5 py-3 rounded-xl">Fazer Avaliação</a>
    <a href="../$1.html" class="inline-block bg-gray-200 text-gray-800 px-5 py-3 rounded-xl">Voltar à página da NR</a>
  </div>
</main>

<footer class="bg-blue-900 text-white mt-10 p-4 text-center">
  <p>© 2025 GLOBALLED SST – Plataforma EAD</p>
</footer>
</body></html>
EOF
  echo "✓ criado conteudos/$1.html"
}

# ---------------- NR-1 ----------------
mk nr1 "NR-1 – Disposições Gerais e GRO/PGR" \
"Base legal: disposições gerais, responsabilidades, capacitação (inclui EAD quando aplicável), e Gerenciamento de Riscos Ocupacionais (GRO) com PGR." \
'
<section class="space-y-4">
  <h2 class="text-xl font-semibold">Objetivo</h2>
  <p>Apresentar fundamentos da NR-1, responsabilidades, estrutura do GRO e do PGR, e diretrizes para capacitação.</p>

  <h2 class="text-xl font-semibold">Público-alvo</h2>
  <p>Trabalhadores, gestores, CIPA, SESMT e responsáveis por SST.</p>

  <h2 class="text-xl font-semibold">Modalidade e Carga Horária</h2>
  <ul class="list-disc pl-6">
    <li>Teoria EAD: 4–8h (conforme perfil e risco).</li>
    <li>Prática: quando exigida por NRs específicas relacionadas.</li>
  </ul>

  <h2 class="text-xl font-semibold">Conteúdo Programático</h2>
  <ol class="list-decimal pl-6 space-y-1">
    <li>Introdução à legislação de SST e às NRs.</li>
    <li>Responsabilidades do empregador e do empregado.</li>
    <li>GRO: princípios, ciclo e integração com sistemas de gestão.</li>
    <li>PGR: Inventário de Riscos e Plano de Ação.</li>
    <li>Critérios de avaliação de riscos e hierarquia de controles.</li>
    <li>Capacitação: conteúdos, avaliação, registros e EAD.</li>
    <li>Comunicação e participação dos trabalhadores.</li>
    <li>Monitoramento, revisão e melhoria contínua do PGR.</li>
    <li>Integração com demais NRs (10, 20, 33, 35, etc.).</li>
    <li>Registros, evidências e auditorias internas.</li>
  </ol>

  <h2 class="text-xl font-semibold">Referências</h2>
  <p>NR-1 (GRO/PGR) vigente; portarias MTP/MTE correlatas.</p>
</section>
'

# ---------------- NR-5 ----------------
mk nr05 "NR-05 – CIPA" \
"Constituição, atribuições, funcionamento e capacitação dos membros da CIPA." \
'
<section class="space-y-4">
  <h2 class="text-xl font-semibold">Objetivo</h2>
  <p>Capacitar membros e apoiadores da CIPA para prevenção de acidentes e doenças.</p>

  <h2 class="text-xl font-semibold">Carga Horária</h2>
  <ul class="list-disc pl-6"><li>Teoria EAD: 8–20h (conforme porte e risco).</li></ul>

  <h2 class="text-xl font-semibold">Conteúdo Programático</h2>
  <ol class="list-decimal pl-6 space-y-1">
    <li>Finalidades e atribuições da CIPA.</li>
    <li>Processo eleitoral, posse, mandato e reuniões.</li>
    <li>Identificação de perigos e avaliação de riscos.</li>
    <li>PGR: inventário, plano de ação e indicadores.</li>
    <li>Comunicação de riscos, SIPAT e campanhas.</li>
    <li>Investigação e análise de acidentes/incidentes.</li>
    <li>Noções de primeiros socorros e prevenção a incêndios.</li>
    <li>Registros, atas, documentação e interface com SST.</li>
  </ol>
</section>
'

# ---------------- NR-6 ----------------
mk nr06 "NR-06 – Equipamentos de Proteção Individual (EPI)" \
"Seleção, uso, conservação, responsabilidades e rastreabilidade de EPI." \
'
<section class="space-y-4">
  <h2 class="text-xl font-semibold">Objetivo</h2>
  <p>Orientar sobre gestão de EPI, do CA à entrega e controle de uso.</p>

  <h2 class="text-xl font-semibold">Carga Horária</h2>
  <ul class="list-disc pl-6"><li>Teoria EAD: 4–8h.</li></ul>

  <h2 class="text-xl font-semibold">Conteúdo Programático</h2>
  <ol class="list-decimal pl-6 space-y-1">
    <li>Responsabilidades do empregador e empregado.</li>
    <li>Tipos de EPI e critérios de seleção.</li>
    <li>Certificado de Aprovação (CA) e validade.</li>
    <li>Ajuste, higienização, guarda e substituição.</li>
    <li>Integração EPI ↔ PGR/GRO.</li>
    <li>Registros de entrega e rastreabilidade.</li>
  </ol>
</section>
'

# ---------------- NR-10 ----------------
mk nr10 "NR-10 – Segurança em Instalações e Serviços em Eletricidade" \
"Riscos elétricos, medidas de controle, prontuário, procedimentos e emergências." \
'
<section class="space-y-4">
  <h2 class="text-xl font-semibold">Objetivo</h2>
  <p>Capacitar para trabalhos seguros em eletricidade (teoria EAD + prática presencial).</p>

  <h2 class="text-xl font-semibold">Carga Horária</h2>
  <ul class="list-disc pl-6">
    <li>Teoria EAD: 8–20h (módulo conforme perfil).</li>
    <li>Prática presencial obrigatória.</li>
  </ul>

  <h2 class="text-xl font-semibold">Conteúdo Programático</h2>
  <ol class="list-decimal pl-6 space-y-1">
    <li>Perigos elétricos: choque e arco.</li>
    <li>Medidas de controle: EPC/EPI, aterramento e zonas.</li>
    <li>Bloqueio, etiquetagem e sinalização.</li>
    <li>Trabalhos energizados e desenergizados (conceitos e requisitos).</li>
    <li>Prontuários/diagramas e documentação.</li>
    <li>Procedimentos operacionais e autorização.</li>
    <li>Emergências, combate a princípios de incêndio e primeiros socorros.</li>
  </ol>
</section>
'

# ---------------- NR-20 ----------------
mk nr20 "NR-20 – Inflamáveis e Combustíveis" \
"Gestão de segurança com inflamáveis/combustíveis, classificação, PT e resposta a emergências." \
'
<section class="space-y-4">
  <h2 class="text-xl font-semibold">Objetivo</h2>
  <p>Capacitar conforme nível (básico/intermediário/avançado) e atividade, abordando gestão e controles.</p>

  <h2 class="text-xl font-semibold">Carga Horária</h2>
  <ul class="list-disc pl-6"><li>Teoria EAD: 4–12h (conforme nível e risco).</li></ul>

  <h2 class="text-xl font-semibold">Conteúdo Programático</h2>
  <ol class="list-decimal pl-6 space-y-1">
    <li>Perigos de inflamáveis e combustíveis.</li>
    <li>Classificação de áreas e instalações.</li>
    <li>Análise de risco e medidas de controle (EPC/EPI).</li>
    <li>Procedimentos operacionais e Permissão de Trabalho (PT).</li>
    <li>Prevenção e resposta a emergências.</li>
    <li>Sinalização, documentação e registros.</li>
    <li>Integração com PGR/GRO (NR-1).</li>
  </ol>
</section>
'

# ---------------- NR-33 ----------------
mk nr33 "NR-33 – Segurança e Saúde em Espaços Confinados" \
"Planejamento, PET, monitoramento de atmosfera, ventilação e resgate. (Prática presencial obrigatória.)" \
'
<section class="space-y-4">
  <h2 class="text-xl font-semibold">Objetivo</h2>
  <p>Capacitar equipe (trabalhador autorizado, vigia e supervisor) para atividades em EC com segurança.</p>

  <h2 class="text-xl font-semibold">Carga Horária</h2>
  <ul class="list-disc pl-6">
    <li>Teoria EAD: 6–12h (conforme função).</li>
    <li>Prática presencial obrigatória (procedimentos e resgate).</li>
  </ul>

  <h2 class="text-xl font-semibold">Conteúdo Programático</h2>
  <ol class="list-decimal pl-6 space-y-1">
    <li>Definições e reconhecimento de EC.</li>
    <li>PET: elaboração, controle e responsabilidades.</li>
    <li>Monitoramento de gases e ventilação.</li>
    <li>EPIs/EPCs, bloqueio/etiquetagem e comunicação.</li>
    <li>Planos de emergência e resgate.</li>
    <li>Registros e reciclagem.</li>
  </ol>
</section>
'

# ---------------- NR-35 ----------------
mk nr35 "NR-35 – Trabalho em Altura" \
"Planejamento, análise de risco, sistemas de proteção, ancoragem e resgate. (Prática presencial obrigatória.)" \
'
<section class="space-y-4">
  <h2 class="text-xl font-semibold">Objetivo</h2>
  <p>Capacitar trabalhadores e supervisores para executar atividades em altura com segurança.</p>

  <h2 class="text-xl font-semibold">Carga Horária</h2>
  <ul class="list-disc pl-6">
    <li>Teoria EAD: 6–12h (conforme perfil).</li>
    <li>Prática presencial obrigatória (técnicas e simulado de resgate).</li>
  </ul>

  <h2 class="text-xl font-semibold">Conteúdo Programático</h2>
  <ol class="list-decimal pl-6 space-y-1">
    <li>Conceitos, requisitos e responsabilidades (empregador/empregado).</li>
    <li>Análise de risco e condições impeditivas.</li>
    <li>Sistemas de proteção contra quedas (SPQ) e ancoragem.</li>
    <li>EPIs (cinturão, talabarte, trava-quedas) e inspeção.</li>
    <li>Procedimentos operacionais e autorização.</li>
    <li>Plano de resgate e emergência.</li>
    <li>Registros e reciclagem.</li>
  </ol>
</section>
'

# --------- INSERE BOTÃO "CONTEÚDO PROGRAMÁTICO" NAS PÁGINAS NR (se faltar) ---------
add_btn() {
  local FILE="$1" CUR="$2"
  [ -f "$FILE" ] || { echo "• $FILE não encontrado (ok)"; return; }
  if ! grep -q "conteudos/$CUR.html" "$FILE"; then
    if grep -q '<div class="mt-8">' "$FILE"; then
      sed -i "0,/<div class=\"mt-8\">/s//<div class=\"mt-8\"><a href=\"conteudos\/$CUR.html\" class=\"inline-block bg-purple-700 text-white px-5 py-3 rounded-xl mr-3\">Conteúdo Programático<\/a>/" "$FILE"
      echo "✓ Botão 'Conteúdo Programático' inserido em $FILE"
    elif grep -q '</main>' "$FILE"; then
      sed -i "0,/<\/main>/s//<div class=\"mt-8\"><a href=\"conteudos\/$CUR.html\" class=\"inline-block bg-purple-700 text-white px-5 py-3 rounded-xl mr-3\">Conteúdo Programático<\/a><\/div>\n<\/main>/" "$FILE"
      echo "✓ Botão 'Conteúdo Programático' inserido em $FILE (fallback)"
    else
      echo -e '\n<div class="mt-8"><a href="conteudos/'"$CUR"'.html" class="inline-block bg-purple-700 text-white px-5 py-3 rounded-xl mr-3">Conteúdo Programático</a></div>' >> "$FILE"
      echo "✓ Botão 'Conteúdo Programático' anexado ao final de $FILE"
    fi
  else
    echo "• $FILE já tinha link para conteudos/$CUR.html"
  fi
}

add_btn nr1.html  nr1
add_btn nr05.html nr05
add_btn nr06.html nr06
add_btn nr10.html nr10
add_btn nr20.html nr20
add_btn nr33.html nr33
add_btn nr35.html nr35

git add conteudos/*.html nr1.html nr05.html nr06.html nr10.html nr20.html nr33.html nr35.html
git commit -m "Conteúdo programático: NR-1, NR-05, NR-06, NR-10, NR-20, NR-33, NR-35 + botões nas páginas"
git push
echo "✅ Conteúdos programáticos publicados. Acesse: https://SEUUSUARIO.github.io/nr-normas-regulamentadoras/conteudos/nr20.html (ajuste SEUUSUARIO)."
