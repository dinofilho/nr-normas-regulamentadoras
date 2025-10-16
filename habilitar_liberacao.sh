#!/bin/bash
set -e
cd ~/nr-normas-regulamentadoras

# 1) Lista de liberados (se não existir, cria vazia)
mkdir -p assets/js assets/questions
if [ ! -f assets/approved.json ]; then
  echo '{"items":[]}' > assets/approved.json
fi

# 2) JS utilitário: calcula SHA-256 (hex)
cat > assets/js/hashlib.js <<'EOF'
async function sha256Hex(text){
  const enc = new TextEncoder().encode(text);
  const buf = await crypto.subtle.digest("SHA-256", enc);
  return Array.from(new Uint8Array(buf)).map(b=>b.toString(16).padStart(2,"0")).join("");
}
window.sha256Hex = sha256Hex;
EOF

# 3) Reescreve quiz.html com verificação de liberação ANTES de exibir questões
cat > quiz.html <<'EOF'
<!DOCTYPE html><html lang="pt-BR"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quiz – Avaliação Teórica</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head><body class="bg-gray-50 text-gray-900">
<header class="bg-blue-900 text-white p-4">
  <div class="max-w-4xl mx-auto flex justify-between">
    <a href="index.html" class="font-bold">NR NORMAS REGULAMENTADORAS</a>
    <span id="cursoTag"></span>
  </div>
</header>

<main class="max-w-4xl mx-auto p-6">
  <h1 class="text-2xl font-bold mb-4">Avaliação Teórica</h1>

  <!-- Identificação -->
  <div class="grid md:grid-cols-3 gap-4 mb-4">
    <input id="aluno" class="border p-2 rounded" placeholder="Nome completo">
    <input id="cpf"   class="border p-2 rounded" placeholder="CPF (000.000.000-00)">
    <input id="email" class="border p-2 rounded" placeholder="Seu e-mail">
  </div>

  <!-- Gate de liberação -->
  <div class="p-4 border rounded mb-6">
    <p class="mb-2">Para iniciar a avaliação, digite seu <strong>CPF</strong> e clique em <strong>Verificar liberação</strong>.</p>
    <div class="flex gap-3 items-center">
      <button id="btnCheck" class="bg-indigo-700 text-white px-4 py-2 rounded">Verificar liberação</button>
      <span id="statusLib" class="text-sm"></span>
    </div>
  </div>

  <!-- Área do Quiz (preenchida após liberação) -->
  <form id="quizForm" class="space-y-6 hidden"></form>

  <div class="flex items-center gap-3 mt-6">
    <button id="btnEnviar" class="bg-blue-700 text-white px-5 py-3 rounded-xl hidden">Enviar respostas</button>
    <button id="btnEmail"  class="bg-emerald-600 text-white px-5 py-3 rounded-xl hidden">Enviar para meu e-mail</button>
    <a id="btnCert" href="certificado.html" class="bg-gray-300 text-gray-700 px-4 py-2 rounded hidden">Gerar Certificado (PDF)</a>
  </div>

  <p id="resultado" class="mt-6 text-lg font-semibold"></p>
  <p id="msgEmail" class="mt-2 text-sm"></p>

  <!-- Endpoint Formspree do Dino -->
  <script>const FORM_ENDPOINT="https://formspree.io/f/mldpzjra";</script>
</main>

<script src="assets/js/hashlib.js"></script>
<script src="assets/js/quiz.js"></script>
</body></html>
EOF

