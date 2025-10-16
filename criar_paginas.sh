#!/bin/bash
set -e
mk() { # mk <arquivo> <titulo> <subtitulo> <conteudo_html>
  cat > "$1" <<EOF
<!DOCTYPE html><html lang="pt-BR"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>$2</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head><body class="bg-gray-50 text-gray-900">
<header class="bg-blue-900 text-white p-4 shadow-lg">
  <div class="max-w-6xl mx-auto flex justify-between items-center">
    <a href="index.html" class="text-xl font-bold">NR NORMAS REGULAMENTADORAS</a>
    <nav class="space-x-4">
      <a href="nr1.html"  class="hover:text-yellow-400">NR-1</a>
      <a href="nr20.html" class="hover:text-yellow-400">NR-20</a>
      <a href="nr35.html" class="hover:text-yellow-400">NR-35</a>
      <a href="nr33.html" class="hover:text-yellow-400">NR-33</a>
      <a href="nr10.html" class="hover:text-yellow-400">NR-10</a>
      <a href="nr05.html" class="hover:text-yellow-400">NR-05</a>
      <a href="nr06.html" class="hover:text-yellow-400">NR-06</a>
    </nav>
  </div>
</header>

<main class="max-w-4xl mx-auto p-6">
  <h1 class="text-2xl font-bold mb-2">$2</h1>
  <p class="text-sm text-gray-600 mb-6">$3</p>
  $4
  <div class="mt-8">
    <a href="https://wa.me/551433224141" class="inline-block bg-green-600 text-white px-5 py-3 rounded-xl">Suporte WhatsApp (14 3322-4141)</a>
  </div>
</main>

<footer class="bg-blue-900 text-white mt-10 p-4 text-center">
  <p>© 2025 GLOBALLED SST – Plataforma EAD</p>
</footer>
</body></html>
EOF
}

# ---------- NR-33 ----------
mk nr33.html \
"NR-33 – Espaço Confinado" \
"Teoria EAD conforme Anexo II da NR-1. Prática PRESENCIAL obrigatória (entrada, vigia, supervisor), com instrutor qualificado e registros." \
'<h2 class="text-xl font-semibold">Conteúdos teóricos</h2>
<ol class="list-decimal pl-6 space-y-1">
  <li>Perigos em espaços confinados e classificação.</li>
  <li>Permissão de Entrada e Trabalho (PET).</li>
  <li>Monitoramento de gases, ventilação e resgate.</li>
  <li>Controles operacionais, comunicação e EPIs.</li>
  <li>Responsabilidades: empregador, trabalhador, contratadas.</li>
</ol>
<h3 class="text-lg font-semibold mt-4">Prática (presencial)</h3>
<ul class="list-disc pl-6">
  <li>Montagem de PET, bloqueio/etiquetagem.</li>
  <li>Teste de equipamentos e simulado de resgate.</li>
</ul>
<p class="mt-4 italic text-gray-700">Avaliação teórica on-line (≥70%) e registro de prática em ata com fotos.</p>'

# ---------- NR-35 ----------
mk nr35.html \
"NR-35 – Trabalho em Altura" \
"Teoria EAD permitida; PRÁTICA PRESENCIAL obrigatória. Cumprir requisitos de saúde, aptidão e procedimentos de emergência." \
'<h2 class="text-xl font-semibold">Conteúdos teóricos</h2>
<ol class="list-decimal pl-6 space-y-1">
  <li>Riscos de quedas e análise preliminar (APR/PGR).</li>
  <li>EPIs (cinturão, talabarte, trava-quedas) e ancoragem.</li>
  <li>Planejamento do trabalho e sistema de proteção contra quedas.</li>
  <li>Condições impeditivas e emergência/resgate (conceitos).</li>
  <li>Responsabilidades legais e documentação.</li>
</ol>
<h3 class="text-lg font-semibold mt-4">Prática (presencial)</h3>
<ul class="list-disc pl-6">
  <li>Inspeção de EPI, montagem de linhas de vida.</li>
  <li>Deslocamento seguro e simulado de resgate.</li>
</ul>
<p class="mt-4 italic text-gray-700">Avaliação teórica on-line (≥70%) + registro de prática com instrutor.</p>'

# ---------- NR-10 ----------
mk nr10.html \
"NR-10 – Segurança em Instalações e Serviços em Eletricidade" \
"Parte teórica pode ser EAD. Prática obrigatória em laboratório/instalação adequada, com procedimentos de segurança." \
'<h2 class="text-xl font-semibold">Conteúdos teóricos</h2>
<ol class="list-decimal pl-6 space-y-1">
  <li>Riscos elétricos, choques e arco elétrico.</li>
  <li>Medidas de controle: EPC/EPI e aterramento.</li>
  <li>Bloqueio e sinalização, documentos e prontuários.</li>
  <li>Trabalhos Desenergizados e Energizados (conceitos).</li>
  <li>Emergência, combate a princípio de incêndio e primeiros socorros.</li>
</ol>
<p class="mt-4 italic text-gray-700">Teoria EAD + prática presencial conforme NR-10. Certificado separando carga teórica e prática.</p>'

# ---------- NR-05 ----------
mk nr05.html \
"NR-05 – CIPA" \
"Teoria EAD permitida. Atividades práticas e dinâmicas podem ocorrer presencialmente, conforme planejamento." \
'<h2 class="text-xl font-semibold">Conteúdos teóricos</h2>
<ol class="list-decimal pl-6 space-y-1">
  <li>Objetivos e atribuições da CIPA.</li>
  <li>Funcionamento: eleições, reuniões e atas.</li>
  <li>Identificação de perigos e avaliação de riscos.</li>
  <li>Investigação de incidentes e plano de ação.</li>
  <li>Integração com PGR/GRO e campanhas de prevenção.</li>
</ol>
<p class="mt-4 italic text-gray-700">Avaliação on-line e emissão de certificado com responsável técnico.</p>'

# ---------- NR-06 ----------
mk nr06.html \
"NR-06 – Equipamentos de Proteção Individual (EPI)" \
"Conteúdo teórico EAD (seleção, uso, conservação). Demonstrações e ajustes de EPI podem ser presenciais quando necessário." \
'<h2 class="text-xl font-semibold">Conteúdos teóricos</h2>
<ol class="list-decimal pl-6 space-y-1">
  <li>Responsabilidades do empregador e empregado.</li>
  <li>Tipos de EPI e critérios de seleção.</li>
  <li>CA, validade, higienização e guarda.</li>
  <li>Integração com PGR/GRO e treinamentos complementares.</li>
  <li>Registros e rastreabilidade.</li>
</ol>
<p class="mt-4 italic text-gray-700">Prova on-line (quando aplicável) e registro de entrega/treinamento.</p>'

echo "✅ Páginas NR-33, NR-35, NR-10, NR-05 e NR-06 geradas."
