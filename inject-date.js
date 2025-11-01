// inject-date.js (NRs) - adiciona "Data da Avaliação" em todos os formulários
(function () {
  function yyyyMMdd(d){const y=d.getFullYear(),m=String(d.getMonth()+1).padStart(2,"0"),da=String(d.getDate()).padStart(2,"0");return `${y}-${m}-${da}`;}
  function addDateField(form){
    if (!form || form.dataset.dateInjected === "1") return;
    if (form.querySelector('input[name="dataAvaliacao"]')) { form.dataset.dateInjected = "1"; return; }

    const wrap = document.createElement("div");
    wrap.style.margin = "12px 0";

    const label = document.createElement("label");
    label.htmlFor = "dataAvaliacao";
    label.textContent = "Data da Avaliação:";
    label.style.display = "block";
    label.style.marginBottom = "6px";
    label.style.fontWeight = "bold";

    const input = document.createElement("input");
    input.type = "date";
    input.id = "dataAvaliacao";
    input.name = "dataAvaliacao";
    input.required = true;
    input.value = yyyyMMdd(new Date());

    wrap.appendChild(label); wrap.appendChild(input);

    const submit = form.querySelector('button[type="submit"], input[type="submit"]');
    if (submit && submit.parentNode) submit.parentNode.insertBefore(wrap, submit);
    else form.appendChild(wrap);

    form.dataset.dateInjected = "1";
  }

  function scan(){ document.querySelectorAll("form").forEach(addDateField); }

  // Inicial após DOM pronto
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", scan);
  } else { scan(); }

  // Observa mudanças (SPA/conteúdo injetado)
  const mo = new MutationObserver((muts)=>{
    for (const m of muts){
      m.addedNodes && m.addedNodes.forEach(n=>{
        if (n.nodeType===1){
          if (n.tagName==="FORM") addDateField(n);
          n.querySelectorAll && n.querySelectorAll("form").forEach(addDateField);
        }
      });
    }
  });
  mo.observe(document.documentElement, { childList:true, subtree:true });
})();
