(function(){
  const saved = JSON.parse(localStorage.getItem("cert_dados")||"{}");
  const fmtData = (iso)=>{
    try{ const d = new Date(iso); return d.toLocaleDateString("pt-BR"); }catch(e){ return "-"; }
  };
  document.getElementById("curso").value = saved.curso || "-";
  document.getElementById("nota").value  = (saved.nota!=null ? saved.nota+"%" : "-");
  document.getElementById("data").value  = saved.data ? fmtData(saved.data) : fmtData(new Date().toISOString());
  if(saved.aluno) document.getElementById("aluno").value = saved.aluno;
  if(saved.cpf)   document.getElementById("cpf").value   = saved.cpf;

  document.getElementById("btnPDF").onclick = ()=>{
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF({unit:"pt", format:"a4"});
    const L = 80; let y = 120;
    doc.setFontSize(18);
    doc.text("COMPROVANTE DE AVALIAÇÃO (TEORIA – EAD)", 300, 80, {align:"center"});
    doc.setFontSize(12);
    const get = id => document.getElementById(id).value||"";
    const linhas = [
      "Aluno: " + get("aluno"),
      "CPF: " + get("cpf"),
      "Cidade/UF: " + get("cidade") + " / " + get("uf"),
      "Curso/NR: " + get("curso"),
      "Nota: " + get("nota"),
      "Data da avaliação: " + get("data")
    ];
    linhas.forEach(t => { doc.text(t, L, y); y+=22; });
    doc.text("Observação: quando houver PRÁTICA obrigatória, registrar a parte prática separadamente.", L, y+20);
    doc.save("comprovante-avaliacao.pdf");
  };
})();
