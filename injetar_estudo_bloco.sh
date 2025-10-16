#!/bin/bash
set -e
cd ~/nr-normas-regulamentadoras

# ------- função de injeção robusta (pós-heading, senão pós-<main>) -------
injeta() {
  local FILE="$1" MARK="$2" HTML="$3"
  [ -f "$FILE" ] || { echo "• $FILE não encontrado (ok)"; return; }
  if grep -q "$MARK" "$FILE"; then
    echo "• $FILE já contém $MARK (nada a fazer)."
    return
  fi

  # 1) tenta após “Conteúdos teóricos” ou “Conteúdo Programático”
  if grep -niE 'Conte(ú|u)dos te(ó|o)ricos|Conte(ú|u)do Program(á|a)tico' "$FILE" >/dev/null; then
    # insere depois da primeira ocorrência do heading <h2> ou <h3>
    awk -v block="$HTML" -v mark="$MARK" '
      BEGIN{done=0}
      {
        print $0
        if(!done && tolower($0) ~ /conte[úu]dos te[óo]ricos|conte[úu]do program[áa]tico/){
          print block
          done=1
        }
      }
      END{if(!done){}}
    ' "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
    echo "✓ Bloco ($MARK) inserido após heading em $FILE"
    return
  fi

  # 2) tenta após a tag <main>
  if grep -q '<main' "$FILE"; then
    sed -i "0,/<main[^>]*>/s//&\n$HTML\n/" "$FILE"
    echo "✓ Bloco ($MARK) inserido após <main> em $FILE"
    return
  fi

  # 3) fallback: anexa ao final
  echo -e "\n$HTML" >> "$FILE"
  echo "✓ Bloco ($MARK) anexado ao final de $FILE (fallback)"
}

wrap() {
  local MARK="$1"
  local BODY="$2"
  cat <<EOF
<!-- $MARK -->
<section class="mt-5 p-4 bg-yellow-50 border border-yellow-200 rounded-xl shadow-sm">
  <h3 class="text-lg font-semibold text-yellow-900 mb-2">📘 Estude antes da prova</h3>
  <div class="prose max-w-none text-gray-900">
$BODY
  </div>
</section>
EOF
}

# --------- conteúdos (resumo didático) ----------
nr1=$(wrap ESTUDO-NR1 '<ul>
<li>Finalidade das NRs e campo de aplicação.</li>
<li>Responsabilidades: empregador (gestão de riscos, capacitar, registrar) e empregado (seguir procedimentos, usar EPI).</li>
<li>GRO (ciclo PDCA) e integração com demais NRs.</li>
<li>PGR: Inventário de Riscos e Plano de Ação (estrutura mínima).</li>
<li>Avaliação de riscos e hierarquia de controles (eliminação → EPC → EPI).</li>
<li>Capacitação: conteúdo, avaliação, registros e EAD quando permitido.</li>
<li>Monitoramento e revisão do PGR (mudanças significativas).</li>
<li>Registros e evidências.</li>
</ul>')

nr05=$(wrap ESTUDO-NR05 '<ul>
<li>Objetivo da CIPA, dimensionamento e processo eleitoral.</li>
<li>Atribuições e papéis (presidente, vice, secretário).</li>
<li>Identificação de perigos e avaliação de riscos (interface com PGR).</li>
<li>Investigação de acidentes e quase acidentes.</li>
<li>Plano de trabalho, reuniões, atas e SIPAT.</li>
<li>Capacitação/reciclagem e documentação.</li>
</ul>')

nr06=$(wrap ESTUDO-NR06 '<ul>
<li>Responsabilidades de empregador e empregado.</li>
<li>Tipos de EPI e critérios de seleção conforme risco.</li>
<li>CA (Certificado de Aprovação): validade e rastreabilidade.</li>
<li>Ajuste, higienização, guarda e substituição.</li>
<li>Integração EPI ↔ PGR/GRO.</li>
<li>Registro de entrega e auditoria.</li>
</ul>')

nr10=$(wrap ESTUDO-NR10 '<ul>
<li>Perigos elétricos: choque, arco e queimaduras.</li>
<li>Medidas de controle: seccionamento, aterramento, EPC/EPI e zonas.</li>
<li>Trabalho desenergizado × energizado (requisitos).</li>
<li>Bloqueio e Etiquetagem (LOTO) e documentação.</li>
<li>Prontuário/diagramas (conteúdo mínimo).</li>
<li>Procedimentos e autorização de trabalho.</li>
<li>Emergências e primeiros socorros.</li>
</ul><p><strong>Obs.:</strong> prática presencial obrigatória.</p>')

nr20=$(wrap ESTUDO-NR20 '<ul>
<li>Perigos e propriedades de inflamáveis/combustíveis.</li>
<li>Classificação de áreas e instalações.</li>
<li>Análise de risco e medidas de controle (EPC/EPI).</li>
<li>Procedimentos e Permissão de Trabalho (PT).</li>
<li>Plano de Resposta a Emergências.</li>
<li>Sinalização, inspeções, registros e reciclagem.</li>
<li>Integração com PGR/GRO (NR-1).</li>
</ul>')

nr33=$(wrap ESTUDO-NR33 '<ul>
<li>Definições e reconhecimento de Espaço Confinado (EC).</li>
<li>PET — Permissão de Entrada e Trabalho: responsabilidades.</li>
<li>Monitoramento de atmosfera e ventilação.</li>
<li>Funções: autorizado, vigia e supervisor.</li>
<li>Bloqueio/etiquetagem, comunicação e EPIs/EPCs.</li>
<li>Plano de emergência e resgate; registros e reciclagem.</li>
</ul><p><strong>Obs.:</strong> prática presencial obrigatória.</p>')

nr35=$(wrap ESTUDO-NR35 '<ul>
<li>Conceitos, responsabilidades e autorização.</li>
<li>Análise de risco e condições impeditivas.</li>
<li>Sistemas de proteção contra quedas (SPQ) e ancoragem.</li>
<li>EPIs (cinturão, talabarte, trava-quedas) — inspeção e uso.</li>
<li>Procedimentos operacionais e plano de resgate.</li>
<li>Registros e reciclagem.</li>
</ul><p><strong>Obs.:</strong> prática presencial obrigatória.</p>')

# --------- aplica em cada página NR ---------
injeta nr1.html  ESTUDO-NR1  "$nr1"
injeta nr05.html ESTUDO-NR05 "$nr05"
injeta nr06.html ESTUDO-NR06 "$nr06"
injeta nr10.html ESTUDO-NR10 "$nr10"
injeta nr20.html ESTUDO-NR20 "$nr20"
injeta nr33.html ESTUDO-NR33 "$nr33"
injeta nr35.html ESTUDO-NR35 "$nr35"

git add nr*.html
git commit -m "Injeta quadro de estudo em NR-1, 05, 06, 10, 20, 33, 35 (após heading ou <main>)"
git push
echo "✅ Publicado. Abra as páginas e dê Ctrl+F5 para ver o bloco de estudo."
