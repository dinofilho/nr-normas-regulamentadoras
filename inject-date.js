(function () {
  function addField(form){
    if (form.querySelector('input[name="dataAvaliacao"]')) return;

    const wrap = document.createElement('div');
    wrap.style.margin = '12px 0';

    const label = document.createElement('label');
    label.htmlFor = 'dataAvaliacao';
    label.textContent = 'Data da Avaliação:';
    label.style.display = 'block';
    label.style.marginBottom = '6px';
    label.style.fontWeight = 'bold';

    const input = document.createElement('input');
    input.type = 'date';
    input.id = 'dataAvaliacao';
    input.name = 'dataAvaliacao';
    input.required = true;

    const t = new Date();
    const yyyy = t.getFullYear();
    const mm = String(t.getMonth() + 1).padStart(2,'0');
    const dd = String(t.getDate()).padStart(2,'0');
    input.value = `${yyyy}-${mm}-${dd}`;

    wrap.appendChild(label);
    wrap.appendChild(input);

    const submit = form.querySelector('button[type="submit"], input[type="submit"]');
    if (submit && submit.parentNode) submit.parentNode.insertBefore(wrap, submit);
    else form.appendChild(wrap);
  }

  function scan(){ document.querySelectorAll('form').forEach(addField); }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', scan);
  } else {
    scan();
  }

  // cobre formulários inseridos depois (React/JS)
  const obs = new MutationObserver(() => scan());
  obs.observe(document.documentElement, { childList: true, subtree: true });
})();
