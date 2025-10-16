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
