const p = new URLSearchParams(location.search);
const curso = (p.get("curso")||"nr1").toLowerCase();
const file = `assets/questions/${curso}.json`;
fetch(file).then(r=>r.json()).then(data=>{
  const f=document.getElementById("quizForm");
  data.forEach((q,i)=>{
    let d=document.createElement("div");
    d.innerHTML=`<p class='font-semibold'>${i+1}. ${q.q}</p>`+q.a.map((op,j)=>`<label><input type='radio' name='q${i}' value='${j}'> ${op}</label>`).join("<br>");
    f.appendChild(d);
  });
  document.getElementById("enviar").onclick=()=>{
    let ac=0;
    data.forEach((q,i)=>{const v=document.querySelector(`[name=q${i}]:checked`);if(v&&+v.value===q.c)ac++;});
    const nota=Math.round(ac/data.length*100);
    document.getElementById("res").textContent=`Acertos: ${ac}/${data.length} Nota: ${nota}%`;
  };
});
