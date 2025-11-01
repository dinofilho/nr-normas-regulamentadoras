// inject-date.js
(function () {
  const forms = document.querySelectorAll("form");
  forms.forEach((form) => {
    if (form.querySelector("input[name=\"dataAvaliacao\"]")) return;
    const wrapper = document.createElement("div");
    wrapper.style.margin = "12px 0";
    const label = document.createElement("label");
    label.setAttribute("for", "dataAvaliacao");
    label.textContent = "Data da Avaliação:";
    label.style.display = "block";
    label.style.marginBottom = "6px";
    label.style.fontWeight = "bold";
    const input = document.createElement("input");
    input.type = "date";
    input.id = "dataAvaliacao";
    input.name = "dataAvaliacao";
    input.required = true;
    const hoje = new Date();
    const yyyy = hoje.getFullYear();
    const mm = String(hoje.getMonth() + 1).padStart(2, "0");
    const dd = String(hoje.getDate()).padStart(2, "0");
    input.value = `${yyyy}-${mm}-${dd}`;
    wrapper.appendChild(label);
    wrapper.appendChild(input);
    const submit = form.querySelector("button[type=\"submit\"], input[type=\"submit\"]");
    if (submit && submit.parentNode) {
      submit.parentNode.insertBefore(wrapper, submit);
    } else {
      form.appendChild(wrapper);
    }
  });
})();
