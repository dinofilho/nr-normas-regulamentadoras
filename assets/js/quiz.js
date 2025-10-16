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
