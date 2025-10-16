#!/bin/bash
set -e
cd ~/nr-normas-regulamentadoras

# 1) Garante o botão "Fazer Avaliação" nas páginas NR-1 e NR-20
for P in nr1 nr20; do
  if ! grep -q 'quiz.html?curso='"$P"'' "$P.html"; then
    sed -i '0,/<div class="mt-8">/s//<div class="mt-8"><a href="quiz.html?curso='"$P"'" class="inline-block bg-blue-700 text-white px-5 py-3 rounded-xl mr-3">Fazer Avaliação<\/a>/' "$P.html"
    echo "✓ Botão adicionado em $P.html"
  else
    echo "• $P.html já tinha o botão"
  fi
done

# 2) Atualiza o quiz.html para incluir botão de envio por e-mail (Formspree)
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
  <form id="quizForm" class="space-y-6"></form>

  <div class="flex items-center gap-3 mt-6">
    <button id="btnEnviar" class="bg-blue-700 text-white px-5 py-3 rounded-xl">Enviar respostas</button>
    <button id="btnEmail"  class="bg-emerald-600 text-white px-5 py-3 rounded-xl hidden">Enviar para meu e-mail</button>
    <a id="btnCert" href="certificado.html" class="bg-gray-300 text-gray-700 px-4 py-2 rounded hidden">Gerar Certificado (PDF)</a>
  </div>

  <p id="resultado" class="mt-6 text-lg font-semibold"></p>
  <p id="msgEmail" class="mt-2 text-sm"></p>

  <!-- Configurar seu endpoint do Formspree aqui: -->
  <script>const FORM_ENDPOINT = "COLE_AQUI_SEU_ENDPOINT_DO_FORMSPREE";</script>
</main>
<script src="assets/js/quiz.js"></script>
</body></html>
EOF

# 3) Lógica do quiz com envio por e-mail
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
  const btnEmail  = document.getElementById("btnEmail");
  const btnCert   = document.getElementById("btnCert");
  const resultado = document.getElementById("resultado");
  const msgEmail  = document.getElementById("msgEmail");

  let perguntasSel = [];

  fetch(arquivo).then(r=>r.json()).then(qs=>{
    perguntasSel = qs.sort(()=>Math.random()-0.5).slice(0,10);
    perguntasSel.forEach((item,idx)=>{
      const b = document.createElement("div");
      b.className="p-4 border rounded";
      b.innerHTML = `<p class="font-semibold mb-2">${idx+1}. ${item.q}</p>`+
        item.a.map((alt,i)=>`<label class="block"><input type="radio" name="q${idx}" value="${i}" class="mr-2"> ${String.fromCharCode(65+i)}) ${alt}</label>`).join("");
      form.appendChild(b);
    });
  });

  btnEnviar.onclick = (e)=>{
    e.preventDefault();
    let acertos=0, respondidas=0, respostas=[];
    perguntasSel.forEach((it,idx)=>{
      const v = (new FormData(form)).get("q"+idx);
      if(v!==null){respondidas++; if(+v===it.c) acertos++; respostas.push(+v); }
      else respostas.push(null);
    });
    const nota = Math.round((acertos/perguntasSel.length)*100);
    const ok = nota>=70 && respondidas===perguntasSel.length;
    resultado.textContent = `Acertos: ${acertos}/${perguntasSel.length} — Nota: ${nota}% ${ok?"(APROVADO)":"(REPROVADO)"}${respondidas<perguntasSel.length?" — Responda todas as questões.":""}`;

    if(ok){
      // salva para o certificado (opcional)
      localStorage.setItem("cert_dados", JSON.stringify({curso:cursoNome, cod:curso, nota, data:new Date().toISOString()}));
      btnEmail.classList.remove("hidden");   // habilita envio por e-mail
      btnCert.classList.remove("hidden");    // mantém opção de gerar PDF local, se desejar
      // prepara payload para e-mail
      btnEmail.onclick = async ()=>{
        if(!window.FORM_ENDPOINT || FORM_ENDPOINT.includes("COLE_AQUI")) {
          msgEmail.textContent = "Configure o FORM_ENDPOINT no arquivo quiz.html (Formspree).";
          msgEmail.className = "text-red-600";
          return;
        }
        const payload = {
          curso: cursoNome,
          cod: curso,
          nota: nota,
          data: new Date().toLocaleString(),
          respostas: JSON.stringify(respostas)
        };
        msgEmail.textContent = "Enviando...";
        try{
          const r = await fetch(FORM_ENDPOINT, {
            method:"POST",
            headers:{ "Accept":"application/json", "Content-Type":"application/json" },
            body: JSON.stringify(payload)
          });
          if(r.ok){
            msgEmail.textContent = "Enviado para seu e-mail. Verifique a caixa de entrada.";
            msgEmail.className = "text-emerald-700";
          } else {
            msgEmail.textContent = "Falha ao enviar. Confira o endpoint do Formspree.";
            msgEmail.className = "text-red-600";
          }
        }catch(err){
          msgEmail.textContent = "Erro de rede ao enviar.";
          msgEmail.className = "text-red-600";
        }
      };
    } else {
      btnEmail.classList.add("hidden");
      btnCert.classList.add("hidden");
    }
  };
})();
EOF

echo "✅ Botões NR-1/NR-20 garantidos e quiz preparado para envio por e-mail (Formspree)."

