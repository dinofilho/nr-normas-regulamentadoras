(function(){
  const NRS=[["NR-1","nr1"],["NR-5","nr05"],["NR-6","nr06"],["NR-10","nr10"],["NR-20","nr20"],["NR-33","nr33"],["NR-35","nr35"]];
  const wrap=document.createElement("div");
  wrap.style.margin="16px auto";wrap.style.maxWidth="920px";wrap.style.padding="0 16px";
  wrap.innerHTML = `
    <div style="background:#0f172a;color:#fff;border-radius:12px;padding:14px 16px;box-shadow:0 2px 8px rgba(0,0,0,.15);">
      <div style="font-weight:700;margin-bottom:10px">Avaliações rápidas</div>
      <div id="nr-cta-grid" style="display:flex;flex-wrap:wrap;gap:8px"></div>
    </div>`;
  const grid=wrap.querySelector("#nr-cta-grid");
  NRS.forEach(([rotulo,slug])=>{
    const a=document.createElement("a");
    a.href=`quiz.html?curso=${slug}`;
    a.textContent=`Fazer avaliação ${rotulo}`;
    a.style.cssText="background:#2563eb;color:#fff;text-decoration:none;border-radius:10px;padding:8px 12px;font-weight:600;display:inline-block";
    grid.appendChild(a);
  });
  // injeta logo depois do primeiro h1 ou no topo
  const h1=document.querySelector("h1, .titulo, .page-title")||document.body.firstElementChild;
  (h1 && h1.parentNode) ? h1.parentNode.insertBefore(wrap, h1.nextSibling) : document.body.prepend(wrap);
})();
