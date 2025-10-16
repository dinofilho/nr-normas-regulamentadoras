#!/bin/bash
set -e

cd ~/nr-normas-regulamentadoras

mkdir -p assets/js assets/questions

############################################
# 1) Bancos de questões (10 por NR)
############################################
cat > assets/questions/nr33.json <<'EOF'
[
 {"q":"A NR-33 trata de:", "a":["Trabalho em altura","Espaço confinado","Eletricidade","Ergonomia"], "c":1},
 {"q":"Documento que autoriza atividades no espaço confinado:", "a":["CAT","PET (Permissão de Entrada e Trabalho)","PPP","PTA"], "c":1},
 {"q":"Monitoramento em espaço confinado envolve:", "a":["Apenas O2","O2, inflamáveis e tóxicos","Somente CO2","Somente CH4"], "c":1},
 {"q":"Quem pode ser vigia:", "a":["Qualquer pessoa","Trabalhador treinado e designado","Somente supervisor","Apenas brigadista"], "c":1},
 {"q":"Resgate deve ser:", "a":["Improvisado","Planejado e com equipamentos","Feito só pelo bombeiro","Somente com macas"], "c":1},
 {"q":"Comunicação entre equipe:", "a":["Não é necessária","É obrigatória e contínua","Somente por celular","Somente por rádio"], "c":1},
 {"q":"Bloqueio/etiquetagem (LOTO):", "a":["Opcional","Recomendado","Exigido quando aplicável","Proibido"], "c":2},
 {"q":"Ventilação:", "a":["Dispensável","Somente natural","Deve garantir atmosfera segura","Apenas após o trabalho"], "c":2},
 {"q":"Treinamentos da NR-33:", "a":["Sem reciclagem","Com reciclagem periódica","Apenas no admissional","Somente on-the-job"], "c":1},
 {"q":"Registros:", "a":["Dispensáveis","Apenas fotos","Conservar PETs, listas e avaliações","Somente atas"], "c":2}
]
EOF

cat > assets/questions/nr35.json <<'EOF'
[
 {"q":"A NR-35 trata de:", "a":["Máquinas","Ergonomia","Trabalho em altura","Eletricidade"], "c":2},
 {"q":"Altura considerada pela NR-35:", "a":["> 1 m","> 1,5 m","> 2 m","> 3 m"], "c":2},
 {"q":"Treinamento:", "a":["Somente presencial","Teoria pode ser EAD + prática presencial","Apenas EAD","Não exige"], "c":1},
 {"q":"EPI principal:", "a":["Capacete","Cinturão paraquedista","Óculos","Luvas de vaqueta"], "c":1},
 {"q":"Sistema de ancoragem deve:", "a":["Ser improvisado","Atender resistência e norma","Usar corda qualquer","Ser qualquer estrutura"], "c":1},
 {"q":"Condições impeditivas:", "a":["Nunca existem","Devem interromper o trabalho","Ignorar se há prazo","Somente em chuva"], "c":1},
 {"q":"Resgate:", "a":["Não se planeja","Planejado antes do trabalho","Chama depois se precisar","Só bombeiro decide"], "c":1},
 {"q":"Inspeção de EPI:", "a":["Sem necessidade","Antes de usar e periodicamente","Uma vez ao ano","Só pelo fabricante"], "c":1},
 {"q":"Documentos típicos:", "a":["PET","APR/PGR e checklist","PPP","CAT"], "c":1},
 {"q":"Trabalhos com vento forte/chuva:", "a":["Prosseguir","A critério do trabalhador","Avaliar e interromper se inseguro","Ignorar"], "c":2}
]
EOF

