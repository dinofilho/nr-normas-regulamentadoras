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
