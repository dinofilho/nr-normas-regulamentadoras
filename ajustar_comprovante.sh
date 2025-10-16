#!/bin/bash
set -e
cd ~/nr-normas-regulamentadoras

# 1) Página do COMPROVANTE (sem a palavra "certificado")
cat > comprovante.html <<'EOF'
<!DOCTYPE html><html lang="pt-BR"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Comprovante de Avaliação</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head><body class="bg-gray-100 text-gray-900">
<main class="max-w-3xl mx-auto p-6">
  <div class="bg-white p-8 shadow rounded-xl">
    <h1 class="text-2xl font-bold text-center mb-6">COMPROVANTE DE AVALIAÇÃO (TEORIA – EAD)</h1>
    <div class="grid md:grid-cols-2 gap-4">
      <div><label class="text-sm">Aluno</label><input id="aluno" class="border p-2 rounded w-full" placeholder="Nome completo"></div>
      <div><label class="text-sm">CPF</label><input id="cpf" class="border p-2 rounded w-full" placeholder="000.000.000-00"></div>
      <div><label class="text-sm">Cidade</label><input id="cidade" class="border p-2 rounded w-full" placeholder="Cidade"></div>
      <div><label class="text-sm">Estado (UF)</label>
        <select id="uf" class="border p-2 rounded w-full">
          <option value="">Selecionar</option>
          <option>AC</option><option>AL</option><option>AP</option><option>AM</option>
          <option>BA</option><option>CE</option><option>DF</option><option>ES</option>
          <option>GO</option><option>MA</option><option>MT</option><option>MS</option>
          <option>MG</option><option>PA</option><option>PB</option><option>PR</option>
          <option>PE</option><option>PI</option><option>RJ</option><option>RN</option>
          <option>RS</option><option>RO</option><option>RR</option><option>SC</option>
          <option>SP</option><option>SE</option><option>TO</option>
        </select>
      </div>
      <div><label class="text-sm">Curso / NR</label><input id="curso" class="border p-2 rounded w-full" disabled></div>
      <div><label class="text-sm">Nota</label><input id="nota" class="border p-2 rounded w-full" disabled></div>
      <div><label class="text-sm">Data da avaliação</label><input id="data" class="border p-2 rounded w-full" disabled></div>
    </div>
    <p class="text-xs text-gray-600 mt-4">
      Observação: Quando houver parte PRÁTICA obrigatória, o registro da prática (data/local/instrutor) deve ser feito em documento próprio.
    </p>
    <div class="mt-6">
      <button id="btnPDF" class="bg-blue-700 text-white px-4 py-2 rounded">Baixar Comprovante (PDF)</button>
    </div>
  </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/jspdf@2.5.1/dist/jspdf.umd.min.js"></script>
<script src="assets/js/comprovante.js"></script>
</body></html>
EOF

# 2) JS do comprovante (gera PDF simples e limpo)
cat > assets/js/comprovante.js <<'EOF'
(function(){
  const saved = JSON.parse(localStorage.getItem("cert_dados")||"{}");
  const fmtData = (iso)=>{
    try{ const d = new Date(iso); return d.toLocaleDateString("pt-BR"); }catch(e){ return "-"; }
  };
  document.getElementById("curso").value = saved.curso || "-";
  document.getElementById("nota").value  = (saved.nota!=null ? saved.nota+"%" : "-");
  document.getElementById("data").value  = saved.data ? fmtData(saved.data) : fmtData(new Date().toISOString());
  if(saved.aluno) document.getElementById("aluno").value = saved.aluno;
  if(saved.cpf)   document.getElementById("cpf").value   = saved.cpf;

  document.getElementById("btnPDF").onclick = ()=>{
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF({unit:"pt", format:"a4"});
    const L = 80; let y = 120;
    doc.setFontSize(18);
    doc.text("COMPROVANTE DE AVALIAÇÃO (TEORIA – EAD)", 300, 80, {align:"center"});
    doc.setFontSize(12);
    const get = id => document.getElementById(id).value||"";
    const linhas = [
      "Aluno: " + get("aluno"),
      "CPF: " + get("cpf"),
      "Cidade/UF: " + get("cidade") + " / " + get("uf"),
      "Curso/NR: " + get("curso"),
      "Nota: " + get("nota"),
      "Data da avaliação: " + get("data")
    ];
    linhas.forEach(t => { doc.text(t, L, y); y+=22; });
    doc.text("Observação: quando houver PRÁTICA obrigatória, registrar a parte prática separadamente.", L, y+20);
    doc.save("comprovante-avaliacao.pdf");
  };
})();
EOF

