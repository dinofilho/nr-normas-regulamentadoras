document.addEventListener("DOMContentLoaded", () => {
  try {
    // remove qualquer cabeçalho antigo de data (pra não confundir)
    const oldTop = document.getElementById("dataHora");
    if (oldTop) oldTop.remove();

    const form = document.querySelector("form");
    if (!form) return;

    // achar o campo de e-mail (várias heurísticas)
    const emailCandidates = Array.from(document.querySelectorAll(
      "input[type=email], input[name*=mail i], input[placeholder*=mail i]"
    ));
    const email = emailCandidates[0];

    // caso não encontre, criaremos a data no topo do form
    const targetForInsert = email || form;

    // já existe?
    if (document.getElementById("dataAvaliacao")) return;

    // data local em ISO (yyyy-mm-dd) — sem UTC
    const today = new Date();
    const yyyy = String(today.getFullYear());
    const mm   = String(today.getMonth() + 1).padStart(2, "0");
    const dd   = String(today.getDate()).padStart(2, "0");
    const iso  = `${yyyy}-${mm}-${dd}`;

    // cria wrapper + label + input date
    const wrapper = document.createElement("div");
    wrapper.className = "mt-3";

    const label = document.createElement("label");
    label.setAttribute("for", "dataAvaliacao");
    label.className = "block text-sm font-medium mb-1";
    label.textContent = "Data da avaliação";

    const input = document.createElement("input");
    input.type = "date";
    input.id = "dataAvaliacao";
    input.name = "dataAvaliacao";
    input.value = iso;

    // herda classe visual do campo de e-mail se existir
    const classLike = email ? (email.className || "") : "";
    input.className = classLike || "border rounded px-3 py-2 w-full";

    wrapper.appendChild(label);
    wrapper.appendChild(input);

    // inserir logo ABAIXO do e-mail; se não houver e-mail, no topo do form
    if (email) {
      // tenta inserir após o container do e-mail (fica mais bonito)
      const container = email.closest(".mb-4, .mt-3, .space-y-4, .form-group") || email;
      container.insertAdjacentElement("afterend", wrapper);
    } else {
      form.insertAdjacentElement("afterbegin", wrapper);
    }

    // garantir campo oculto dataEnvio (dd/mm/aaaa - HH:MM)
    let hidden = form.querySelector("input[name=dataEnvio]");
    if (!hidden) {
      hidden = document.createElement("input");
      hidden.type = "hidden";
      hidden.name = "dataEnvio";
      form.appendChild(hidden);
    }

    function syncHidden() {
      const v = input.value || iso;
      if (!v) return;
      const [Y, M, D] = v.split("-");
      const hora = new Date().toLocaleTimeString("pt-BR", { hour:"2-digit", minute:"2-digit" });
      hidden.value = `${D}/${M}/${Y} - ${hora}`;
    }

    // sincroniza agora e nos eventos
    syncHidden();
    input.addEventListener("change", syncHidden, true);
    form.addEventListener("submit", syncHidden, true);
  } catch (e) {
    console.error("inject-date.js robust error:", e);
  }
});
