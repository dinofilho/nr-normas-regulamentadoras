#!/bin/bash
set -e
cd ~/nr-normas-regulamentadoras

# ---- HTML dos estudos (por NR) ----
block_wrap () {
  local MARK="$1"; local BODY="$2"
  cat <<EOF
<!-- $MARK -->
<section class="mt-6 p-4 bg-white border rounded-xl shadow-sm">
  <h3 class="text-lg font-semibold text-blue-800 mb-2">📘 Estude antes da prova</h3>
  <div class="prose max-w-none">
$BODY
  </div>
</section>
EOF
}

nr1_body='<ul>
<li>Finalidade das NRs e campo de aplicação.</li>
<li>Responsabilidades: empregador (gestão de riscos, capacitar, registrar) e empregado (seguir procedimentos, usar EPI).</li>
<li>GRO e ciclo PDCA. Integração com demais NRs.</li>
<li>PGR: Inventário de Riscos e Plano de Ação (conteúdo mínimo).</li>
<li>Avaliação de riscos e hierarquia de controles (eliminação → EPC → EPI).</li>
<li>Capacitação: conteúdo, avaliação, registros e EAD quando permitido.</li>
<li>Monitoramento e revisão do PGR (mudanças significativas).</li>
<li>Registros e evidências: como manter e por quanto tempo.</li>
</ul>'

nr05_body='<ul>
<li>Objetivo da CIPA, dimensionamento e processo eleitoral.</li>
<li>Atribuições da comissão e papéis (presidente, vice, secretário).</li>
<li>Identificação de perigos e avaliação de riscos (interface com PGR).</li>
<li>Investigação de acidentes e quase acidentes.</li>
<li>Plano de trabalho, reuniões, atas e SIPAT.</li>
<li>Capacitação e reciclagem dos membros.</li>
<li>Documentação e interface com SESMT e empregador.</li>
</ul>'

nr06_body='<ul>
<li>Responsabilidades de empregador e empregado.</li>
<li>Tipos de EPI e critérios de seleção.</li>
<li>CA (Certificado de Aprovação): validade e rastreabilidade.</li>
<li>Ajuste, higienização, guarda e substituição.</li>
<li>Integração EPI ↔ PGR/GRO (quando usar EPI).</li>
<li>Registro de entrega e auditoria.</li>
</ul>'

nr10_body='<ul>
<li>Perigos elétricos: choque, arco e queimaduras.</li>
<li>Medidas de controle: seccionamento, aterramento, EPC/EPI e zonas.</li>
<li>Trabalho desenergizado x energizado (requisitos).</li>
<li>Bloqueio e etiquetagem (LOTO) e documentação.</li>
<li>Prontuário/diagramas: conteúdo mínimo.</li>
<li>Procedimentos e autorização de trabalho.</li>
<li>Emergências e primeiros socorros.</li>
</ul><p><strong>Observação:</strong> prática presencial obrigatória.</p>'

nr20_body='<ul>
<li>Perigos e propriedades de inflamáveis/combustíveis.</li>
<li>Classificação de áreas e instalações.</li>
<li>Análise de risco e medidas de controle (EPC/EPI).</li>
<li>Procedimentos e Permissão de Trabalho (PT).</li>
<li>Plano de Resposta a Emergências.</li>
<li>Sinalização, inspeções, registros e reciclagem.</li>
<li>Integração com PGR/GRO (NR-1).</li>
</ul>'

nr33_body='<ul>
<li>Definições e reconhecimento de Espaço Confinado (EC).</li>
<li>PET — Permissão de Entrada e Trabalho: responsabilidades.</li>
<li>Monitoramento de atmosfera e ventilação.</li>
<li>Funções: autorizado, vigia e supervisor.</li>
<li>Bloqueio/etiquetagem, comunicação e EPIs/EPCs.</li>
<li>Planos de emergência e resgate; registros e reciclagem.</li>
</ul><p><strong>Observação:</strong> prática presencial obrigatória.</p>'

nr35_body='<ul>
<li>Conceitos, responsabilidades e autorização.</li>
<li>Análise de risco e condições impeditivas.</li>
<li>SPQ e ancoragem.</li>
<li>EPIs (cinturão, talabarte, trava-quedas) — inspeção e uso.</li>
<li>Procedimentos operacionais e plano de resgate.</li>
<li>Registros e reciclagem.</li>
</ul><p><strong>Observação:</strong> prática presencial obrigatória.</p>'

# ---- Função que injeta antes do botão "Fazer Avaliação" ----
inject_before_button () {
  local FILE="$1"; local MARK="$2"; local BLOCK_HTML="$3"
  [ -f "$FILE" ] || { echo "• $FILE não encontrado (ok)"; return; }

  if grep -q "$MARK" "$FILE"; then
    echo "• $FILE já possui o bloco ($MARK)."
    return
  fi

  # tenta inserir imediatamente antes de um link de 'Fazer Avaliação'
  if grep -q 'Fazer Avalia' "$FILE"; then
    sed -i "0,/\(Fazer Avalia\)/s//$(printf '%s\n' "$BLOCK_HTML" | sed -e 's/[\/&]/\\&/g')\n\1/" "$FILE"
    echo "✓ Bloco de estudo inserido antes do botão em $FILE"
  elif grep -q '</main>' "$FILE"; then
    sed -i "0,/<\/main>/{s~<\/main>~$BLOCK_HTML\n<\/main>~}" "$FILE"
    echo "✓ Bloco de estudo inserido antes de </main> em $FILE"
  else
    echo -e "\n$BLOCK_HTML" >> "$FILE"
    echo "✓ Bloco de estudo anexado ao final de $FILE (fallback)"
  fi
}

inject_before_button "nr1.html"  "ESTUDO-FIX-NR1"  "$(block_wrap ESTUDO-FIX-NR1  "$nr1_body")"
inject_before_button "nr05.html" "ESTUDO-FIX-NR05" "$(block_wrap ESTUDO-FIX-NR05 "$nr05_body")"
inject_before_button "nr06.html" "ESTUDO-FIX-NR06" "$(block_wrap ESTUDO-FIX-NR06 "$nr06_body")"
inject_before_button "nr10.html" "ESTUDO-FIX-NR10" "$(block_wrap ESTUDO-FIX-NR10 "$nr10_body")"
inject_before_button "nr20.html" "ESTUDO-FIX-NR20" "$(block_wrap ESTUDO-FIX-NR20 "$nr20_body")"
inject_before_button "nr33.html" "ESTUDO-FIX-NR33" "$(block_wrap ESTUDO-FIX-NR33 "$nr33_body")"
inject_before_button "nr35.html" "ESTUDO-FIX-NR35" "$(block_wrap ESTUDO-FIX-NR35 "$nr35_body")"

git add nr*.html
git commit -m "Força bloco fixo 'Estude antes da prova' antes do botão Fazer Avaliação (NR-1,05,06,10,20,33,35)"
git push
echo "✅ Publicado. Faça um hard refresh (Ctrl+F5) nas páginas das NRs."
