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

  // Monta o quiz
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

  // Avaliar
  btnEnviar.onclick = (e)=>{
    e.preventDefault();
    let acertos=0, respondidas=0, respostas=[];
    perguntasSel.forEach((it,idx)=>{
      const v = (new FormData(form)).get("q"+idx);
      if(v!==null){respondidas++; if(+v===it.c) acertos++; respostas.push(+v);} else respostas.push(null);
    });
    const nota = Math.round((acertos/perguntasSel.length)*100);
    const ok = nota>=70 && respondidas===perguntasSel.length;
    resultado.textContent = `Acertos: ${acertos}/${perguntasSel.length} — Nota: ${nota}% ${ok?"(APROVADO)":"(REPROVADO)"}${respondidas<perguntasSel.length?" — Responda todas as questões.":""}`;

    if(ok){
      localStorage.setItem("cert_dados", JSON.stringify({curso:cursoNome, cod:curso, nota, data:new Date().toISOString()}));
      btnEmail.classList.remove("hidden");
      btnCert.classList.remove("hidden");

      // Envio por e-mail
      btnEmail.onclick = async ()=>{
        const payload = {
          curso: cursoNome,
          codigo: curso,
          nota: nota,
          data: new Date().toLocaleString(),
          respostas: JSON.stringify(respostas)
        };

        // 1) Tenta AJAX (JSON)
        try{
          const r = await fetch(FORM_ENDPOINT, {
            method:"POST",
            headers:{ "Accept":"application/json", "Content-Type":"application/json" },
            body: JSON.stringify(payload),
            mode: "cors"
          });
          if(r.ok){
            msgEmail.textContent = "Enviado por e-mail (AJAX). Verifique sua caixa de entrada/spam.";
            msgEmail.className = "text-emerald-700";
            return;
          }
        }catch(e){ /* ignora e tenta fallback */ }

        // 2) Fallback garantido: cria <form> e faz POST tradicional (abre aba de sucesso do Formspree)
        const f = document.createElement("form");
        f.action = FORM_ENDPOINT;
        f.method = "POST";
        f.target = "_blank"; // abre a página de sucesso sem sair do site
        Object.entries(payload).forEach(([k,v])=>{
          const inp = document.createElement("input");
          inp.type="hidden"; inp.name=k; inp.value=v;
          f.appendChild(inp);
        });
        document.body.appendChild(f);
        f.submit();
        msgEmail.textContent = "Enviado por e-mail (fallback formulário).";
        msgEmail.className = "text-emerald-700";
      };
    } else {
      btnEmail.classList.add("hidden");
      btnCert.classList.add("hidden");
    }
  };
})();