cat > assets/questions/nr10.json <<'EOF'
[
 {"q":"A NR-10 trata de:", "a":["Eletricidade","Máquinas","Espaço confinado","Altura"], "c":0},
 {"q":"Choque elétrico e arco:", "a":["Não são riscos","São riscos relevantes","Apenas baixa tensão","Somente em média tensão"], "c":1},
 {"q":"Documento de segurança em serviços:", "a":["PPRA","PGR/Procedimentos e prontuário","PET","CAT"], "c":1},
 {"q":"Bloqueio e etiquetagem:", "a":["Não se aplica","Somente escritório","Medida de controle essencial","Proibido"], "c":2},
 {"q":"Trabalhos energizados exigem:", "a":["Nada especial","Autorização, procedimentos e EPI/EPC","Apenas luvas","Somente extintor"], "c":1},
 {"q":"Treinamento teórico:", "a":["Pode ser EAD","Proibido","Somente oral","Sem avaliação"], "c":0},
 {"q":"Prontuário de instalações:", "a":["Dispensável","Manter atualizado","Somente foto","Somente diagrama"], "c":1},
 {"q":"Aterramento e equipotencialização:", "a":["Indiferentes","Medidas importantes","Somente estética","Proibidos"], "c":1},
 {"q":"Primeiros socorros e combate a incêndio:", "a":["Irrelevantes","Conteúdos do curso","Somente CIPA","Somente brigada"], "c":1},
 {"q":"Responsabilidade do empregador:", "a":["Fornecer condições seguras e capacitar","Somente punir","Ignorar terceirizados","Apenas comprar EPI"], "c":0}
]
EOF

cat > assets/questions/nr05.json <<'EOF'
[
 {"q":"A NR-05 trata de:", "a":["CIPA","EPI","Eletricidade","Ergonomia"], "c":0},
 {"q":"Missão da CIPA:", "a":["Apenas fiscalizar","Prevenir acidentes e doenças","Punir trabalhadores","Emitir CAT"], "c":1},
 {"q":"Eleições da CIPA:", "a":["Dispensáveis","Devem seguir regras da NR-05","Por indicação","Somente anuais"], "c":1},
 {"q":"Reuniões:", "a":["Sem atas","Com atas e pauta","Só quando há acidente","Somente on-line"], "c":1},
 {"q":"Mapa de riscos/Inventário:", "a":["Inútil","Ferramenta de prevenção","Somente para auditoria","Apenas RH"], "c":1},
 {"q":"Treinamento dos cipeiros:", "a":["Não precisa","Teoria pode ser EAD","Somente prática","Somente vídeo"], "c":1},
 {"q":"Participação dos empregados:", "a":["Indiferente","Importante para prevenção","Proibida","Somente chefia"], "c":1},
 {"q":"Integração com PGR/GRO:", "a":["Não há","É necessária","Opcional","Proibida"], "c":1},
 {"q":"Comunicação de risco:", "a":["Dispensável","Fundamental","Somente por e-mail","Somente cartazes"], "c":1},
 {"q":"Avaliação de eficácia:", "a":["Não existe","Acompanhar indicadores e ações","Somente auditoria externa","Somente multas"], "c":1}
]
EOF

cat > assets/questions/nr06.json <<'EOF'
[
 {"q":"A NR-06 trata de:", "a":["CIPA","EPI","Máquinas","Armazenagem"], "c":1},
 {"q":"Obrigação do empregador:", "a":["Vender EPI","Fornecer EPI adequado e gratuito","Cobrar do empregado","Ignorar CA"], "c":1},
 {"q":"Certificado de Aprovação (CA):", "a":["Não importa","Deve estar válido","Somente estético","Somente importados"], "c":1},
 {"q":"Treinamento sobre EPI:", "a":["Dispensável","Necessário (uso, higienização, guarda)","Somente vídeo","Somente manual"], "c":1},
 {"q":"Responsabilidade do empregado:", "a":["Não usar","Usar e conservar","Revender","Guardar em casa"], "c":1},
 {"q":"Registro de entrega:", "a":["Desnecessário","Importante para rastreio","Somente verbal","Somente mensal"], "c":1},
 {"q":"Integração com PGR/GRO:", "a":["Inexistente","Necessária","Proibida","Somente RH"], "c":1},
 {"q":"Substituição de EPI danificado:", "a":["Ignorar","Imediata","Somente em auditoria","Somente anual"], "c":1},
 {"q":"Conforto e tamanho:", "a":["Indiferente","Critérios de seleção","Proibidos","Somente P"], "c":1},
 {"q":"EPI coletivo:", "a":["É EPC","Não existe","É CA coletivo","É uniforme"], "c":0}
]
EOF