# 4) Lógica do quiz com gate de liberação por CPF/curso
cat > assets/js/quiz.js <<'EOF'
(async function(){
  // nomes
  const nomes = {
    nr1:"NR-1 – Disposições Gerais e GRO",
    nr20:"NR-20 – Inflamáveis e Combustíveis",
    nr33:"NR-33 – Espaço Confinado",
    nr35:"NR-35 – Trabalho em Altura",
    nr10:"NR-10 – Segurança em Eletricidade",
    nr05:"NR-05 – CIPA",
    nr06:"NR-06 – EPI"
  };
  // elementos
  const p = new URLSearchParams(location.search);
  const curso = (p.get("curso")||"nr1").toLowerCase();
  const cursoNome = nomes[curso] || curso.toUpperCase();
  document.getElementById("cursoTag").textContent = cursoNome;

  const fldNome = document.getElementById("aluno");
  const fldCPF  = document.getElementById("cpf");
  const fldMail = document.getElementById("email");
  const btnCheck= document.getElementById("btnCheck");
  const status  = document.getElementById("statusLib");
  const form    = document.getElementById("quizForm");
  const btnEnviar = document.getElementById("btnEnviar");
  const btnEmail  = document.getElementById("btnEmail");
  const btnCert   = document.getElementById("btnCert");
  const resultado = document.getElementById("resultado");
  const msgEmail  = document.getElementById("msgEmail");

  let perguntasSel = [];

  // Funções util
  function cpfClean(v){ return (v||"").replace(/\D/g,""); }
  function camposOK(){
    if(!fldNome.value.trim() || !fldCPF.value.trim() || !fldMail.value.trim()){
      status.textContent = "Preencha Nome, CPF e E-mail.";
      status.className = "text-red-600 text-sm";
      return false;
    }
    return true;
  }

  // Gate: só carrega questões se CPF+curso estiver aprovado (hash na approved.json)
  btnCheck.onclick = async ()=>{
    if(!camposOK()) return;
    status.textContent = "Verificando...";
    status.className   = "text-gray-600 text-sm";
    try{
      const aprov = await fetch("assets/approved.json").then(r=>r.json());
      const hash = await sha256Hex(cpfClean(fldCPF.value)+"-"+curso);
      const ok = (aprov.items||[]).includes(hash);
      if(ok){
        status.textContent = "Liberação confirmada. Boa prova!";
        status.className   = "text-emerald-700 text-sm";
        // carrega questões somente agora
        const arquivo = `assets/questions/${curso}.json`;
        const qs = await fetch(arquivo).then(r=>r.json());
        perguntasSel = qs.sort(()=>Math.random()-0.5).slice(0,10);
        form.innerHTML = ""; // limpa
        perguntasSel.forEach((item,idx)=>{
          const b = document.createElement("div");
          b.className="p-4 border rounded";
          b.innerHTML = `<p class="font-semibold mb-2">${idx+1}. ${item.q}</p>`+
            item.a.map((alt,i)=>`<label class="block"><input type="radio" name="q${idx}" value="${i}" class="mr-2"> ${String.fromCharCode(65+i)}) ${alt}</label>`).join("");
          form.appendChild(b);
        });
        form.classList.remove("hidden");
        btnEnviar.classList.remove("hidden");
      } else {
        status.textContent = "CPF/curso ainda NÃO liberado. Fale com a GLOBALLED SST.";
        status.className   = "text-red-600 text-sm";
      }
    }catch(e){
      status.textContent = "Falha ao verificar liberação.";
      status.className   = "text-red-600 text-sm";
    }
  };

  // Correção e envio
  btnEnviar.onclick = async (e)=>{
    e.preventDefault();
    let acertos=0, resp=0, respostas=[];
    perguntasSel.forEach((it,idx)=>{
      const v=(new FormData(form)).get("q"+idx);
      if(v!==null){resp++; if(+v===it.c) acertos++; respostas.push(+v);} else respostas.push(null);
    });
    const nota=Math.round((acertos/perguntasSel.length)*100);
    const ok=nota>=70 && resp===perguntasSel.length;
    resultado.textContent=`Acertos: ${acertos}/${perguntasSel.length} — Nota: ${nota}% ${ok?"(APROVADO)":"(REPROVADO)"}${resp<perguntasSel.length?" — Responda todas as questões.":""}`;

    if(ok){
      // guarda dados para certificado
      localStorage.setItem("cert_dados", JSON.stringify({
        curso:cursoNome, cod:curso, nota, data:new Date().toISOString(),
        aluno: fldNome.value, cpf: fldCPF.value
      }));
      btnEmail.classList.remove("hidden");
      btnCert.classList.remove("hidden");

      btnEmail.onclick = async ()=>{
        const payload = {
          curso: cursoNome, codigo: curso, nota,
          data: new Date().toLocaleString(),
          aluno: fldNome.value, cpf: fldCPF.value, email_aluno: fldMail.value,
          respostas: JSON.stringify(respostas)
        };
        msgEmail.textContent = "Enviando...";
        try{
          const r = await fetch(FORM_ENDPOINT, {
            method:"POST",
            headers:{ "Accept":"application/json", "Content-Type":"application/json" },
            body: JSON.stringify(payload), mode:"cors"
          });
          if(r.ok){ msgEmail.textContent="Enviado por e-mail (AJAX)."; msgEmail.className="text-emerald-700"; return; }
        }catch(e){}
        // fallback
        const f=document.createElement("form");
        f.action=FORM_ENDPOINT; f.method="POST"; f.target="_blank";
        Object.entries(payload).forEach(([k,v])=>{ const i=document.createElement("input"); i.type="hidden"; i.name=k; i.value=v; f.appendChild(i); });
        document.body.appendChild(f); f.submit();
        msgEmail.textContent="Enviado por e-mail (fallback formulário)."; msgEmail.className="text-emerald-700";
      };
    } else {
      btnEmail.classList.add("hidden");
      btnCert.classList.add("hidden");
    }
  };
})();
EOF

# 5) Script de ADMIN: liberar CPF+curso e publicar
cat > liberar_avaliacao.sh <<'EOF'
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
EOF
chmod +x liberar_avaliacao.sh

# 6) Commit e push das alterações
git add quiz.html assets/js/quiz.js assets/js/hashlib.js assets/approved.json
git commit -m "Gate de liberação por CPF/curso + coleta Nome/CPF/E-mail + envio Formspree"
git push
echo "✅ Liberação ativada. Use: ./liberar_avaliacao.sh <CPF> <curso>"