# 3) Atualiza o quiz para mostrar apenas "Baixar Comprovante (PDF)" (remove envio por e-mail)
cat > quiz.html <<'EOF'
<!DOCTYPE html><html lang="pt-BR"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quiz – Avaliação Teórica</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head><body class="bg-gray-50 text-gray-900">
<header class="bg-blue-900 text-white p-4"><div class="max-w-4xl mx-auto flex justify-between">
  <a href="index.html" class="font-bold">NR NORMAS REGULAMENTADORAS</a><span id="cursoTag"></span>
</div></header>
<main class="max-w-4xl mx-auto p-6">
  <h1 class="text-2xl font-bold mb-4">Avaliação Teórica</h1>

  <!-- Identificação -->
  <div class="grid md:grid-cols-3 gap-4 mb-6">
    <input id="aluno" class="border p-2 rounded" placeholder="Nome completo">
    <input id="cpf"   class="border p-2 rounded" placeholder="CPF (000.000.000-00)">
    <input id="email" class="border p-2 rounded" placeholder="(opcional) e-mail">
  </div>

  <form id="quizForm" class="space-y-6"></form>

  <div class="flex items-center gap-3 mt-6">
    <button id="btnEnviar" class="bg-blue-700 text-white px-5 py-3 rounded-xl">Enviar respostas</button>
    <a id="btnComprovante" href="comprovante.html" class="bg-green-600 text-white px-4 py-2 rounded hidden">Baixar Comprovante (PDF)</a>
  </div>

  <p id="resultado" class="mt-6 text-lg font-semibold"></p>
</main>
<script src="assets/js/quiz.js"></script>
</body></html>
EOF

# 4) Lógica do quiz (mostra botão de comprovante ao aprovar e grava dados)
cat > assets/js/quiz.js <<'EOF'
(function(){
  const nomes = {
    nr1:"NR-1 – Disposições Gerais e GRO",
    nr20:"NR-20 – Inflamáveis e Combustíveis",
    nr33:"NR-33 – Espaço Confinado",
    nr35:"NR-35 – Trabalho em Altura",
    nr10:"NR-10 – Segurança em Eletricidade",
    nr05:"NR-05 – CIPA",
    nr06:"NR-06 – EPI"
  };
  const params = new URLSearchParams(location.search);
  const curso = (params.get("curso")||"nr1").toLowerCase();
  const cursoNome = nomes[curso] || curso.toUpperCase();
  document.getElementById("cursoTag").textContent = cursoNome;

  const arquivo = `assets/questions/${curso}.json`;
  const form = document.getElementById("quizForm");
  const btnEnviar = document.getElementById("btnEnviar");
  const btnComp  = document.getElementById("btnComprovante");
  const resultado = document.getElementById("resultado");
  const fldNome = document.getElementById("aluno");
  const fldCPF  = document.getElementById("cpf");

  // monta questões
  fetch(arquivo).then(r=>r.json()).then(qs=>{
    const perguntasSel = qs.sort(()=>Math.random()-0.5).slice(0,10);
    perguntasSel.forEach((item,idx)=>{
      const b = document.createElement("div");
      b.className="p-4 border rounded";
      b.innerHTML = `<p class="font-semibold mb-2">${idx+1}. ${item.q}</p>`+
        item.a.map((alt,i)=>`<label class="block"><input type="radio" name="q${idx}" value="${i}" class="mr-2"> ${String.fromCharCode(65+i)}) ${alt}</label>`).join("");
      form.appendChild(b);
    });

    btnEnviar.onclick = (e)=>{
      e.preventDefault();
      let acertos=0, resp=0;
      perguntasSel.forEach((it,idx)=>{
        const v=(new FormData(form)).get("q"+idx);
        if(v!==null){resp++; if(+v===it.c) acertos++;}
      });
      const nota = Math.round((acertos/perguntasSel.length)*100);
      const ok = nota>=70 && resp===perguntasSel.length;
      resultado.textContent = `Acertos: ${acertos}/${perguntasSel.length} — Nota: ${nota}% ${ok?"(APROVADO)":"(REPROVADO)"}${resp<perguntasSel.length?" — Responda todas as questões.":""}`;

      if(ok){
        // salva dados para o comprovante
        localStorage.setItem("cert_dados", JSON.stringify({
          curso: cursoNome, cod: curso, nota, data: new Date().toISOString(),
          aluno: fldNome.value||"", cpf: fldCPF.value||""
        }));
        btnComp.classList.remove("hidden");
      } else {
        btnComp.classList.add("hidden");
      }
    };
  }).catch(()=>{ resultado.textContent="Banco de questões não encontrado."; });
})();
EOF

# 5) Commit & push
git add quiz.html comprovante.html assets/js/quiz.js assets/js/comprovante.js
git commit -m "Tira 'certificado'; adiciona Comprovante de Avaliação com Nome/CPF/Cidade/UF/Data e nota"
git push
echo "✅ Pronto! Use o botão 'Baixar Comprovante (PDF)' após aprovação."