############################################
# 2) Página de Quiz (genérica) + lógica
############################################
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
  <button id="btnEnviar" class="mt-6 bg-blue-700 text-white px-5 py-3 rounded-xl">Enviar respostas</button>
  <p id="resultado" class="mt-6 text-lg font-semibold"></p>
  <div id="certBlock" class="mt-4 hidden">
    <a href="certificado.html" class="bg-green-600 text-white px-4 py-2 rounded">Gerar Certificado</a>
  </div>
</main>
<script src="assets/js/quiz.js"></script>
</body></html>
EOF

cat > assets/js/quiz.js <<'EOF'
(function(){
  const nomes = {
    nr1: "NR-1 – Disposições Gerais e GRO",
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
  fetch(arquivo).then(r=>r.json()).then(qs=>{
    // 10 questões
    const sel = qs.sort(()=>Math.random()-0.5).slice(0,10);
    const form = document.getElementById("quizForm");
    sel.forEach((item,idx)=>{
      const b = document.createElement("div");
      b.className="p-4 border rounded";
      b.innerHTML = `<p class="font-semibold mb-2">${idx+1}. ${item.q}</p>`+
        item.a.map((alt,i)=>`<label class="block"><input type="radio" name="q${idx}" value="${i}" class="mr-2"> ${String.fromCharCode(65+i)}) ${alt}</label>`).join("");
      form.appendChild(b);
    });
    document.getElementById("btnEnviar").onclick = ()=>{
      let acertos=0, respondidas=0;
      sel.forEach((it,idx)=>{
        const v = (new FormData(form)).get("q"+idx);
        if(v!==null){respondidas++; if(+v===it.c) acertos++; }
      });
      const nota = Math.round((acertos/sel.length)*100);
      const ok = nota>=70 && respondidas===sel.length;
      const res = document.getElementById("resultado");
      res.textContent = `Acertos: ${acertos}/${sel.length} — Nota: ${nota}% ${ok?"(APROVADO)":"(REPROVADO)"}${respondidas<sel.length?" — Responda todas as questões.":""}`;
      if(ok){
        localStorage.setItem("cert_dados", JSON.stringify({
          curso: cursoNome, cod: curso, nota, data: new Date().toISOString()
        }));
        document.getElementById("certBlock").classList.remove("hidden");
      }
    };
  }).catch(()=>{ document.getElementById("resultado").textContent="Banco de questões não encontrado."; });
})();
EOF

############################################
# 3) Certificado HTML → PDF com QR
############################################
cat > certificado.html <<'EOF'
<!DOCTYPE html><html lang="pt-BR"><head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Certificado</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head><body class="bg-gray-100 text-gray-900">
<main class="max-w-3xl mx-auto p-6">
  <div class="bg-white p-8 shadow rounded-xl">
    <h1 class="text-2xl font-bold text-center mb-4">CERTIFICADO DE CONCLUSÃO (TEORIA – EAD)</h1>
    <p class="mb-2"><strong>Aluno:</strong> <input id="aluno" class="border p-2 rounded w-full" placeholder="Nome completo"></p>
    <p class="mb-2"><strong>CPF:</strong> <input id="cpf" class="border p-2 rounded w-full" placeholder="000.000.000-00"></p>
    <p class="mb-2"><strong>Curso/NR:</strong> <span id="curso"></span></p>
    <p class="mb-2"><strong>Nota (teoria):</strong> <span id="nota"></span></p>
    <p class="mb-2"><strong>Carga horária (teórica):</strong> <input id="carga" class="border p-2 rounded w-full" placeholder="ex.: 8h"></p>
    <p class="mb-2"><strong>Responsável técnico:</strong> <input id="rt" class="border p-2 rounded w-full" placeholder="Nome – CREA nº"></p>
    <p class="mb-2"><strong>CNPJ/Endereço (GLOBALLED SST):</strong> <input id="cnpj" class="border p-2 rounded w-full" placeholder="CNPJ – Endereço"></p>
    <p class="text-sm text-gray-600 mb-4">Observação: quando houver prática obrigatória, registrar data/local/instrutor no anexo.</p>
    <div class="flex items-center gap-3">
      <button id="btnPDF" class="bg-blue-700 text-white px-4 py-2 rounded">Gerar PDF</button>
      <div id="qrcode" class="ml-auto"></div>
    </div>
  </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/jspdf@2.5.1/dist/jspdf.umd.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/qrcodejs@1.0.0/qrcode.min.js"></script>
<script src="assets/js/cert.js"></script>
</body></html>
EOF

cat > assets/js/cert.js <<'EOF'
(function(){
  const saved = JSON.parse(localStorage.getItem("cert_dados")||"{}");
  document.getElementById("curso").textContent = saved.curso||"-";
  document.getElementById("nota").textContent = (saved.nota!=null?(saved.nota+"%"):"-");
  const verURL = location.origin+location.pathname+"#"+btoa(JSON.stringify({c:saved.cod||"-",d:saved.data||"-"}));
  new QRCode(document.getElementById("qrcode"), { text: verURL, width: 96, height: 96 });

  document.getElementById("btnPDF").onclick = ()=>{
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF({unit:"pt", format:"a4"});
    const L=80; let y=120;
    const texto = (t)=>{ doc.text(t, L, y); y+=22; };
    const aluno = document.getElementById("aluno").value||"";
    const cpf = document.getElementById("cpf").value||"";
    const curso = document.getElementById("curso").textContent||"";
    const nota = document.getElementById("nota").textContent||"";
    const carga = document.getElementById("carga").value||"";
    const rt = document.getElementById("rt").value||"";
    const cnpj = document.getElementById("cnpj").value||"";
    doc.setFontSize(18); doc.text("CERTIFICADO DE CONCLUSÃO (TEORIA – EAD)", 300, 80, {align:"center"});
    doc.setFontSize(12);
    texto("Aluno: "+aluno);
    texto("CPF: "+cpf);
    texto("Curso/NR: "+curso);
    texto("Nota (teoria): "+nota);
    texto("Carga horária (teórica): "+carga);
    texto("Responsável técnico: "+rt);
    texto("CNPJ/Endereço (GLOBALLED SST): "+cnpj);
    texto("Observação: quando houver PRÁTICA obrigatória, registrar data/local/instrutor em anexo.");
    doc.text("Verificação rápida (QR): "+(location.origin+location.pathname), L, y+20);
    const qr = document.querySelector("#qrcode canvas");
    if(qr){ const img = qr.toDataURL("image/png"); doc.addImage(img, "PNG", 440, 120, 96, 96); }
    doc.save("certificado-"+(curso||"NR")+".pdf");
  };
})();
EOF

############################################
# 4) Inserir botão "Fazer Avaliação" nas páginas
############################################
for P in nr33 nr35 nr10 nr05 nr06; do
  sed -i '0,/<div class="mt-8">/s//<div class="mt-8"><a href="quiz.html?curso='"$P"'" class="inline-block bg-blue-700 text-white px-5 py-3 rounded-xl mr-3">Fazer Avaliação<\/a>/' "$P.html"
done

echo "✅ Bancos criados, quiz genérico atualizado, certificado com QR pronto e botões adicionados."
