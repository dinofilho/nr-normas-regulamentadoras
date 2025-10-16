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
