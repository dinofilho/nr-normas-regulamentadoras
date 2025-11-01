// === AUTO-GRADE: cálculo de nota + edição simples de gabarito ===
// Como editar as notas (gabarito):
// 1) Abaixo, em GABARITOS, troque as letras corretas (a, b, c, d) por NR.
// 2) Cada entrada é o valor do <input type="radio" value="a|b|c|d"> da questão q1..qN.
// 3) Se alguma NR tiver menos/mais questões, ajuste a lista (remova ou acrescente q's).

const GABARITOS = {
  "NR-1":  { q1:"c", q2:"b", q3:"a", q4:"d", q5:"b", q6:"a", q7:"d", q8:"c", q9:"b", q10:"a" },
  "NR-20": { q1:"b", q2:"b", q3:"a", q4:"c", q5:"d", q6:"a", q7:"c", q8:"b", q9:"a", q10:"d" },
  "NR-33": { q1:"a", q2:"c", q3:"d", q4:"b", q5:"a", q6:"d", q7:"c", q8:"b", q9:"a", q10:"c" },
  "NR-35": { q1:"c", q2:"a", q3:"b", q4:"d", q5:"c", q6:"b", q7:"a", q8:"d", q9:"c", q10:"a" },
  "NR-05": { q1:"a", q2:"b", q3:"c", q4:"d", q5:"a", q6:"b", q7:"c", q8:"d", q9:"a", q10:"b" },
  "NR-06": { q1:"b", q2:"c", q3:"a", q4:"d", q5:"b", q6:"c", q7:"a", q8:"d", q9:"b", q10:"c" },
};

// ====== NÃO PRECISA EDITAR DAQUI PRA BAIXO ======
function text(el){ return (el?.textContent||"").trim(); }
function bySel(s,root=document){ return root.querySelector(s); }
function bySelAll(s,root=document){ return Array.from(root.querySelectorAll(s)); }

document.addEventListener("DOMContentLoaded", () => {
  const form = bySel("form");
  if(!form) return;

  // Campo/área para exibir a nota (se não existir, cria)
  let placar = bySel("#placar-nota");
  if(!placar){
    placar = document.createElement("div");
    placar.id = "placar-nota";
    placar.style.margin = "16px 0";
    placar.style.fontWeight = "600";
    form.prepend(placar);
  }

  // Campo hidden para enviar/compartilhar a nota
  let notaHidden = bySel("#nota");
  if(!notaHidden){
    notaHidden = document.createElement("input");
    notaHidden.type = "hidden";
    notaHidden.name = "nota";
    notaHidden.id = "nota";
    form.appendChild(notaHidden);
  }

  // Identifica qual NR o aluno está fazendo
  function detectarNR(){
    const c1 = bySel('[name="nr"]') || bySel("#nr") || bySel('input[placeholder*="NR"]');
    const v = (c1?.value || "").trim().toUpperCase();
    if(v.startsWith("NR-")) return v;
    const opt = bySel("select, input");
    const vv = (opt?.value||"").toUpperCase();
    return vv.startsWith("NR-") ? vv : "NR-1";
  }

  function lerRespostasMarcadas(){
    const resp = {};
    const radios = bySelAll('input[type="radio"]');
    const grupos = new Set(radios.map(r => r.name));
    grupos.forEach(name=>{
      const sel = bySel(`input[name="${name}"]:checked`);
      if(sel){ resp[name] = (sel.value||"").toLowerCase(); }
    });
    return resp;
  }

  function corrigir(){
    const nr = detectarNR();
    const gab = GABARITOS[nr] || {};
    const marcadas = lerRespostasMarcadas();

    const questoes = Object.keys(gab);
    let total = questoes.length;
    let acertos = 0;

    questoes.forEach(q=>{
      if((marcadas[q]||"") === (gab[q]||"")) acertos++;
    });

    if(total === 0){
      placar.textContent = "Nota: 0 (sem gabarito definido para " + nr + ")";
      notaHidden.value = "0";
      return {nota:0, acertos:0, total:0};
    }

    const nota = Math.round((acertos/total)*100);
    placar.textContent = `Nota: ${nota} | Acertos: ${acertos}/${total}`;
    notaHidden.value = String(nota);

    try{
      const nome = bySel('[name="nome"], [name="aluno"]')?.value || "";
      const cpf  = bySel('[name="cpf"]')?.value || "";
      const data = bySel('[name="dataAvaliacao"]')?.value || "";
      localStorage.setItem("nota", String(nota));
      localStorage.setItem("aluno", nome);
      localStorage.setItem("cpf", cpf);
      localStorage.setItem("nr", nr);
      localStorage.setItem("dataAvaliacaoISO", data);
    }catch(e){}
    return {nota, acertos, total};
  }

  form.addEventListener("change", corrigir);
  form.addEventListener("submit", corrigir);
  corrigir();
});
