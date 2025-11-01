const GABARITOS={
  "NR-1":  {q1:"c",q2:"b",q3:"a",q4:"d",q5:"b",q6:"a",q7:"d",q8:"c",q9:"b",q10:"c"},
  "NR-05": {q1:"a",q2:"a",q3:"b",q4:"b",q5:"a",q6:"a",q7:"b",q8:"b",q9:"a",q10:"a"},
  "NR-06": {q1:"a",q2:"b",q3:"b",q4:"a",q5:"b",q6:"a",q7:"b",q8:"b",q9:"a",q10:"c"},
  "NR-10": {q1:"b",q2:"c",q3:"a",q4:"d",q5:"b",q6:"a",q7:"c",q8:"b",q9:"a",q10:"d"},
  "NR-20": {q1:"b",q2:"b",q3:"b",q4:"c",q5:"b",q6:"a",q7:"b",q8:"b",q9:"b",q10:"b"},
  "NR-33": {q1:"a",q2:"c",q3:"c",q4:"a",q5:"b",q6:"b",q7:"a",q8:"c",q9:"b",q10:"c"},
  "NR-35": {q1:"c",q2:"b",q3:"c",q4:"c",q5:"b",q6:"b",q7:"b",q8:"b",q9:"b",q10:"b"}
};
function $(s,r=document){return r.querySelector(s)}
function $all(s,r=document){return Array.from(r.querySelectorAll(s))}
function detectarNR(){
  const p=new URLSearchParams(location.search);
  const raw=(p.get("curso")||"nr1").toUpperCase().replace(/[^A-Z0-9-]/g,"");
  return raw.startsWith("NR-")?raw:("NR-"+raw.replace("NR",""));
}
function corrigir(){
  const nr=detectarNR();
  const gab=GABARITOS[nr]||{};
  const qs=Object.keys(gab);
  const marc={}; $all("input[type=radio]:checked").forEach(r=>marc[r.name]=r.value);
  let ok=0; qs.forEach(q=>{ if((marc[q]||"")==(gab[q]||"")) ok++; });
  const nota=qs.length?Math.round(ok/qs.length*100):0;
  const plac=$("#placar-nota"); if(plac) plac.textContent=`Nota: ${nota} | Acertos: ${ok}/${qs.length}`;
  const hid=$("#nota"); if(hid) hid.value=String(nota);
  try{
    localStorage.setItem("nota",String(nota));
    localStorage.setItem("aluno",$("#nome")?.value||"");
    localStorage.setItem("cpf",$("#cpf")?.value||"");
    localStorage.setItem("nr",nr);
    localStorage.setItem("dataAvaliacaoISO",$("#dataAvaliacao")?.value||"");
  }catch(e){}
}
document.addEventListener("change",corrigir,true);
document.addEventListener("DOMContentLoaded",()=>{
  if(!$("#placar-nota")){
    const d=document.createElement("div");
    d.id="placar-nota"; d.style.margin="16px 0"; d.style.fontWeight="600";
    (document.querySelector(".card")||document.body).prepend(d);
  }
  if(!$("#nota")){
    const h=document.createElement("input");
    h.type="hidden"; h.id="nota"; h.name="nota";
    (document.querySelector("form")||document.querySelector(".card")||document.body).appendChild(h);
  }
  corrigir();
});
