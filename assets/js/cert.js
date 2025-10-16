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
