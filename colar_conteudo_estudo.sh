#!/bin/bash
set -e
cd ~/nr-normas-regulamentadoras

# Função que injeta o bloco de estudo no arquivo indicado (sem duplicar)
add_estudo () {
  local FILE="$1"
  local MARK="$2"
  local HTML="$3"

  [ -f "$FILE" ] || { echo "• $FILE não encontrado (ok)"; return; }

  # evita duplicar
  if grep -q "$MARK" "$FILE"; then
    echo "• $FILE já possui bloco de estudo ($MARK)."
    return
  fi

  # tenta inserir antes do fechamento de </main>, senão anexa no final
  if grep -q '</main>' "$FILE"; then
    sed -i "0,/<\/main>/{s~<\/main>~$HTML\n<\/main>~}" "$FILE"
    echo "✓ Estudo adicionado em $FILE"
  else
    echo -e "\n$HTML" >> "$FILE"
    echo "✓ Estudo anexado ao final de $FILE (fallback)"
  fi
}

# --------- HTML base (colapsável) ----------
wrap() {
cat <<EOF
<!-- $1 -->
<section class="mt-8" id="$1">
  <details class="bg-white border rounded-xl shadow-sm">
    <summary class="cursor-pointer select-none px-5 py-3 text-blue-800 font-semibold">
      📘 Estude antes da prova (clique para abrir)
    </summary>
    <div class="px-6 py-5 prose max-w-none">
$2
    </div>
  </details>
</section>
EOF
}

# --------- Conteúdos por NR (resumo didático) ----------
nr1_content=$(cat <<'HTML'
<h2>NR-1 — Disposições Gerais e GRO/PGR</h2>
<ul>
<li>Finalidade das NRs e campo de aplicação.</li>
<li>Responsabilidades: empregador (gestão de riscos, capacitar, registrar) e empregado (seguir procedimentos, usar EPI).</li>
<li>GRO: princípios, ciclo PDCA e integração com demais NRs.</li>
<li>PGR: Inventário de Riscos e Plano de Ação (estrutura mínima).</li>
<li>Avaliação de riscos e hierarquia de controles (eliminação → EPC → EPI).</li>
<li>Capacitação: conteúdo, carga, avaliação, registros e possibilidade de EAD quando permitido.</li>
<li>Monitoramento, revisão do PGR e atualização por mudanças significativas.</li>
<li>Registros e evidências: como manter e por quanto tempo.</li>
</ul>
HTML
)

nr05_content=$(cat <<'HTML'
<h2>NR-05 — CIPA</h2>
<ul>
<li>Objetivo da CIPA e base legal.</li>
<li>Dimensionamento, processo eleitoral, posse e mandato.</li>
<li>Atribuições da CIPA e do presidente/vice/secretário.</li>
<li>Identificação de perigos e avaliação de riscos (interface com PGR).</li>
<li>Investigação e análise de acidentes e quase acidentes.</li>
<li>Plano de trabalho, reuniões, atas e SIPAT.</li>
<li>Capacitação dos membros (conteúdo mínimo) e reciclagem.</li>
<li>Documentação e relacionamento com o SESMT e empregador.</li>
</ul>
HTML
)

nr06_content=$(cat <<'HTML'
<h2>NR-06 — Equipamento de Proteção Individual (EPI)</h2>
<ul>
<li>Responsabilidades do empregador e do empregado.</li>
<li>Tipos de EPI e critérios de seleção conforme risco.</li>
<li>CA (Certificado de Aprovação): validade e rastreabilidade.</li>
<li>Ajuste, higienização, guarda, conservação e substituição.</li>
<li>Integração EPI ↔ PGR/GRO (quando usar EPI).</li>
<li>Registro de entrega (controle individual) e auditoria.</li>
</ul>
HTML
)

nr10_content=$(cat <<'HTML'
<h2>NR-10 — Segurança em Instalações e Serviços em Eletricidade</h2>
<ul>
<li>Perigos elétricos: choque, arco elétrico e queimaduras.</li>
<li>Medidas de controle: seccionamento, aterramento, EPC/EPI e zonas.</li>
<li>Trabalho desenergizado x energizado (requisitos).</li>
<li>Bloqueio e Etiquetagem (LOTO) e documentação.</li>
<li>Prontuário e esquemas: conteúdo mínimo.</li>
<li>Procedimentos operacionais e autorização de trabalho.</li>
<li>Emergências e primeiros socorros (especial atenção a choques).</li>
</ul>
<p><strong>Observação:</strong> prática presencial obrigatória.</p>
HTML
)

nr20_content=$(cat <<'HTML'
<h2>NR-20 — Inflamáveis e Combustíveis</h2>
<ul>
<li>Perigos, propriedades e classificação de áreas/instalações.</li>
<li>Gestão de riscos: análise, medidas de controle (EPC/EPI).</li>
<li>Procedimentos operacionais e Permissão de Trabalho (PT).</li>
<li>Plano de Resposta a Emergências e recursos necessários.</li>
<li>Sinalização, inspeções, registros e reciclagem.</li>
<li>Integração com PGR/GRO (NR-1).</li>
</ul>
HTML
)

nr33_content=$(cat <<'HTML'
<h2>NR-33 — Espaços Confinados</h2>
<ul>
<li>Definições e reconhecimento de Espaço Confinado (EC).</li>
<li>PET — Permissão de Entrada e Trabalho: responsabilidades.</li>
<li>Monitoramento de atmosfera, ventilação e controle de energia.</li>
<li>Funções: trabalhador autorizado, vigia e supervisor.</li>
<li>Comunicação, EPIs/EPCs e resgate.</li>
<li>Registros e reciclagem periódica.</li>
</ul>
<p><strong>Observação:</strong> prática presencial obrigatória (entrada, resgate).</p>
HTML
)

nr35_content=$(cat <<'HTML'
<h2>NR-35 — Trabalho em Altura</h2>
<ul>
<li>Conceitos, responsabilidades e autorização.</li>
<li>Análise de risco e condições impeditivas.</li>
<li>SPQ (sistemas de proteção contra quedas) e ancoragem.</li>
<li>EPIs: cinturão, talabarte, trava-quedas — inspeção e uso.</li>
<li>Procedimentos operacionais e plano de resgate.</li>
<li>Registros e reciclagem.</li>
</ul>
<p><strong>Observação:</strong> prática presencial obrigatória.</p>
HTML
)

# --------- Monta os blocos com marcador único e injeta ----------
add_estudo "nr1.html"  "ESTUDO-NR1"  "$(wrap ESTUDO-NR1  "$nr1_content")"
add_estudo "nr05.html" "ESTUDO-NR05" "$(wrap ESTUDO-NR05 "$nr05_content")"
add_estudo "nr06.html" "ESTUDO-NR06" "$(wrap ESTUDO-NR06 "$nr06_content")"
add_estudo "nr10.html" "ESTUDO-NR10" "$(wrap ESTUDO-NR10 "$nr10_content")"
add_estudo "nr20.html" "ESTUDO-NR20" "$(wrap ESTUDO-NR20 "$nr20_content")"
add_estudo "nr33.html" "ESTUDO-NR33" "$(wrap ESTUDO-NR33 "$nr33_content")"
add_estudo "nr35.html" "ESTUDO-NR35" "$(wrap ESTUDO-NR35 "$nr35_content")"

# commit e push
git add nr*.html
git commit -m "Adiciona bloco 'Estude antes da prova' em NR-1, 05, 06, 10, 20, 33 e 35"
git push
echo "✅ Blocos de estudo colados. Recarregue as páginas (Ctrl+F5)."
