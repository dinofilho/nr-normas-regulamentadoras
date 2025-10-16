#!/bin/bash
set -e
echo "➡️ Arrumando estrutura do quiz e bancos de questões..."

mkdir -p assets/js assets/questions

# 1) (Re)cria quiz.html consistente
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

# 2) (Re)cria a lógica do quiz
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
  const form = document.getElementById("quizForm");
  const btnEnviar = document.getElementById("btnEnviar");
  const btnComp  = document.getElementById("btnComprovante");
  const resultado = document.getElementById("resultado");
  const fldNome = document.getElementById("aluno");
  const fldCPF  = document.getElementById("cpf");

  const tag = document.getElementById("cursoTag");
  if(tag) tag.textContent = cursoNome;

  const arquivo = `assets/questions/${curso}.json`;

  fetch(arquivo).then(r=>{
    if(!r.ok) throw new Error("Arquivo de questões não encontrado");
    return r.json();
  }).then(qs=>{
    const perguntasSel = qs.slice(0); // copia
    // garante pelo menos 10
    while(perguntasSel.length<10 && qs.length>0){ perguntasSel.push(qs[perguntasSel.length%qs.length]); }
    // embaralha e corta em 10
    perguntasSel.sort(()=>Math.random()-0.5);
    const chosen = perguntasSel.slice(0,10);

    chosen.forEach((item,idx)=>{
      const b = document.createElement("div");
      b.className="p-4 border rounded";
      b.innerHTML = `<p class="font-semibold mb-2">${idx+1}. ${item.q}</p>`+
        item.a.map((alt,i)=>`<label class="block"><input type="radio" name="q${idx}" value="${i}" class="mr-2"> ${String.fromCharCode(65+i)}) ${alt}</label>`).join("");
      form.appendChild(b);
    });

    btnEnviar.onclick = (e)=>{
      e.preventDefault();
      let acertos=0, resp=0;
      chosen.forEach((it,idx)=>{
        const v=(new FormData(form)).get("q"+idx);
        if(v!==null){resp++; if(+v===it.c) acertos++;}
      });
      const nota = Math.round((acertos/chosen.length)*100);
      const ok = nota>=70 && resp===chosen.length;
      resultado.textContent = `Acertos: ${acertos}/${chosen.length} — Nota: ${nota}% ${ok?"(APROVADO)":"(REPROVADO)"}${resp<chosen.length?" — Responda todas as questões.":""}`;

      if(ok){
        localStorage.setItem("cert_dados", JSON.stringify({
          curso: cursoNome, cod: curso, nota, data: new Date().toISOString(),
          aluno: (fldNome.value||""), cpf: (fldCPF.value||"")
        }));
        btnComp.classList.remove("hidden");
      } else {
        btnComp.classList.add("hidden");
      }
    };
  }).catch(err=>{
    resultado.className="mt-6 text-lg font-semibold text-red-600";
    resultado.textContent = "Não foi possível carregar as questões deste curso ("+err.message+").";
  });
})();
EOF

# 3) Garante bancos de questões mínimos (se faltar)
make_q () {
  local F="assets/questions/$1.json"
  if [ ! -f "$F" ]; then
    cat > "$F" <<'QZ'
[
  {"q":"Pergunta 1 do curso.","a":["A","B","C","D"],"c":0},
  {"q":"Pergunta 2 do curso.","a":["A","B","C","D"],"c":1},
  {"q":"Pergunta 3 do curso.","a":["A","B","C","D"],"c":2},
  {"q":"Pergunta 4 do curso.","a":["A","B","C","D"],"c":3},
  {"q":"Pergunta 5 do curso.","a":["A","B","C","D"],"c":0},
  {"q":"Pergunta 6 do curso.","a":["A","B","C","D"],"c":1},
  {"q":"Pergunta 7 do curso.","a":["A","B","C","D"],"c":2},
  {"q":"Pergunta 8 do curso.","a":["A","B","C","D"],"c":3},
  {"q":"Pergunta 9 do curso.","a":["A","B","C","D"],"c":0},
  {"q":"Pergunta 10 do curso.","a":["A","B","C","D"],"c":1}
]
QZ
    echo "✓ Criado $F"
  else
    echo "• Já existe $F"
  fi
}
for C in nr1 nr20 nr33 nr35 nr10 nr05 nr06; do make_q "$C"; done

# 4) Injeta/garante botões "Fazer Avaliação" em cada NR
ensure_btn () {
  local FILE="$1" CURSO="$2"
  [ -f "$FILE" ] || { echo "• $FILE não existe — pulando"; return; }
  if ! grep -q "quiz.html?curso=$CURSO" "$FILE"; then
    # Injeta após primeira <div class="mt-8">; se não houver, injeta antes do fechamento de </main> ou no final do arquivo
    if grep -q '<div class="mt-8">' "$FILE"; then
      sed -i "0,/<div class=\"mt-8\">/s//<div class=\"mt-8\"><a href=\"quiz.html?curso=$CURSO\" class=\"inline-block bg-blue-700 text-white px-5 py-3 rounded-xl mr-3\">Fazer Avaliação<\/a>/" "$FILE"
    elif grep -q '</main>' "$FILE"; then
      sed -i "0,/<\/main>/s//<div class=\"mt-8\"><a href=\"quiz.html?curso=$CURSO\" class=\"inline-block bg-blue-700 text-white px-5 py-3 rounded-xl mr-3\">Fazer Avaliação<\/a><\/div>\n<\/main>/" "$FILE"
    else
      echo -e '\n<div class="mt-8"><a href="quiz.html?curso='"$CURSO"'" class="inline-block bg-blue-700 text-white px-5 py-3 rounded-xl mr-3">Fazer Avaliação</a></div>' >> "$FILE"
    fi
    echo "✓ Botão incluído em $FILE → $CURSO"
  else
    echo "• $FILE já tem o botão → $CURSO"
  fi
}
ensure_btn nr1.html  nr1
ensure_btn nr20.html nr20
ensure_btn nr33.html nr33
ensure_btn nr35.html nr35
ensure_btn nr10.html nr10
ensure_btn nr05.html nr05
ensure_btn nr06.html nr06

echo "➡️ Commitando e publicando..."
git add quiz.html assets/js/quiz.js assets/questions/*.json nr1.html nr20.html nr33.html nr35.html nr10.html nr05.html nr06.html || true
git commit -m "Fix geral: quiz.html/JS recriados, questões mínimas, botões 'Fazer Avaliação' em todas NRs"
git push
echo "✅ Finalizado. Atualize o site com Ctrl+F5."
